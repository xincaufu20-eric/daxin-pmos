---
description: 启动完整产品考古分析（30 分钟深度版）。用法：/analyze-product 产品名
---

请对产品「$ARGUMENTS」进行完整的考古分析。

## 执行流程

### Phase 1：先调用 product-archaeology skill 的 Phase 0 澄清问题

如果用户已经在命令中提供了上下文（如 `/analyze-product Notion 给老板汇报 30 分钟版`），跳过澄清直接进入 Phase 2。

### Phase 2：并行调度子智能体

```
@市场研究员 调研：$ARGUMENTS
@竞品分析师 调研：$ARGUMENTS 的竞争格局
@创始人调查员 调研：$ARGUMENTS 创始团队
@趋势分析师 调研：$ARGUMENTS 所在赛道未来 3 年
```

并行执行，预计 3-5 分钟。

### Phase 3：综合数据

```
@数据综合师 综合上述四个子 agent 的输出
```

### Phase 4：按 product-archaeology skill 输出完整报告

按四时空（前世/今生/未来/启发）输出。

### Phase 5：主动建议视角审查

报告生成后，告诉用户：

```
报告已保存到 outputs/产品考古-$ARGUMENTS-{YYYY-MM-DD}.md

建议执行 3 次视角审查：
1. 输入「审查 as 投资人」
2. 输入「审查 as 竞争对手」
3. 输入「审查 as 用户」

或输入「压力测试」让 skeptic-reviewer 全面挑战这份报告。
```

### Phase 6：保存到 outputs/

文件名：`outputs/产品考古-$ARGUMENTS-{今日日期}.md`
