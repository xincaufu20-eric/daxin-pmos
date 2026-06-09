# Playwright MCP 实地走查 SOP

> 这是 PM AI 工作台的"产品实地登录走查"标准操作流程。
> 所有产品分析任务,只要目标产品需要登录才能看核心,都必须按这套 SOP 走。

---

## 一、能力定位

Playwright MCP 让 Claude 拥有一个真实的 Chromium 浏览器,能:

| 能力 | 说明 |
|---|---|
| ✅ 打开任意 URL | 不受 WebFetch 的域名拦截限制 |
| ✅ 登录任何站点 | 持久化 profile,登录一次后续复用 |
| ✅ 读 DOM accessibility tree | 结构化感知页面,比纯截图更准 |
| ✅ 截图 / 录屏 | 视觉证据保留 |
| ✅ 点击 / 输入 / 滚动 | 模拟真实用户操作,跑完整流程 |
| ✅ 读 console / network | 看错误日志、API 请求 |

---

## 二、安装(一次性,5 分钟)

### Step 1: 确认 .mcp.json 已存在

项目根目录已经有 `.mcp.json` 文件,内容如下:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": [
        "-y",
        "@playwright/mcp@latest",
        "--user-data-dir=<YOUR_HOME>/.cache/playwright-mcp-profile",
        "--viewport-size=1440,900"
      ]
    }
  }
}
```

说明:
- `--user-data-dir` —— 用持久化 profile,登录态会保存在 `~/.cache/playwright-mcp-profile/`,下次 Claude 启动会自动复用
- `--viewport-size=1440,900` —— 模拟 MacBook Pro 13" 默认视口

### Step 2: 重启 Claude Code

在 Claude Code 里输入 `/exit` 退出,然后重新打开。Claude Code 会读取项目根目录的 `.mcp.json`,首次加载会问你是否信任这个 MCP server,选 **Yes**。

### Step 3: 验证 MCP 连接

重启后,在 Claude Code 输入:
```
/mcp
```

应该看到:
```
playwright    ✓ connected
```

### Step 4: 首次跑测试(可选)

让 Claude 跑一句:
```
用 Playwright MCP 打开 https://example.com,截个图给我看
```

如果能看到图,装好了。

---

## 三、登录产品(每个新产品做一次)

Playwright MCP 默认 headless 模式,不会弹出浏览器窗口。要让 Claude 用你的登录态访问产品,有三种模式:

### 模式 A: Claude 自动登录(凭据交给 Claude,有安全风险)

适合:测试账号、非核心账号
风险:Claude 会看到你的密码

操作:
```
请用 Playwright MCP 登录 creatify.ai,账号 xxx,密码 yyy,然后访问 dashboard 截图
```

### 模式 B: 用持久化 profile,先手动登录一次(推荐)

适合:正式账号
原理:打开非 headless 模式让你手动登录一次,登录态保存在 `--user-data-dir` 指定的目录,之后所有 session 复用

操作(在 Claude Code 之外,在终端跑一次):
```bash
npx -y @playwright/mcp@latest \
  --user-data-dir=<YOUR_HOME>/.cache/playwright-mcp-profile \
  --browser chromium \
  --headed
```

这会弹一个浏览器窗口。你手动:
1. 打开目标产品(如 creatify.ai)
2. 完成登录(可以用 Google SSO / 邮箱密码 / 手机号都行)
3. 看到 dashboard 后,关闭窗口

之后回到 Claude Code,Claude 用同一个 profile 启动 MCP 时,登录态自动恢复。**这个登录态会持续到你清空 `~/.cache/playwright-mcp-profile/`**。

### 模式 C: CDP 连接你已经开着的 Chrome(高级)

适合:不想再开一个浏览器、想让 Claude 直接复用你日常用的 Chrome session
风险:Claude 能看到你 Chrome 里所有 tab 和数据

操作:
1. 先用 `--remote-debugging-port=9222` 启动你的 Chrome
2. 改 `.mcp.json` 加 `"--cdp-endpoint=http://localhost:9222"` 参数

通常用不到模式 C,模式 B 已经够用。

---

## 四、Claude 怎么用这个能力(给 PM 看的简化版)

你不用记 MCP 命令,只需要在分析产品时跟 Claude 说:

```
分析 XX 产品 (URL: ...)
```

或者:

```
@产品体验员 走查(需登录):{URL},重点看 dashboard/模板库/生成流程
```

Claude 会自动按「产品体验员」agent 的工作流跑:
1. 检测到工具列表里有 `mcp__playwright__*` → 优先用 Playwright
2. 打开目标产品的核心页面(P0 优先级)
3. 读 DOM + 截图 + 跑完整流程
4. 输出走查报告

如果登录态失效(模式 B 的 profile 过期了),Claude 会告诉你"需要重新登录",你按 Step 3 模式 B 再跑一次手动登录就行。

---

## 五、常见问题

### Q1: Playwright MCP 第一次跑很慢?

第一次会下载 Chromium 浏览器(~150MB),只下载一次。之后启动很快。

### Q2: 跑了一段时间 profile 变大?

`~/.cache/playwright-mcp-profile/` 会累积 cookies、缓存、localStorage。如果太大或想清理,直接 `rm -rf ~/.cache/playwright-mcp-profile/` 即可,下次会重建。

### Q3: 不同产品想用不同账号?

为每个产品建一个独立 profile:
```json
"--user-data-dir=<YOUR_HOME>/.cache/playwright-mcp-creatify"
```

或者就用一个共享 profile,Playwright 自己处理 cookie 隔离(每个域名独立 session)。

### Q4: MCP 连不上?

检查:
1. `which npx` 应该输出 `<YOUR_HOME>/.local/bin/npx`
2. 跑一次 `npx -y @playwright/mcp@latest --help`,看能否启动
3. Claude Code 里跑 `/mcp` 看连接状态
4. 看 Claude Code 日志(macOS 在 `~/Library/Logs/Claude/`)

### Q5: 网站有反自动化检测(reCAPTCHA、Cloudflare),Playwright 被拦?

Playwright MCP 用真实 Chromium,大部分情况能过。如果遇到强反爬:
- 切换到模式 C(CDP 复用你日常 Chrome)成功率最高
- 或回退到"用户截图发给 Claude"模式

---

## 六、安全边界

- ⚠️ `--user-data-dir` 目录里会有 cookies/session token,**等同你的登录态**。不要把这个目录上传 GitHub,不要分享给他人
- ⚠️ Claude 在浏览器里看到的所有内容都会进对话上下文,如果产品里有敏感信息(支付详情、私信),别让 Claude 走查这些页面
- ⚠️ 模式 A(直接给 Claude 凭据)不推荐用于核心账号,Claude 的对话日志可能被云端保存

---

## 七、何时不用 Playwright MCP

不是所有任务都需要 Playwright。下面这些情况用更轻量的工具:

| 场景 | 用什么 |
|---|---|
| 抓个静态营销页 | WebFetch |
| 搜行业数据 | WebSearch |
| 抓 GitHub README | WebFetch |
| 看历史快照 | Wayback Machine + WebFetch |
| 用户已截图 | 直接读图,不用浏览器 |

**只有"需要登录"、"需要点击/输入"、"需要看 SPA 动态内容"这三种场景,才用 Playwright MCP**。

---

最后更新:2026-06-08
