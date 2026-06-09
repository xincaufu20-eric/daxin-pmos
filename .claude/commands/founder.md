---
description: 深度调研创始人/CEO。用法：/founder 人名
---

启动 founder-profile skill 调研 $ARGUMENTS。

## 执行流程

### Phase 1：确认对象

如果 $ARGUMENTS 含糊（如只有名字没有公司），主动询问：
"$ARGUMENTS 是指哪家公司的？为避免重名，请确认。"

### Phase 2：调用 创始人调查员

```
@创始人调查员 调研：$ARGUMENTS
```

### Phase 3：按 founder-profile skill 标准结构输出

7 维度画像：
1. 早年经历
2. 职业轨迹
3. 创业故事
4. 决策风格诊断
5. 3-5 句关键引言
6. 1-2 个重大决策复盘
7. 盲点与争议

### Phase 4：保存

`outputs/创始人画像-$ARGUMENTS-{日期}.md`
