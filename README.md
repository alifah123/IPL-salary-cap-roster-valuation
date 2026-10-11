# 🏏 IPL Franchise Salary Cap & Roster Valuation: Optimizing Talent Investment Strategy

---

## 📋 Project Overview
### Project Background
Indian Premier League (IPL) franchises operate under a strict multi-crore salary cap constraint, where every financial allocation directly impacts squad balance, injury resilience, and on-field success. In modern cricket operations, franchise leadership frequently engages in aggressive bidding wars for marquee talent, often leading to polarized wage distributions that risk crippling team depth if a star player underperforms or gets injured.

### Analyst Context & Role
Operating as an internal analytics team member reporting directly to the **Chief Executive Officer (CEO)**, **Head of Cricket Operations**, and the **Scouting Directorate**, this project delivers a comprehensive financial and roster valuation audit across all ten IPL franchises. The goal is to evaluate spending efficiency, diagnose star-dependency risks, and provide data-backed talent acquisition strategies for upcoming auction cycles.

---

## 🌟 North Star Metrics and Trends Explored
To anchor the analysis in core business reality, the study evaluates performance through structural North Star metrics and high-level trends:
* **North Star Metric:** **Squad ROI & Salary Cap Utilization Ratio** (Measuring output valuation and individual price contribution relative to squad depth).
* **Key Trends Explored:**
  1. Elite wage concentration versus bottom-tier bench dependency.
  2. The structural valuation gap between domestic Indian players and scarce overseas assets.
  3. Positional cost inflation across high-impact roles (e.g., all-rounders and anchor batters).

---

## 📌 Executive Summary
While total franchise spending clusters tightly between 107.95 Cr (Kolkata Knight Riders) and 120.10 Cr (Sunrisers Hyderabad), extreme top-heavy salary concentration creates critical roster vulnerability. Across the league, top marquee players consume up to **22.52%** of a team's entire financial cap (e.g., Rishabh Pant at 27.00 Cr for Lucknow Super Giants). 

By deploying advanced SQL models (Common Table Expressions, Window Functions, and Correlated Subqueries), this analysis diagnoses systemic wage imbalances and equips executive stakeholders with actionable frameworks to optimize capital allocation, protect against injury-induced performance dips, and maximize squad depth.

---

## 🗂️ Data Structure and EDA
* **Dataset Source:** IPL Player Auction & Salary Dataset (`iplplayers`).
* **Data Scale:** Complete roster valuation tracking across 10 franchises, categorizing players by role, nationality type, and contract valuation (`Price_in_cr`).
* **Exploratory Data Analysis (EDA) Phases:**
  1. **Financial Benchmarking:** Aggregated total team outlays using `GROUP BY` to map baseline financial exposure (Q1: SRH leads at 120.10 Cr; KKR lowest at 107.95 Cr).
  2. **Intra-Team Hierarchy Mapping:** Utilized window functions (`ROW_NUMBER()` and `RANK()` partitioned by team) to isolate wage distributions and identify elite earners (Q3, Q4, Q5: e.g., Rishabh Pant at 27.00 Cr for LSG, Shreyas Iyer at 26.75 Cr for PBKS).
  3. **Demographic and Bracket Segmentation:** Applied conditional `CASE` statements to classify players into structural salary brackets and subqueries to benchmark domestic versus overseas valuation trends (Q7, Q8, Q9).

---

## 📈 Insight Deep Dive

### Insight 1: Marquee Over-Allocation Drains Over 22% of Franchise Budgets
* **Data Evidence:** Total expenditures span from 107.95 Cr (KKR) to 120.10 Cr (SRH). However, spending is severely skewed: Rishabh Pant accounts for **22.52%** of Lucknow Super Giants' budget (27.00 Cr), Shreyas Iyer takes **22.36%** for Punjab Kings (26.75 Cr), and Venkatesh Iyer consumes **22.00%** for Kolkata Knight Riders (23.75 Cr). Bracket audits (Q7) show teams rely heavily on 14 to 19 "Low" bracket players (<5 Cr) while holding only 1 to 4 "High" bracket players (>15 Cr).
* **The 'So What':** If a franchise allocates over 20% of its financial cap to a single elite asset, an injury or dip in form instantly compromises a massive portion of the team's capital. This leaves the deep bench overly reliant on low-cost fillers (<5 Cr), creating catastrophic operational exposure during a slump.
* **Target Stakeholder Teams:** 
  1. *Franchise CEO & Financial Directorate* (Budget risk oversight)
  2. *Head of Cricket Operations* (Roster construction strategy)
  3. *Medical & Coaching Staff* (Injury risk mitigation planning)

---

### Insight 2: Artificial Scarcity Inflates Overseas Valuations Past Domestic Benchmarks
* **Data Evidence:** Subquery audits comparing player demographics (Q8) confirm that **Overseas players command an average price of 5.64 Cr**, outperforming **Indian players who average 5.13 Cr**. Role analysis (Q10) highlights that top players like Ravindra Jadeja (All-rounder, CSK at 18.00 Cr) and Rashid Khan (Bowler, GT at 18.00 Cr) anchor elite valuations, but international scarcity drives up overall overseas market pricing.
* **The 'So What':** While overseas stars bring undeniable global pedigree, the marginal cost premium over top-tier domestic talent requires rigorous return-on-investment tracking to ensure auction slots are utilized efficiently without paying an unnecessary inflation tax.
* **Target Stakeholder Teams:** 
  1. *Scouting Directorate* (Auction targeting and bidding caps)
  2. *Head Coach & Captain* (Playing XI composition strategy)
  3. *Financial Analytics Team* (ROI tracking per slot)

---

## 💡 Strategic Recommendations & Action Plan
Based on data patterns, the following structured recommendations are proposed for stakeholder implementation:

| Priority | Action Item | Owner of Action | Expected Impact | Metric to Track |
| :--- | :--- | :--- | :--- | :--- |
| **High** | Enforce a strict individual player salary cap ceiling of **18%** to prevent over-exposure to single-asset injuries. | Franchise CEO & Head of Cricket Operations | Mitigates financial and operational risk during performance dips. | Max single-player salary percentage of total cap. |
| **Medium** | Reallocate unallocated auction capital toward high-ceiling mid-tier domestic talent (5 Cr–15 Cr bracket). | Lead Scout & Auction Strategist | Broadens squad depth and reduces heavy reliance on bottom-tier roster fillers. | Average on-field performance rating of mid-tier signees. |
| **Medium** | Institute an ROI performance audit comparing overseas player valuation premiums against domestic output. | Analytics Directorate | Optimizes auction bidding efficiency for scarce international slots. | Cost-per-run / cost-per-wicket efficiency ratio. |

---

## 💻 Exploring the Code
You can review the fully commented, production-grade SQL scripts utilized for this audit in the [IPL salary analysis.sql/](IPL salary analysis.sql/) directory (tested and executed on MySQL 8.0).
