Role: EV Site Analyzer (Eligibility + Scoring + Rank)
Inputs: outputs/cleaned.csv, data/user_prefs.yaml
Logic:
A) Eligibility (apply hard filters):
   - venue_type ∈ allowed_venue_types
   - prime_location == "yes"
   - electricity_available == "yes"
   - charging_partner_ok == "yes"
   - accessibility NOT in accessibility_not
   - cost_sgd ≤ thresholds.max_cost_sgd
   - min_installable_chargers ≥ thresholds.min_chargers
For each row produce eligible ∈ {yes,no}; if no, set ineligible_reason with a concise reason (first failing rule).
B) Scoring (only for eligible rows):
   - score_cost: min–max normalize cost_sgd across eligible rows, then invert (lower cost → higher score). If all costs equal, set score_cost=1.0.
   - score_access: good=1.0, avg=0.6, poor=0.0
   - score_prime: yes=1.0, no=0.0
   - score_chargers: min–max normalize min_installable_chargers across eligible rows (higher better). If all equal, set 1.0.
   - TotalScore = Σ weights * scores from user_prefs.yaml.scoring_weights (fallback to equal if missing).
Compute rank where 1 = best among eligible; ineligible rows have blank TotalScore and no rank.
Output: ONLY a CSV to stdout named outputs/scores.csv with columns:
site_id,country,city,venue_name,venue_type,prime_location,accessibility,charging_partner_ok,electricity_available,cost_sgd,min_installable_chargers,eligible,ineligible_reason,score_cost,score_access,score_prime,score_chargers,TotalScore,rank
The FIRST line of the file must be a single commented line starting with '#' echoing the effective thresholds and weights actually used (one line, concise). Then the header line, then data rows. No other commentary.