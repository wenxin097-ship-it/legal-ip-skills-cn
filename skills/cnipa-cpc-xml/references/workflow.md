# Workflow

## Scope

This skill currently supports:

- invention patents
- utility models

This skill does not currently support:

- design patents

## Local-source policy

When starting a case, inspect:

1. the case folder itself
2. the case folder's parent directory
3. any local tutorial or historical XML outputs in nearby folders

Prefer these local materials when present:

- `XML安装包及教程`
- local five-book templates
- prior successful `100001` to `100005` XML output folders
- local ZIP packages previously used for submission

Reason:

- they reflect the actual machine setup
- they reflect the current team's locally trusted habits
- they are often more useful than generic documentation for template and naming decisions

If these materials are missing, continue with the installed `WORD转XML编辑器` and reconstruct the five-book structure from the current document.

## Default output naming

Append these suffixes to the existing filename stem:

- working submission copy: `-CPC递交版`
- final clean submission copy: `-CPC清洁版`
- optional revision-tracked copy: `-CPC修订版`

If the user wants different suffixes later, update this file and the matching instructions in `SKILL.md`. If helper scripts are added later, update their naming constants too.

## Output roles

### Original file

Keep unchanged.

### CPC递交版

Use as the first structured submission copy when fixing section layout and conversion-readiness.

### CPC清洁版

Use as the final XML conversion source.

### CPC修订版

Use only for human review.

Preferred behavior:

- enable Word tracked changes when practical
- preserve visible edits for the user
- do not feed this copy into XML conversion

If both the original file and the clean copy are available, create the revision copy from a document comparison instead of converting the clean copy directly. Use `scripts/create_revision_copy.ps1` for this.

## Five-book structure

For invention patents and utility models, target this order:

1. 说明书摘要
2. 摘要附图
3. 权利要求书
4. 说明书
5. 说明书附图

Typical output after conversion:

- `100001/100001.xml`
- `100002/100002.xml`
- `100003/100003.xml` plus image files as needed
- `100004/100004.xml`
- `100005/100005.xml` plus image files as needed

## Conversion sequence

1. Read the case files and nearby references.
2. Review the Word files and present findings first.
3. Ask whether to modify the text body and continue with downstream work.
4. Stop here if the user does not clearly confirm.
5. Create or update the working copy only after confirmation.
6. Normalize five-book structure and image/object handling.
7. Create the clean copy.
8. Optionally create the revision-tracked copy.
9. Use the installed editor to run five-book XML conversion.
10. Verify the XML folder contains the expected `100001` to `100005` outputs.
11. Compress the XML output into a ZIP.

## Mandatory confirmation gate

After the review phase, require an explicit user decision before changing the text body or regenerating deliverables.

If the user has not clearly said yes, do not:

- edit the substantive text
- refresh the clean copy
- create or refresh the revision copy
- regenerate XML
- regenerate ZIP packages

In that case, return a review-only result.

## Dialog handling

Office activation warning dialogs may be dismissed automatically if they block the plugin workflow.

If a dialog is not clearly safe to dismiss, stop and summarize it for the user.
