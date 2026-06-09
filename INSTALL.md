# 详细安装指南

> 从零开始安装 PM-OS。如果你之前没用过 Claude Code，按本指南一步一步来。

---

## 前置准备（一次性）

### 1. 安装 Claude Code

```bash
# Mac / Linux：
curl -fsSL https://claude.ai/install.sh | bash

# Windows：需要 WSL（Windows Subsystem for Linux）
# 在 WSL Ubuntu 里运行上面的命令
```

或用 npm：

```bash
npm install -g @anthropic-ai/claude-code
```

### 2. 登录

```bash
claude
# 跟着提示登录 Anthropic 账号
# 需要 Claude Pro / Max 订阅（$20/月 起）
```

### 3. （可选）在 Cursor 里集成

打开 Cursor → Extensions（`Cmd+Shift+X` / `Ctrl+Shift+X`）→ 搜 "Claude Code" → 安装。

或者直接在 Cursor 集成终端里运行 `claude` 也行。

---

## 安装 PM-OS

### 方式 A：一键脚本（推荐）

```bash
# 把 pm-os 文件夹放到你想要的位置
cd ~  # 或任何你想的目录

# 解压（如果是 zip）
unzip pm-os.zip

# 或直接拷贝
cp -r /path/to/downloaded/pm-os ./

# 进入并初始化
cd pm-os
bash install.sh
```

`install.sh` 会做这些事：
1. 检查 Claude Code 是否安装
2. 创建必要目录
3. 提示你填 CLAUDE.md 里的占位符
4. 验证所有 skill 文件格式正确

### 方式 B：手动安装

```bash
# 1. 把整个 pm-os/ 文件夹放到你的工作目录
mv pm-os ~/my-pm-workspace

# 2. 进入
cd ~/my-pm-workspace

# 3. 编辑 CLAUDE.md，把 [请填写] 换成真实信息
nano CLAUDE.md
# 或用任何你喜欢的编辑器

# 4. 启动 Claude Code
claude
```

---

## 个性化配置（5 分钟，但回报极高）

### 必填：CLAUDE.md

打开 `CLAUDE.md`，填写：

```markdown
**关于我的信息**：
- 所在公司/行业：[填写，例如：B2B SaaS / 消费互联网 / 金融科技]
- 当前在做的产品方向：[填写]
- 我的资历级别：[初级 PM / 中级 PM / 高级 PM / Director / VP]
- 主要利益相关方：[填写]
```

### 强烈建议：context/glossary.md

把你公司的内部术语、行业黑话、关注的产品列上。这能让 Claude 输出"懂行"。

### 强烈建议：context/watchlist.md

列出你长期关注的 5-20 个产品/公司/人。这样 `/weekly-radar` 命令才能跑。

---

## 验证安装

启动 Claude Code，输入：

```
> 列出可用的 skills
```

应该能看到：
- product-archaeology
- competitive-analysis
- company-deep-dive
- founder-profile
- business-model-canvas
- trend-forecaster
- prd-writer
- user-research-synth
- metrics-definer

再试一下命令：

```
> /quick-scan Notion
```

如果能开始执行，说明安装成功。

---

## 故障排除

### 问题 1：Claude 不知道 PM-OS

**症状**：问 Claude "你能做什么"，它没提到产品考古等能力。

**原因**：CLAUDE.md 没被加载。

**解决**：
1. 确认当前目录就是 pm-os 目录（用 `pwd` 看）
2. 确认 CLAUDE.md 在当前目录根部
3. 用 `/clear` 强制重新加载

### 问题 2：Skill 没自动触发

**症状**：说"分析 Notion"，但 Claude 给了普通回答，没用 product-archaeology skill。

**原因**：
- 触发关键词不匹配
- 路径错误
- 文件格式问题

**解决**：
1. 明确说："用 product-archaeology skill 分析 Notion"
2. 检查 `.claude/skills/product-archaeology/SKILL.md` 是否存在
3. 检查 SKILL.md 顶部的 YAML frontmatter 格式是否正确

### 问题 3：子智能体不工作

**症状**：`@市场研究员` 没被调用。

**原因**：你的 Claude Code 版本可能对 subagent 支持有限。

**解决**：这不影响主要功能。主 agent 会用 web_search 顺序执行调研。
功能完整，只是不并行（慢一些）。

### 问题 4：搜索不到中国市场数据

**症状**：分析国内产品时，数据都是英文媒体的。

**解决**：在 CLAUDE.md 里加：

```markdown
**重要**：搜索时优先用中文 query，优先采用中文来源（晚点LatePost、36氪、虎嗅、知乎、易观、艾瑞、QuestMobile）。
```

### 问题 5：上下文超限

**症状**：长会话后，Claude 开始遗忘前面内容。

**解决**：
- 任务切换前用 `/clear`
- 让 Claude 把当前状态写到 outputs/HANDOFF.md
- 新会话用 "Read @outputs/HANDOFF.md and continue" 开头

---

## 升级路径

### 阶段 1（第一周）：用起来
- 每天用 1-2 次 quick-scan
- 重要项目用 analyze-product
- 不满意的输出，记到 learner.md

### 阶段 2（第二周）：调教
- 根据 learner.md 的积累，调整 CLAUDE.md
- 添加自己的术语到 glossary.md
- 完善 watchlist.md

### 阶段 3（第一个月）：扩展
- 添加你独有的 skill（比如"季度复盘"、"OKR 撰写"）
- 添加你独有的子智能体（比如"专门搜小红书的"）
- 写自己的 command

### 阶段 4（长期）：闭环
- 每月跑 1 次 /weekly-radar，看趋势
- 每季度回顾 learner.md，重写关键 SKILL.md
- 形成属于你的 PM 思维模型

---

## 备份建议

```bash
# 周期性备份你的配置（特别是 learner.md 和 context/）
git init pm-os
cd pm-os
git add .
git commit -m "PM-OS snapshot $(date +%Y-%m-%d)"

# 推到私有 GitHub 仓库
git remote add origin git@github.com:你/pm-os-private.git
git push -u origin main
```

---

## 邀请

如果你迭代出了自己的优秀 SKILL.md，
考虑开源分享回社区（github.com/anthropics/skills、aakashg/pm-claude-skills 都收 PR）。

让我们一起把 PM 这个职业升级。
