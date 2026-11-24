# Workspace backup (QED problem pipeline)
- probs/p*.txt: problem source (## Title | rating | Area / W: / M:). p22–p28 = drafts toward 1000 (in progress, unaudited).
- rate/aout_*.json: strict audit results; rate/draft_prompt.txt, audit_prompt.txt: agent prompts.
- build.py: builds artifact page + D2.json; IDs frozen via D2_617_frozen.json (new problems get N-618+).
- Next: audit p22–p28, keep flag=ok, top up to 383 new, rebuild, regenerate problems/ via scripts/gen.py, allow N-\d{3,4} in check.py/automerge.yml.
