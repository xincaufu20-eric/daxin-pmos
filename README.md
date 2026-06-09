# PM-OS：产品经理的 AI 工作台（全套 C 方案）

> 一套为产品经理量身定制的 Claude Code 配置。
> 60 秒装好，让 AI 助手秒变你的私人产品研究员、竞品分析师、战略顾问。
>
> 灵感来源：Aakash Gupta、VoltAgent、Dean Peters、Anthropic Skills 团队等开源大神。

---

## 🎯 这个工作台能干什么

| 一句话指令 | 你得到什么 | 时间 |
|---|---|---|
| `/analyze-product Notion` | Notion 的完整产品考古报告（前世今生未来） | 30 分钟 |
| `/quick-scan Linear` | Linear 的精简速览卡 | 10 分钟 |
| `/compare Figma vs Sketch vs Framer` | 三个产品的全维度对比 | 20 分钟 |
| `/founder Sam Altman` | Sam Altman 的决策风格画像 | 15 分钟 |
| `/weekly-radar` | 你关注领域的本周动态 | 5 分钟 |
| 直接说"分析 Figma" | 自动触发「产品考古」skill | 30 分钟 |
| 直接说"写个 PRD" | 自动触发「PRD编写」skill（先问 3-5 个澄清问题） | 15 分钟 |

---

## 📦 包含什么

```
pm-os/
├── CLAUDE.md                          # 主控制文件（每次启动自动加载）
├── README.md                          # 你在看的这个
├── INSTALL.md                         # 详细安装说明
├── learner.md                         # 学习日志（Claude 自维护）
├── install.sh                         # 一键安装脚本
├── .claude/
│   ├── skills/                        # 11 个核心 skill（全中文命名）
│   │   ├── 产品考古/                  # 🔥 产品考古（核心）
│   │   ├── 产品交互走查/              # 🔥 UX 审计
│   │   ├── 竞品分析/                  # 🔥 竞品分析
│   │   ├── 定价反推/                  # 🔥 定价反推 + 沉淀利润
│   │   ├── 公司深度分析/              # 公司深度分析
│   │   ├── 创始人画像/                # 创始人画像
│   │   ├── 商业画布/                  # 商业画布
│   │   ├── 趋势预测/                  # 趋势预测
│   │   ├── PRD编写/                   # PRD 撰写
│   │   ├── 用户研究综合/              # 用户研究综合
│   │   └── 指标定义/                  # 指标定义
│   ├── agents/                        # 9 个子智能体（全中文命名）
│   │   ├── 产品体验员.md              # 实地走查（三件套之一）
│   │   ├── 定价侦探.md                # 定价反推（三件套之一）
│   │   ├── 用户声音侦察员.md          # 真实用户评论（三件套之一）
│   │   ├── 市场研究员.md
│   │   ├── 竞品分析师.md
│   │   ├── 创始人调查员.md
│   │   ├── 趋势分析师.md
│   │   ├── 数据综合师.md
│   │   └── 怀疑论审查员.md
│   └── commands/                      # 5 个一键命令
│       ├── analyze-product.md
│       ├── quick-scan.md
│       ├── compare.md
│       ├── founder.md
│       └── weekly-radar.md
├── context/                           # 你的领域知识
│   ├── watchlist.md                   # 关注雷达列表
│   ├── glossary.md                    # 术语表
│   └── playwright-mcp-sop.md          # Playwright MCP 实地走查 SOP
├── templates/                         # 产物模板
│   ├── product-archaeology-template.md
│   ├── competitive-matrix-template.md
│   └── prd-template.md
└── outputs/                           # Claude 生成的产出保存在这
```

---

## 🚀 快速开始（3 步，60 秒）

### Step 1：装到你的工作目录

把整个 `pm-os/` 文件夹拷贝到你的项目根目录或专用工作目录：

```bash
# 方式 1：直接复制
cp -r /path/to/pm-os ~/my-pm-workspace

# 方式 2：用安装脚本
./install.sh ~/my-pm-workspace
```

