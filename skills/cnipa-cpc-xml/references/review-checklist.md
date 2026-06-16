# Review Checklist

## Review mode

Default to review-first mode.

Do not silently rewrite substantive patent language before the user confirms.

For each finding, explain:

- why it matters
- the proposed correction direction
- whether it is mechanical or substantive

After listing the findings, ask a direct follow-up question that decides whether the workflow may proceed beyond review.

Minimum required decision:

- whether to modify the text body now and continue with downstream submission outputs

If the user does not clearly confirm, stop after the review.

## High-priority checks

### Filing identity consistency

Check whether these are consistent:

- title
- abstract opening sentence
- independent claim name
- technical field opening sentence
- invention-content or utility-model-content opening sentence

Flag mismatches such as:

- title says one object while independent claim protects another
- document type is utility model but text still says `本发明`
- document type is invention but text still says `本实用新型`

### Claim integrity

Check:

- numbering continuity
- dependency targets exist
- dependency references match the actual claim numbers
- component names in dependent claims already appear in prior claims

### Terminology consistency

Check for inconsistent naming of the same part, such as:

- one section says `锥形口` and another says `锥形头`
- one section says `组件` and another says `连接组件`
- one section uses `声学传导液体` while another uses `声学传导液`

If the text does not make the intended term obvious, raise the inconsistency and ask before unifying.

### Description quality

Check for:

- obvious malformed sentences
- repeated words
- undefined component labels
- missing punctuation that changes meaning
- likely copy-paste residue

### Figure consistency

Check whether:

- figure titles align with the written embodiments
- figure labels are formatted consistently
- figure reference numerals match the nomenclature list

### XML-readiness

Check for:

- missing five-book sections
- risky object types
- floating images
- complex tables
- paragraph or line-break problems that will corrupt tags

## Edit policy

Usually safe to auto-fix after user confirmation:

- obvious duplicate words
- punctuation normalization
- section-title normalization
- purely mechanical naming consistency when intent is clear

Usually require explicit confirmation:

- changing the protected subject name
- changing claim scope wording
- changing relationship words such as `连接`, `固定`, `包括`, `包含`
- resolving ambiguous terminology where two meanings are possible

Even after classifying an item as mechanically safe, do not continue to clean-copy, XML, or ZIP regeneration unless the user has passed the post-review confirmation gate.
