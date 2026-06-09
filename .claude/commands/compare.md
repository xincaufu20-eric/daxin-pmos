---
description: 对比多个产品。用法：/compare 产品A vs 产品B vs 产品C
---

启动 competitive-analysis skill 对 $ARGUMENTS 进行系统化对比。

## 执行流程

### Phase 1：识别产品

从 $ARGUMENTS 中解析出产品列表（按 "vs" 或 "," 或 "and" 分割）。

### Phase 2：并行调研

对每个产品并行调用 `@竞品分析师`：

```
@竞品分析师 调研产品 1
@竞品分析师 调研产品 2
...
```

### Phase 3：综合对比

```
@数据综合师 综合所有调研结果，做对比分析
```

### Phase 4：输出 competitive-analysis skill 标准报告

按 4 个输出格式：
1. 标准对比矩阵
2. Insight-Impact-Opportunity 表
3. 定位地图（2x2）
4. 差异化战略建议（进攻/防御/创新）

### Phase 5：保存

`outputs/竞品对比-$ARGUMENTS-{日期}.md`

如对比超过 3 个，**额外**生成：
`outputs/竞品矩阵-{日期}.xlsx`（用 xlsx skill）
