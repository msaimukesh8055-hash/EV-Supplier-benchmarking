# EV Charger Site Selection - Multi-Agent Prototype

## 📌 Overview
This project demonstrates how **Agentic AI workflows** can automate complex business decisions.  
The use case is **EV charger site selection** across Southeast Asia, where business teams need to shortlist  
potential installation sites (hotels, malls, golf courses) based on strict feasibility and financial filters.  

I built a **3-Agent workflow** using **Gemini CLI** and a Gradio UI wrapper:
1. **Collector Agent** → Validates raw site data (CSV) and drops incomplete rows.  
2. **Analyzer Agent** → Applies eligibility rules & multi-factor scoring (cost, accessibility, prime location, charger capacity).  
3. **Responder Agent** → Produces an executive brief with top-2 recommended sites, risks, and next steps.  

## ❌ Current Business Pain Points
- Manual site evaluations across 10+ markets → slow, inconsistent.
- Difficult to apply **standardized filters** (prime location, accessibility, cost cap, etc.) at scale.
- Executives need **shortlists + risks** summarized in clear, decision-ready language.

## ✅ Solution
- Upload a **sites.csv** with candidate locations.  
- Agents automatically **clean, filter, score, and rank** sites.  
- Outputs:
  - `cleaned.csv` (normalized dataset)
  - `scores.csv` (scoring + eligibility)
  - `shortlist.csv` (top-2 sites)
  - `recommendations.md` (executive brief with risks & checklist)

## 📂 Input Example
**sites.csv**
```csv
site_id,country,city,venue_name,venue_type,prime_location,accessibility,charging_partner_ok,electricity_available,cost_sgd,min_installable_chargers,remarks
TH-01,Thailand,Bangkok,Royal Greens,golf_course,yes,good,yes,yes,4800,3,Top golf resort in Bangkok
SG-01,Singapore,Singapore,Marina Bay Grand,7star_hotel,yes,good,yes,yes,5000,2,Iconic Singapore landmark
ID-01,Indonesia,Jakarta,Plaza Elite,luxury_mall,no,avg,yes,yes,4200,2,Not in prime location
MY-01,Malaysia,Kuala Lumpur,KL Towers,7star_hotel,yes,poor,yes,yes,4600,2,Accessibility is poor
VN-01,Vietnam,Hanoi,Harmony Golf,golf_course,yes,avg,no,yes,3500,4,Partner not confirmed
```

# Ouput
```
## Top-2 Recommended Sites
| site_id | venue_name       | city      | country   | TotalScore | strongest 2 factors |
|:--------|:-----------------|:----------|:----------|:-----------|:--------------------|
| TH-01   | Royal Greens     | Bangkok   | Thailand  | 0.75       | cost, accessibility |
| SG-01   | Marina Bay Grand | Singapore | Singapore | 0.70       | accessibility, prime location |

## Risks & Considerations
- Budget Sensitivity: One site exceeded budget cap and was rejected.
- Location Viability: Several candidates failed prime-location/accessibility filters.
- Partner Risk: One site lacked confirmed charging partner.

## 7-Day Action Checklist
- [ ] Confirm grid capacity & upgrade costs for TH-01 and SG-01
- [ ] Initiate partnership discussions with venue owners
- [ ] Conduct site visits for charger placement
- [ ] Finalize cost-benefit analysis
- [ ] Draft LOIs and review legal compliance
- [ ] Check local permitting requirements
```
