---
name: candidate-lifecycle
description: 仅在评估或转换候选、实验、正式、已弃用或已提升的规则、提示、模型、数据集、阈值、工作流或配置时使用。普通实现、测试、部署或配置编辑不要触发。
---

# 候选生命周期

仅当某个产物存在“候选与正式”之间的决策时使用本 skill。生命周期状态必须与证据状态、普通实现状态分开。

## 程序

1. 对产物及其当前状态分类：draft、candidate、frozen、scored、official、unpromoted、deprecated 或 archived。
2. 把决策绑定到相关版本、范围、评估证据、owner、截止时间、预算和停止条件。
3. 选择一个转换：promote、narrow、reject、archive、deprecate 或 escalate。
4. 更新受影响文档，并防止旧状态继续静默指导新工作。

证据不足不会让候选自动变成正式版本；一次成功运行也不能证明应该提升。

## 输出

返回当前状态、证据与范围、选定转换、owner，以及仍需满足的 revalidation 或 migration 条件。
