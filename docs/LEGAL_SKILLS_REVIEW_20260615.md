# 中文法律 Skills 审阅与改写报告

日期：2026-06-15

## 一、结论

`THUYRan/Legal-Skills-Chinese` 提供了完整的法律工作能力分类，适合作为方法论参考，但不宜原样安装到当前 Codex 环境。

本次采用“保留专业 IP skills + 新建六个通用法律基础 skills”的方案。该方案减少上下文占用和能力重叠，同时加强现行法核验、事实与证据分离、结论强度控制和 Codex 兼容性。

## 二、上游仓库审阅

审阅版本：

- 仓库：`THUYRan/Legal-Skills-Chinese`
- 提交：`d844a25f6d5e6eff4999774a9ab0f79f7cb9d22d`
- 提交日期：2026-05-31
- skills 数量：38

主要优点：

1. 覆盖检索、事实处理、解释、推理、论证、风险和文书全链条。
2. 强调原子能力与复合能力的分层。
3. 普遍包含能力边界、操作步骤和法律免责声明。

主要问题：

1. 体量过大。38 个 `SKILL.md` 平均约 635 行，中位数约 566 行；29 个超过 400 行，14 个超过 800 行，最长 1279 行。
2. Codex 适配不足。38 个 skill 均缺少 `agents/openai.yaml`。
3. 部分目录名与 frontmatter 命名风格不统一，影响跨平台维护。
4. 示例中存在固定检索截止日期、固定置信度百分比和机械阈值，可能形成虚假精确性。
5. 部分流程使用过强的“必须调用”“不得继续”等约束，容易导致简单任务被过度编排。
6. 检索类能力只定义方法，不自带法律数据库；若未实际联网核验，仍有引用旧法或虚构来源的风险。

## 三、本地改写

### 1. 修订现有专业 skills

已修订 11 个本地知识产权 skills：

- `cease-desist`
- `claim-chart-builder`
- `cold-start-interview`
- `fto-triage`
- `infringement-triage`
- `invention-intake`
- `ip-clause-review`
- `oss-review`
- `portfolio`
- `takedown`
- `trademark-clearance`

主要调整：

1. 删除不受支持的 frontmatter 字段。
2. 删除 Claude 专属命令和强制 `CLAUDE.md` 依赖。
3. 将企业档案改为可选的 `LEGAL_PROFILE.md`。
4. 移除固定企业名称、审批角色、金额和地域假设。
5. 为每个 skill 增加 `agents/openai.yaml`。
6. 修正专利年费、恢复权利、费减、电商反通知、反不正当竞争法、开源许可等高风险表述。

原文件备份：

本地改写时曾保留私有备份；发布包不包含备份目录。

### 2. 新建通用基础 skills

已新建：

- `cn-legal-source-research`
- `cn-legal-norm-validity`
- `cn-legal-fact-issue-mapping`
- `cn-evidence-matrix`
- `cn-legal-reasoning`
- `cn-legal-risk-memo`

六个 skill 分别负责来源、效力、事实、证据、推理和交付，不重复承载专业实体法规则。专业 IP skill 可以按任务需要调用这些基础能力。

## 四、长期校验方案

新增独立工具：

`skill_toolchain/`

设计理由：

1. 不修改 Codex 内置 Python，避免运行时升级后丢失。
2. 使用独立 `.venv`，避免依赖污染。
3. 固定 `PyYAML==6.0.3`，保证可复现。
4. 始终调用当前 Codex 自带的 `quick_validate.py`，校验规则可随 Codex 更新。
5. 当前用户采用 `RemoteSigned`；入口不使用 `Bypass`，并统一处理 UTF-8 中文读取。

常用命令：

```powershell
.\skill_toolchain\validate.cmd %USERPROFILE%\.codex\skills\cn-legal-source-research
.\skill_toolchain\validate.cmd -AllUserSkills
```

## 五、验证结果

1. 17 个本次涉及的 skill 全部通过官方 `quick_validate.py`。
2. 所有 `agents/openai.yaml` 和被引用的 `references` 文件均存在。
3. 六个基础 skill 的触发描述均覆盖其核心任务关键词。
4. 未再发现 Claude 专属字段、强制 Bounce、强制企业档案或已识别的高风险固定表述。

## 六、剩余风险

1. 法律规则会持续更新，涉及“现行、最新、期限、金额、处罚幅度”的任务仍须实时核验官方来源。
2. 官方 `quick_validate.py` 只验证结构，不验证法律内容正确性、触发质量或输出质量。
3. 上游 38 个 skill 中仍有文书格式、案件期限和预算等能力未纳入本地基础层；应按真实使用频率逐项引入，不建议一次性安装。
4. 高风险对外法律文书仍应由执业律师复核。

## 七、建议

后续以真实任务日志评估六个基础 skill 的触发情况。只有在反复出现明确缺口时，再增加独立 skill，例如类案检索、诉讼期限管理或多文档法律摘要。
