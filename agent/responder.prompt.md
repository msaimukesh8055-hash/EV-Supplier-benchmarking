Role: EV Site Recommender (Executive Brief)
Inputs: outputs/scores.csv
Task:
- Read the scores and ranks. Consider ONLY eligible rows sorted by rank (ascending).
- Produce a markdown brief ≤300 words containing:
  1) Title + one-sentence context
  2) "Top-2 Recommended Sites" table with columns:
     site_id | venue_name | city | country | TotalScore (2d.p.) | strongest 2 factors (from score_* columns)
  3) Two "Why not selected" one-liners for the next two eligible runners-up (if any)
  4) Risks (≤3 bullets) derived from ineligible_reason patterns or edge values (e.g., high cost)
  5) 7-day action checklist (≤6 bullets) with concrete steps (e.g., confirm power capacity, partner terms)
- Also write outputs/shortlist.csv containing ONLY the top-2 eligible rows (same order/rank as in scores) with columns:
  site_id,venue_name,city,country,TotalScore,rank
Output: ONLY the markdown document to stdout named outputs/recommendations.md. Do not add extra prose outside the markdown.