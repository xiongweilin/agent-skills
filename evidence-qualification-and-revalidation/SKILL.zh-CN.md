---
name: evidence-qualification-and-revalidation
description: 仅在一个已有证据支持的声明、qualification、decision、assignment 或 dependency 在发生具体重要上下文变化后，可能有某个特定假设失效，需要判断它是否仍可使用时触发。不要仅因为“上下文可能改变”或“新证据会增加信心”而触发。
---

# 证据资格与重新验证

当复用历史证据或历史结论，而一个具体且重要的变化可能使其 qualification 失效时使用。必须把证据是否存在、证据力量、历史支持和当前可用性分开。

## 程序

1. 识别声明或 dependency、当前请求用途，以及它此前取得 qualification 的范围。
2. 把支持基础绑定到使其可用的重要假设：source、version、method、object scope、environment、authority，以及相关时的时间敏感性。
3. 识别当前一个具体变化，并判断它是否使上述某个特定假设失效。
4. 如果没有重要假设失效，继续复用此前合格证据并停止。
5. 如果有假设失效，赋予当前状态：supported、contested、unknown、refuted 或 revalidation-required。
6. 选择最窄的有效结果：缩小范围、只获取失效假设所需的新证据、重新打开结论，或停止依赖该结论。
7. 记录原因、变化条件，以及明确的 reopen 或 revalidation trigger。

## 最低规则

- Evidence material 不等于 evidence force。
- 不要只因为上下文理论上可能改变、证据抽象地说“旧了”，或更新证据会提高信心就重新验证。
- 之前取得 qualification 的证据可以持续复用，直到一个具体的重要变化使与当前用途相关的假设失效。
- 当前不可用不等于错误。
- 范围扩展、重要上下文漂移或 authority 变化，只在它们改变了当前用途相关假设的程度上要求重新 qualification。

本 skill 不管理 candidate-versus-official 生命周期；promotion 或 deprecation 决策使用 `candidate-lifecycle`。它也不替代字段级 provenance contract；当主要问题是持久化数据 lineage 时使用 `data-contract-and-lineage`。

## 输出

返回声明或 dependency、此前 qualified scope、具体重要变化（如有）、当前用途决策，以及由已识别失效直接产生的 revalidation 或 reopen 条件。