### Step 2：填写个人信息

打开 `CLAUDE.md` 和 `context/glossary.md`，把 `[请填写]` 部分换成你的真实信息。
（这一步会显著提升输出质量）

### Step 3：在 Cursor 里启动

```bash
cd ~/my-pm-workspace
claude
```

试一下：

```
> /analyze-product Notion
```

或：

```
> 分析一下飞书的前世今生
```

---

## 💡 使用心法（来自大神们的经验）

### 1. 先问后做（来自 Aakash Gupta）
所有复杂 skill 都会先问 3-5 个澄清问题。**不要嫌烦**——这能让输出质量翻倍。
如果赶时间，输入"直接做"跳过。

### 2. 多视角审查链
写完任何重要分析后，主动做 3 轮审查：

```
> 审查 as 投资人
> 审查 as 竞争对手
> 审查 as 用户
```

### 3. 用 `/clear` 防止上下文污染
任务切换前敲 `/clear`，避免 PRD 思路污染竞品分析。

### 4. 给原始材料，别给摘要
分析用户访谈时，**粘贴 transcript 全文**，别说"用户都觉得 X"。
Claude 从原始材料里提取，比从你的总结里提取效果好 10 倍。

### 5. 持续打磨 SKILL.md
发现某类任务 Claude 总是没做对？把你的修改记录到 `learner.md`，
出现 5 次后让 Claude 帮你更新 SKILL.md。

### 6. 别迷信
Claude 不是真理，是工作放大器。所有结论自己再过一遍脑子。

---

## 🛠️ 如何扩展

### 添加新 skill
```bash
mkdir .claude/skills/your-skill-name
touch .claude/skills/your-skill-name/SKILL.md
```

SKILL.md 必须有 YAML frontmatter：

```markdown
---
name: your-skill-name
description: 详细写明触发场景和关键词
---

# 你的 skill 内容
```

### 添加新子智能体
```bash
touch .claude/agents/your-agent.md
```

格式参考已有的 9 个 agent。

### 添加新命令
```bash
touch .claude/commands/your-command.md
```

---

## 📚 灵感来源

如果你想深入研究，推荐看：

| 项目 | 链接 | 价值 |
|---|---|---|
| Aakash Gupta 的 PM Setup | github.com/aakashg/pm-claude-code-setup | 简洁的 PM 起步模板 |
| VoltAgent 100+ subagents | github.com/VoltAgent/awesome-claude-code-subagents | 高质量子智能体库 |
| Dean Peters 的 PM Skills | github.com/deanpeters/Product-Manager-Skills | 教学型 PM skill 库 |
| Anthropic 官方 Skills | github.com/anthropics/skills | 官方最佳实践 |
| Mahesh Yadav 的 Builder PM | news.aakashg.com | learner.md 闭环灵感 |

---

## ⚠️ 常见问题

### Q：Claude 不触发 skill 怎么办？
- 检查 `.claude/skills/<name>/SKILL.md` 路径是否正确
- 检查 description 里的触发关键词是否清晰
- 试试明确说："用 product-archaeology skill 分析 X"

### Q：CLAUDE.md 改了不生效？
- 用 `/clear` 重置上下文
- CLAUDE.md 是会话开始时加载的，中途改要重启

### Q：上下文爆掉了怎么办？
- 长任务前用 `/clear`
- 用 `@文件` 引用而不是粘贴大段内容
- 让 Claude 写 HANDOFF.md 给下一会话

### Q：子智能体没调用？
- Claude Code 在某些版本对 subagent 支持不同
- 如果 @agent 语法不工作，主 agent 会顺序执行（功能完整，只是不并行）

---

## 📄 License

MIT - 随便用，随便改，随便分享。

---

## 🤝 反馈

这套配置基于 2026 年 5 月的最佳实践整合。
如果你的实践中有更好的方法，欢迎迭代——这就是 learner.md 存在的意义。

Happy PM-ing! 🚀
