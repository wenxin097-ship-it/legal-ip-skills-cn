# Skill Toolchain

用于稳定运行 Codex 官方 skill 校验脚本，避免直接修改 Codex 内置 Python 运行时。

## 设计

- 独立环境：依赖安装在本目录的 `.venv`。
- 固定版本：`requirements.lock.txt` 固定 `PyYAML` 版本。
- 官方校验：实际规则仍由 Codex 自带的 `quick_validate.py` 提供。
- 自动初始化：首次执行 `validate.ps1` 时会自动运行 `setup.ps1`。

## 使用

校验一个或多个 skill：

```powershell
.\validate.cmd %USERPROFILE%\.codex\skills\cease-desist
.\validate.cmd `
  %USERPROFILE%\.codex\skills\cn-legal-source-research `
  %USERPROFILE%\.codex\skills\cn-legal-norm-validity
```

校验用户 skills 目录下的全部 skill：

```powershell
.\validate.cmd -AllUserSkills
```

重新建立环境：

```powershell
.\setup.cmd -Force
```

当前用户的建议执行策略为 `RemoteSigned`。`.cmd` 入口不绕过执行策略，仅用于提供更方便的命令行入口。

检查当前策略：

```powershell
Get-ExecutionPolicy -List
```

恢复 Windows 客户端默认行为：

```powershell
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
```


## 维护

Codex 更新后无需复制 `quick_validate.py`。入口脚本会从当前
`C:\Users\<user>\.codex\skills\.system\skill-creator\scripts` 调用最新版本。
