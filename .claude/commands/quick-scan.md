---
description: 快速产品速览（10 分钟版）。用法：/quick-scan 产品名
---

对产品「$ARGUMENTS」进行 10 分钟快速扫描。

不需要澄清问题，直接执行：

## 执行流程

### Step 1：单 agent 模式（不调度子 agent）

主 agent 用 web_search 顺序执行 5 个查询：

1. `$ARGUMENTS 是什么 产品定位`
2. `$ARGUMENTS 母公司 创始人`
3. `$ARGUMENTS 用户量 商业模式`
4. `$ARGUMENTS 主要竞品`
5. `$ARGUMENTS 最近动态`

### Step 2：输出精简卡片

```markdown
# 🔍 快速扫描：$ARGUMENTS

> 扫描时间：YYYY-MM-DD
> 深度：精简版（10 分钟）

## 一句话定位
[一句话]

## 速览卡

| 维度 | 信息 |
|---|---|
| 母公司 | |
| 成立 | |
| 创始人 | |
| 商业模式 | |
| 用户量 | |
| 主要竞品 | |
| 最近 6 月大事 | |

## 三个值得深挖的点
1. [点 1]
2. [点 2]
3. [点 3]

## 是否值得深度分析？
- ✅ 值得深度分析（用 /analyze-product $ARGUMENTS）
- ⚠️ 选择性深挖（建议聚焦 [维度]）
- ❌ 不值得（理由：[一句话]）
```

### Step 3：保存到 outputs/快速扫描-$ARGUMENTS-{日期}.md
