# Legal IP Skills CN

面向 Codex 的中国法律与知识产权 skills 包。当前版本聚焦中国大陆法律与知识产权工作流，包含通用法律分析能力、商标 / 专利 / 著作权 / 商业秘密 / 开源合规等专业能力，以及一个独立的 skill 校验工具。

Repository: https://github.com/wenxin097-ship-it/legal-ip-skills-cn

## 包含内容

- `skills/`：可安装到 Codex 的 skills。
- `docs/LEGAL_IP_SKILLS_GUIDE.md`：使用手册，按场景说明如何调用。
- `docs/LEGAL_SKILLS_REVIEW_20260615.md`：改写和审阅记录。
- `docs/GITHUB_REPOSITORY_SETTINGS.md`：GitHub About、topics 和 release 建议。
- `skill_toolchain/`：独立校验工具，用于运行 Codex 官方 `quick_validate.py`。
- `install.ps1` / `install.cmd`：安装脚本。

## 快速安装

在 Windows 上运行：

```powershell
.\install.cmd
```

安装位置默认为：

```text
%USERPROFILE%\.codex\skills
```

也可以从 GitHub 克隆后安装：

```powershell
git clone https://github.com/wenxin097-ship-it/legal-ip-skills-cn.git
cd legal-ip-skills-cn
.\install.cmd
```

安装完成后，可校验所有已安装用户 skills：

```powershell
.\skill_toolchain\validate.cmd -AllUserSkills
```

## 快速使用

商标注册初筛：

```text
使用 $trademark-clearance，分析“示例品牌”在中国第9类和第42类的注册风险。
```

商标或商业秘密侵权初筛：

```text
请按最小必要组合调用相关法律/IP skills，先做事实梳理、证据矩阵和侵权初筛，再判断是否适合发函。
```

技术合同审查：

```text
使用 $ip-clause-review，审查这份技术开发合同中的知识产权条款，并输出修改建议。
```

正式报告：

```text
使用 $cn-legal-risk-memo，把上述分析整理成管理层风险备忘录。
```

## 主要能力

- 法律来源检索与现行法核验
- 事实与争点梳理
- 证据矩阵
- 法律推理
- 风险备忘录
- 商标注册初筛
- 知识产权侵权初筛
- 警告函 / 律师函
- 平台投诉通知
- 专利交底书初评
- 专利 FTO 初筛
- 专利 claim chart
- 技术合同 IP 条款审查
- 开源许可证合规审查
- IP 组合生命周期管理
- CNIPA 发明 / 实用新型 CPC XML 递交包工作流

## 边界说明

本项目提供工作流和分析框架，不构成律师正式法律意见。涉及最新法律、期限、金额、平台规则、官方数据库检索和对外法律文书时，应结合实时官方来源和专业人员复核。
