---
name: data-contract-and-lineage
description: 仅在转换或持久化字段必须可追溯到来源、owner、版本、验证和允许用途，或某个输出支撑正式声明时使用。临时值、普通 schema 或简单内存转换不要触发。
---

# 数据契约与血缘

只有当持久化、跨边界转换，或正式/影响决策的声明使 provenance 成为实质条件时，才使用这份紧凑契约。

## 每个重要字段的契约

明确：

- source；
- state；
- owner；
- validation；
- lineage 和 version binding；
- allowed use。

## 最低规则

- 生成的解释在绑定证据之前仍然是 candidate 或 pending。
- 一个 score 或 report 如果没有绑定产生它的版本，就不是稳定声明。
- 当多个层都可能写入或消费某个值时，必须明确字段 owner 和允许用途。

## 成功信号

读者能够明确该值来自哪里、谁可以修改、由哪个版本产生、如何被检查，以及允许在哪里使用。
