# Maintenance

## Updating this skill

This skill is expected to evolve.

Typical reasons to update it:

- the local editor behavior changes
- the team's naming habits change
- the preferred output suffixes change
- the confirmation gate or review policy changes
- a new stable way to create revision copies is adopted
- design-patent support is added later

## What to update

### Update `SKILL.md`

Update:

- trigger description
- default workflow
- review policy
- supported filing types

The YAML frontmatter `description` is the main discoverability surface. Include practical trigger phrases such as `CPC递交`, `CPC系统`, `WORD转XML编辑器`, `Word转XML`, `五书模板`, `五书转XML`, `国家知识产权局专利业务办理系统`, and `XML压缩包`.

### Update `references/workflow.md`

Update:

- naming defaults
- output expectations
- local-source precedence
- editor or dialog-handling behavior

### Update `references/review-checklist.md`

Update:

- review standards
- issue severity rules
- what can be auto-fixed after confirmation

### Add scripts later if the workflow stabilizes

Good candidates for future scripts:

- output naming helpers
- Word document preflight checks
- XML folder verification
- ZIP packaging helpers

Current script:

- `scripts/create_revision_copy.ps1`: compare an original Word file with a clean Word file and save a visible revision copy for human review

## Validation

After editing the skill, run:

```powershell
%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe `
  %USERPROFILE%\.codex\skills\.system\skill-creator\scripts\quick_validate.py `
  %USERPROFILE%\.codex\skills\cnipa-cpc-xml
```

If UI metadata is needed or updated, regenerate:

```powershell
%USERPROFILE%\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe `
  %USERPROFILE%\.codex\skills\.system\skill-creator\scripts\generate_openai_yaml.py `
  %USERPROFILE%\.codex\skills\cnipa-cpc-xml `
  --interface display_name='CNIPA CPC XML' `
  --interface short_description='Review Word patent filings and package CPC XML.' `
  --interface default_prompt='Use this skill to review a CNIPA invention or utility model filing folder, especially CPC递交, WORD转XML编辑器, Word转XML, 五书模板, and 国家知识产权局专利业务办理系统 work. Perform pre-submission review, explain issues before editing, optionally create a revision copy, generate XML with the installed Word plugin, and package the final ZIP files.'
```

## How to call it later

Examples:

- `用 cnipa-cpc-xml 处理这个案卷目录`
- `先做递交前人工复核，再生成 clean 版和 XML`
- `给这个案件做 CPC 修订版、清洁版和 zip`
- `调用 CPC系统中 Word转XML 的 skill`
- `把这个五书 Word 转成 CPC XML 压缩包`

Direct script example:

```powershell
powershell -ExecutionPolicy Bypass -File `
  %USERPROFILE%\.codex\skills\cnipa-cpc-xml\scripts\create_revision_copy.ps1 `
  -OriginalPath 'C:\path\to\原稿.docx' `
  -RevisedPath 'C:\path\to\清洁版.docx' `
  -Force
```
