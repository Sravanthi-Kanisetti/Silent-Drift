# 🛒 E-Commerce Customer Churn Analysis
**Tools:** BigQuery · SQL · Looker Studio · Google Cloud Platform

---

## 📌 Project Overview
End-to-end churn analysis on 1,05,000 realistic Indian 
e-commerce customer records. Built entirely with SQL — 
no ML required.

---

## 📊 Live Dashboard
🔗 [Click here to view Dashboard](https://datastudio.google.com/reporting/aaa25d00-0e9b-4db2-867e-b3bb14ed35dd)

### Dashboard Preview
![Page 1](dashboard/page1_executive_overview.png)
![Page 2](dashboard/page2_customer_analysis.png)
![Page 3](dashboard/page3_risk_analysis.png)

---

## 🔑 Key Findings
| Finding | Insight |
|---------|---------|
| Overall Churn Rate | 37.43% of 89,075 customers churned |
| Revenue Lost | ₹543.6M lost to churned customers |
| Recency Impact | 365+ day inactive customers churn at 54.48% vs 16.47% for recent buyers |
| Membership Impact | None-tier members churn at 53% vs 23.68% for Platinum |
| High Risk Customers | 9,069 customers holding ₹9.84M revenue at immediate risk |
| Monthly Growth | Churn grew from 1.5K (2021) to 14K (2023) |

---

## 🗂️ Dataset
- **Size:** 1,05,000 rows · 34 columns
- **Period:** January 2021 – June 2024
- **Churn Rate:** 37.43%
- **Source:** Synthetically generated realistic Indian ecommerce data

### Data Quality Issues Fixed
| Issue | Count |
|-------|-------|
| Null/invalid emails | ~2,400 |
| Invalid ages | ~500 |
| Negative spend values | ~182 |
| Membership typos | ~3% rows |
| Impossible returns | ~1,050 |
| Future signup dates | 50 rows |
| Duplicate records | ~1,575 |
| Mixed gender formats | ~2,000 |

---

## 📁 Project Structure
\```
ecommerce-churn-analysis/
├── README.md
├── sql/
│   ├── 01_data_exploration.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_analysis.sql
│   └── 04_views.sql
├── dashboard/
│   ├── page1_executive_overview.png
│   ├── page2_customer_behavior.png
│   └── page3_revenue_risk.png
└── docs/
    ├── data_dictionary.md
    └── key_findings.md
\```

---

## 🧹 Data Cleaning Highlights
| Column | Issue | Fix |
|--------|-------|-----|
| email | Nulls, missing @, junk values | CASE + LIKE checks |
| phone | Mixed formats, short numbers | REGEXP_REPLACE |
| gender | M/F/0/1/male/MALE | UPPER + CASE |
| age | Impossible values | NULL out invalid |
| membership_tier | Typos: Sivler, G0ld | LOWER + IN list |
| total_spent_inr | Negatives, impossible zeros | ABS() + NULL |
| total_returns | Returns > Orders | Cap at total_orders |
| duplicates | ~1,575 records | ROW_NUMBER + QUALIFY |

---

## 📈 Analysis Layers
| Layer | Description |
|-------|-------------|
| Layer 1 | Overall KPIs — churn rate, revenue, active vs churned |
| Layer 2 | Recency Analysis — churn by inactivity period |
| Layer 3 | Segment Analysis — membership, channel, age, device, gender |
| Layer 4 | Revenue Impact — money lost, revenue at risk |
| Layer 5 | RFM + Churn Risk Scoring — rule-based 0-100 score, no ML |

---

## 💼 Resume Description
> **E-Commerce Customer Churn Analysis** | BigQuery · SQL · Looker Studio · GCP
> - Cleaned 1,05,000 records resolving 15+ data quality issues
> - Built SQL-based RFM churn risk scoring — identified 9,069 high-risk customers representing ₹9.84M revenue at risk
> - Discovered 365+ day inactive customers churn at 54.48% vs 16.47% — key retention insight
> - Quantified ₹543.6M revenue lost to churn (28.1% of ₹1.92B total)
> - Built 3-page interactive Looker Studio dashboard with filters and insight notes

---

## 👤 Author
**Your Name**
[LinkedIn](your-linkedin-url)
