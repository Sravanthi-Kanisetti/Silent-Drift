# 🔇 Silent Drift — E-Commerce Customer Churn Analysis

> *"Customers don't always say goodbye. They just stop showing up."*

**Tools:** BigQuery · SQL · Looker Studio · Google Cloud Platform  
**Dataset:** 1,05,000 rows · 34 columns · Jan 2021 – Jun 2024

---

## 📊 Live Dashboard
🔗 [Click here to view Dashboard](https://datastudio.google.com/reporting/aaa25d00-0e9b-4db2-867e-b3bb14ed35dd)

---

## 📌 What is Silent Drift?

In e-commerce, most customers don't cancel — they simply **stop buying**.  
No warning. No complaint. No goodbye.  
This is called **Silent Churn** — and it costs businesses millions.

This project answers:
- How many customers silently exited — and how much revenue did we lose?
- Which customers are about to exit next?
- What behaviour patterns predict a silent exit?
- How do we stop it before it happens?

---

## 🖼️ Dashboard Preview

### Page 1 — Executive Overview
![Executive Overview](dashboard/page1_executive_overview.png)

### Page 2 — Customer and Behavior Analysis
![Customer Behavior](dashboard/page2_customer_analysis.png)

### Page 3 — Revenue & Risk Analysis
![Revenue Risk](dashboard/page3_risk_analysis.png)



---

## 📊 Dashboard Pages

| Page | Title | Story |
|------|-------|-------|
| Page 1 | Executive Overview | What is our overall churn situation? |
| Page 2 | Customer Behavioral Analysis | Who churns and when? |
| Page 3 | Revenue & Risk Analysis | Where is money at risk? |


---

## 🔑 Key Findings (From Dashboard)

### Page 1 — Executive Overview

| Metric | Value |
|--------|-------|
| Total Customers | 89,075 |
| Churn Rate | 37.43% |
| Churned Customers | 33,340 |
| Revenue Lost | ₹543.6M |
| Active Customers | 55,735 |
| Total Revenue | ₹1.92 Billion |
| Active Revenue Share | 71.9% |
| Churned Revenue Share | 28.1% |

**Membership Tier Churn Rates:**

| Tier | Churn Rate |
|------|------------|
| None | 53.08% |
| Silver | 38.66% |
| Gold | 30.15% |
| Platinum | 23.68% |

**Yearly Churn Growth:**

| Year | Churned Customers |
|------|------------------|
| 2021 | 1,500 |
| 2022 | 6,800 |
| 2023 | 14,000 |
| 2024 | 11,000 (Jan–Jun only) |

> 💡 **Insight:** None-tier members are 2x more likely to churn than Platinum, and yearly churn has grown 9x since 2021 — signaling an urgent need for retention intervention.

---

### Page 2 — Customer and Behavior Analysis

| Metric | Value |
|--------|-------|
| Total Complaints | 26,830 |
| Total Orders Placed | 887,510 |
| Total Sessions | 674,973 |
| Avg Order Value | ₹1,637.65 |
| Total Revenue Lost | ₹543.6M |

**Churn Rate by Recency Bucket:**

| Recency | Churn Rate |
|---------|------------|
| 0–30 days | 16.47% |
| 31–90 days | 15.71% |
| 91–180 days | 24.48% |
| 181–365 days | 40.40% |
| 365+ days | **54.48%** |

**Churn Rate by Device:**

| Device | Churn Rate |
|--------|------------|
| Mobile App | 38.01% |
| Desktop | 37.83% |
| Tablet | 37.10% |
| Mobile | 37.02% |

**Churn Rate by Gender:**

| Gender | Churn Rate |
|--------|------------|
| Female | 37.62% |
| Male | 37.33% |
| Other | 37.03% |
| Unknown | 36.76% |

**Churn Rate by Acquisition Channel:** All channels uniform at ~36–38%. Facebook Ads, Influencer, Google Ads, Email Campaign, Instagram, Affiliate all at 38%. WhatsApp lowest at 36%.

> 💡 **Insight:** Customers inactive for 365+ days churn at 54.48% — nearly 3x higher than recent buyers, making timely re-engagement the #1 retention priority.

---

### Page 3 — Revenue & Risk Analysis

| Metric | Value |
|--------|-------|
| High Risk Customers | 9,069 |
| Medium Risk Customers | 38,931 |
| Revenue At Risk | ₹9.84M |
| Avg Risk Score | 39.9 |
| Lost Customers | 2,672 |

**Risk Tier Distribution:**

| Risk Tier | % of Base |
|-----------|-----------|
| 🟢 Low Risk | 44.5% |
| 🟡 Medium Risk | 45% |
| 🔴 High Risk | 10.5% |

**Revenue by Risk Tier:**

| Risk Tier | Revenue |
|-----------|---------|
| Low Risk | ₹1.15B |
| Medium Risk | ₹758.84M |
| High Risk | ₹9.84M |
| **Grand Total** | **₹1.92B** |

**Customer Segments (RFM):**

| Segment | Customers |
|---------|-----------|
| At Risk | 27,079 |
| Loyal Customers | 25,975 |
| About to Churn | 17,987 |
| Champions | 12,829 |
| Lost | 2,672 |

> 💡 **Insight:** High-risk customers (10.5% of base) hold ₹9.84M revenue at risk — immediate retention outreach needed before they churn.

---

## 🗂️ Dataset Overview

- **Source:** Synthetically generated realistic Indian e-commerce data
- **Size:** 1,05,000 rows · 34 columns
- **Period:** January 2021 – June 2024
- **Churn Rate:** 37.43%
- **Total Revenue:** ₹1.92 Billion

### Intentional Data Quality Issues (Real-world simulation)

| Issue | Description | Count |
|-------|-------------|-------|
| Null/invalid emails | Missing @, junk values (N/A, null@, test@) | ~2,400 |
| Invalid ages | Values like 0, -1, 150, 999 | ~500 |
| Negative spend | Negative total_spent_inr values | ~182 |
| Membership typos | Sivler, G0ld, Platinium, Platnium | ~3% rows |
| Impossible returns | total_returns > total_orders | ~1,050 |
| Future signup dates | Dates beyond June 2024 | 50 rows |
| Duplicate records | Same customer multiple times | ~1,575 |
| Mixed gender formats | M, F, 0, 1, male, MALE, female | ~2,000 |
| Mixed payment formats | upi, CREDIT CARD, cod, Net banking | ~1,800 |
| Invalid ratings | Values outside 1–5 range | ~900 |

---

## 🔧 Tech Stack

| Tool | Purpose |
|------|---------|
| **Google BigQuery** | Data storage, cleaning, analysis |
| **SQL (BigQuery dialect)** | All transformations, window functions, RFM scoring |
| **Looker Studio** | 3-page interactive dashboard |
| **Google Cloud Platform** | Cloud infrastructure |
| **Python (pandas, numpy)** | Dataset generation |

---

## 📁 Project Structure

```
Silent-Drift/
│
├── README.md
│
├── BigQuery_SQL_Scripts/
│   ├── 01.data_exploration.sql
│   ├── 02.data_cleaning_validation.sql
│   ├── 03.deep_analysis_RFM.sql
│   └── 04.creating_views.sql
│
├── docs/
│   ├── data_dictionary.md
│   ├── key_findings.md
│   └── project_flow.html
│
├── dashboard/
│   ├── page1_executive_overview.png
│   ├── page2_customer_analysis.png
│   ├── page3_risk_analysis.png
│
│
└── data/
    ├── customers_raw.jpeg
    └── customers_clean.png
```

---

## 🧹 Data Cleaning Highlights

All cleaning done using `CREATE OR REPLACE TABLE` in BigQuery.  
Raw data is **never modified** — cleaning creates a separate `clean_customers` table.

| Column | Issue Found | Fix Applied |
|--------|-------------|-------------|
| `email` | Nulls, missing @, junk values | CASE + LIKE + IN checks |
| `phone` | Mixed formats (+91-XXXXX), short numbers | REGEXP_REPLACE + RIGHT(10) |
| `gender` | M/F/0/1/male/MALE formats | UPPER + CASE standardization |
| `age` | Impossible values (0, -1, 150, 999) | NULL out invalid range |
| `membership_tier` | Typos: Sivler, G0ld, Platinium | LOWER + IN list matching |
| `total_spent_inr` | Negatives, zero with orders | ABS() for negatives, NULL for zeros |
| `avg_order_value_inr` | Missing but calculable | Recalculate from spent ÷ orders |
| `total_returns` | Returns > Orders (impossible) | Cap at total_orders |
| `avg_product_rating` | Values outside 1–5 range | NULL out invalid |
| `duplicates` | ~1,575 duplicate records | ROW_NUMBER() + QUALIFY |

---

## 📈 Analysis Layers

### Layer 1 — Overall KPIs
Total customers: 89,075 · Churn rate: 37.43% · Revenue lost: ₹543.6M · Active customers: 55,735

### Layer 2 — Recency Analysis
365+ days inactive → **54.48% churn** vs **16.47%** for 0–30 day customers — 3x difference

### Layer 3 — Segment Analysis
Membership · Gender · Age Group · Acquisition Channel · Device · Payment · Category  
All devices and channels show uniform ~37–38% churn — engagement drives churn, not demographics

### Layer 4 — Revenue Impact
₹543.6M lost (28.1%) · ₹9.84M at immediate risk from 9,069 high-risk active customers

### Layer 5 — RFM + Churn Risk Scoring (No ML)
- **R** (Recency): Days since last purchase → NTILE(5) score 1–5
- **F** (Frequency): Total orders → NTILE(5) score 1–5
- **M** (Monetary): Total spend → NTILE(5) score 1–5
- **Risk Score:** Rule-based 0–100 using 5 weighted factors
- **Segments:** Champions (12,829) · Loyal Customers (25,975) · At Risk (27,079) · About to Churn (17,987) · Lost (2,672)

---

## 🚨 Risk Score Distribution

| Risk Tier | Customers | % of Base | Revenue |
|-----------|-----------|-----------|---------|
| 🟢 Low Risk | ~39,075 | 44.5% | ₹1.15B |
| 🟡 Medium Risk | 38,931 | 45% | ₹758.84M |
| 🔴 High Risk | 9,069 | 10.5% | ₹9.84M |

---

## 💡 Business Recommendations

| Priority | Action | Impact |
|----------|--------|--------|
| 🔴 P1 | Contact 9,069 High Risk customers immediately | ₹9.84M protected |
| 🔴 P1 | Re-engagement campaign after 90 days inactivity | Reduce 54.48% churn |
| 🟡 P2 | Push Silver upgrades to None-tier (53.08% churn) | Target Platinum level 23.68% |
| 🟡 P2 | Exit surveys for 33,340 churned customers | Identify root causes |
| 🟢 P3 | Monthly churn monitoring alerts | Early warning system |
| 🟢 P3 | Win-back campaign for 2,672 Lost segment | Revenue recovery |

---

## 💼 Resume Description

> **Silent Drift — E-Commerce Customer Churn Analysis** | BigQuery · SQL · Looker Studio · GCP
> - Cleaned and analyzed **1,05,000 customer records**, resolving 15+ real-world data quality issues including invalid emails, impossible ages, negative spend, duplicates, and mixed-format fields
> - Built a **SQL-based RFM churn risk scoring model** (no ML) — identified 9,069 high-risk active customers representing **₹9.84M revenue at immediate risk**
> - Discovered customers inactive 365+ days churn at **54.48% vs 16.47%** for recent buyers — 3x higher
> - Quantified **₹543.6M revenue lost** to churn (28.1% of ₹1.92B total)
> - Delivered **3-page interactive Looker Studio dashboard** with  RFM risk table, segment analysis, and business insight notes

---

## 👤 Author
**Sravanthi Kanisetti**  
[LinkedIn](https://www.linkedin.com/in/sravanthi-kanisetti-116a542b6/) 
















