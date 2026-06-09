---
description: 扫描我关注领域的本周动态。用法：/weekly-radar
---

扫描我在 context/watchlist.md 中关注的产品和公司，输出本周变化摘要。

## 执行流程

### Phase 1：读取关注列表

```
读取 context/watchlist.md
解析出关注的产品 / 公司 / 人物
```

### Phase 2：并行扫描

对每个关注对象，调用 `@市场研究员` 搜索最近 7 天动态：

- 重大新闻
- 产品更新
- 高管变动
- 融资 / 收购
- 公开数据点

### Phase 3：生成雷达报告

```markdown
# 📡 本周雷达：YYYY-MM-DD

## 🔴 重要变化（需要立即关注）
1. [产品 A] - [事件] - [我应该…]
2. ...

## 🟡 值得注意
1. ...

## 🟢 轻微动态
- 列表

## 反思
- 本周我的判断与实际是否一致？
- 哪些信号印证了我的预测？
- 哪些超出了预期？

## 下周关注
- [我应该跟踪的 3 个具体指标]
```

### Phase 4：保存

`outputs/weekly-radar-{YYYY-MM-DD}.md`

### Phase 5：更新 learner.md

如果发现某些"原本认为不重要的领域"出现重大变化，
建议用户更新 watchlist.md 或 CLAUDE.md。
