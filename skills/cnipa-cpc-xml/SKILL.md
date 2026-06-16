---
name: cnipa-cpc-xml
description: Review and convert CNIPA invention or utility model Word filing folders into CPC-ready XML packages. Use for Chinese patent filing materials, CPC递交, CPC系统, 国家知识产权局专利业务办理系统, WORD转XML编辑器, Word转XML, 五书模板, 五书转XML, 说明书摘要, 摘要附图, 权利要求书, 说明书, 说明书附图, XML压缩包, and patent submission ZIP packaging. Supports pre-submission review, revision-tracked copies, clean CPC submission copies, XML generation, and final ZIP packages.
---

# CNIPA CPC XML

## Overview

Use this skill for CNIPA CPC submission work on invention patents and utility models. Default to a conservative workflow: inspect local references first, review before editing, explain why each issue matters and how to fix it, then require an explicit user decision on whether to modify the text body. Only after that confirmation may the workflow continue to clean Word files, optional revision copies, XML folders, and ZIP packages.

## Workflow

### 1. Gather local context first

Inspect the case folder and its parent directory before making assumptions.

Prefer local sources in this order:

1. The current case folder
2. Parent-folder materials such as `XML安装包及教程`, five-book templates, or past successful XML packages
3. The installed `WORD转XML编辑器` behavior on this machine

Use parent-folder references when they exist, because they are the best local evidence for the latest trusted workflow, templates, and naming habits in this environment. If those references do not exist, proceed using the installed editor and the current Word files.

Do not assume this skill supports design patents. If the matter is an exterior design filing, stop and tell the user this skill currently only supports invention patents and utility models.

### 2. Review before editing

Do not auto-fix by default.

First produce a review that focuses on filing-risk issues, such as:

- Title and independent-claim name mismatches
- Inconsistent terminology across title, abstract, claims, description, and figure labels
- Broken claim numbering or dependency chains
- Obvious wording defects, missing punctuation, undefined component names, or figure-mark conflicts
- Problems likely to affect XML conversion, such as missing five-book structure, malformed section headers, or image placement issues

For each issue, explain:

- Why it matters for submission quality or formal review
- A concrete modification idea
- Whether it is safe to auto-fix or should be user-confirmed first

Unless the user explicitly asks for direct editing, wait for confirmation before changing substantive wording. Minor purely mechanical fixes are still safer to include in the findings list first.

After presenting the findings, pause and ask a direct confirmation question about whether to modify the text body now. If the user does not clearly confirm, stop after the review and do not create or refresh any downstream submission artifacts.

Read [references/review-checklist.md](references/review-checklist.md) when you need the detailed review checklist.

### 3. Require an edit decision before downstream work

After the review, ask for a clear yes or no decision before editing the text body or regenerating deliverables.

Allowed continuation only after explicit confirmation:

- update the working copy
- create or refresh the clean copy
- create or refresh the revision copy
- regenerate XML
- regenerate ZIP packages

If the user says no, keep the workflow in review-only mode and report the issues without making downstream output changes.

### 4. Prepare Word outputs

Keep the original source file unchanged.

Use these output roles:

- `-CPC递交版.docx`: working submission copy used to reach XML-convertible structure
- `-CPC清洁版.docx`: final clean copy used to generate the deliverable XML package
- `-CPC修订版.docx`: optional human-review copy with visible revision history

Default naming behavior is to append a suffix to the current filename stem. If the user later wants a different suffix rule, update the naming section in this skill and, if scripts are added later, update the script constants as well.

When producing a revision copy:

- Use it for human review only
- Prefer tracked changes in Word when practical
- Never use the revision copy as the XML conversion source

When both the original file and the clean copy exist, prefer the helper script at `scripts/create_revision_copy.ps1` to generate the revision copy by comparing the two Word documents. This is more reliable than trying to preserve ad hoc edit history inside the XML conversion source document.

Use the clean copy for final XML generation.

Read [references/workflow.md](references/workflow.md) when you need the detailed preparation and output rules.

### 5. Enforce five-book structure

For invention patents and utility models, ensure the Word file is laid out in the structure expected by the installed editor:

1. 说明书摘要
2. 摘要附图
3. 权利要求书
4. 说明书
5. 说明书附图

Verify section headers and section breaks before conversion. If the source lacks a required section, add it in the working copy.

Prefer the latest locally trusted five-book template when it exists in the parent resources. Otherwise, reconstruct the structure carefully from successful local examples.

### 6. Handle conversion-sensitive objects carefully

Before conversion, check for objects that commonly break XML generation:

- Unsupported characters outside GB18030
- Floating objects instead of inline objects
- Complex tables
- Chemistry expressions
- Unsupported formula objects
- Page numbers typed into body text
- Hard and soft line-break issues that distort paragraph tags

When in doubt, follow the local tutorial materials first. If no tutorial is present, use the installed editor's standard behavior and convert fragile objects to images when necessary.

### 7. Generate XML and package deliverables

Do not run this stage until the user has explicitly confirmed that the text body may be modified or that downstream artifacts should be regenerated from approved edits.

Use the installed `WORD转XML编辑器` on this machine. Office activation warning dialogs may be closed automatically if they block the workflow.

After conversion, verify the output contains the expected `100001` through `100005` folders and corresponding XML files. Then package the XML output into a ZIP for submission.

Expected final deliverables usually include:

- the clean Word copy
- the XML output folder
- the ZIP package
- optionally the revision copy

### 8. Report results clearly

When done, tell the user:

- what was reviewed
- what was changed
- what was left for manual judgment
- where the clean copy, revision copy, XML folder, and ZIP are located

## References

- Use [references/workflow.md](references/workflow.md) for the detailed end-to-end procedure and naming defaults.
- Use [references/review-checklist.md](references/review-checklist.md) for pre-submission review criteria and when to ask the user before editing.
- Use [references/maintenance.md](references/maintenance.md) when updating this skill later.
