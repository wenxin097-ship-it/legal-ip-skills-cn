# Release Notes

## v0.1.0 - 2026-06-16

Initial public package for Codex legal and intellectual property skills in Chinese.

Included:

- 18 installable skills under `skills/`
- Chinese legal source research, norm validity, fact mapping, evidence matrix, reasoning, and risk memo skills
- IP practice skills for trademarks, patents, infringement triage, cease-and-desist letters, takedown notices, contracts, open source compliance, portfolios, and CNIPA CPC XML workflows
- `install.ps1` / `install.cmd` for local installation
- `skill_toolchain/` for validation with Codex's official `quick_validate.py`
- User guide and review notes under `docs/`

Validation:

- Installed into a temporary target directory successfully
- 18 skills passed Codex official `quick_validate.py`
- Release scan found no local machine paths or credential-like patterns

Notes:

- This package provides workflows and analysis scaffolding, not formal legal advice.
- Current gaps include trademark refusal review, opposition, invalidation, non-use cancellation, and administrative litigation workflows.
