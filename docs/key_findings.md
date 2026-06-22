# 📊 Key Findings & Business Recommendations
## Silent Drift — E-Commerce Churn Analysis

---

## Executive Summary

| Metric | Value |
|--------|-------|
| Total Customers | 89,075 |
| Churned Customers | 33,340 (37.43%) |
| Active Customers | 55,735 |
| Total Revenue | ₹1.92 Billion |
| Revenue Lost to Churn | ₹543.6 Million (28.1%) |
| Active Revenue Retained | ₹1.38 Billion (71.9%) |
| High Risk Customers | 9,069 |
| Medium Risk Customers | 38,931 |
| Revenue at Immediate Risk | ₹9.84 Million |
| Avg Risk Score | 39.9 |
| Lost Customers (RFM) | 2,672 |
| Total Complaints | 26,830 |
| Total Orders | 887,510 |
| Total Sessions | 674,973 |
| Avg Order Value | ₹1,637.65 |

---

## Finding 1 — Recency is the #1 Churn Driver

| Recency Bucket | Churn Rate |
|----------------|------------|
| 0–30 days | 16.47% |
| 31–90 days | 15.71% |
| 91–180 days | 24.48% |
| 181–365 days | 40.4% |
| 365+ days | 54.48% |
| Unknown | 36.7% |

> **Insight:** Customers inactive for 365+ days churn at **54.48%** — nearly **3x higher** than recent buyers (0–30 days at 16.47%). Recency is the strongest single predictor of churn across the entire customer base.

### Recommendations:
- Trigger automated re-engagement email/SMS at the **90-day inactivity mark**
- Offer a personalized win-back discount at **180 days** of inactivity
- Flag all **365+ day inactive** customers as high-priority at-risk and escalate to the retention team immediately

---

## Finding 2 — Membership Tier Directly Controls Churn

| Membership Tier | Churn Rate |
|-----------------|------------|
| None | 53.08% |
| Silver | 38.66% |
| Gold | 30.15% |
| Platinum | 23.68% |

> **Insight:** None-tier customers churn at **53.08%** — more than **2x the Platinum rate of 23.68%**. Every tier upgrade results in a meaningful reduction in churn, making membership the most actionable lever for retention.

### Recommendations:
- Offer a **free Silver trial** after the 2nd purchase for all None-tier customers
- Actively show None-tier customers the benefits they are missing out on
- Target high-spend None-tier customers with personalised **Gold upgrade offers**

---

## Finding 3 — Churn is Growing Year-Over-Year

| Year | Churned Count |
|------|---------------|
| 2021 | ~1,500 |
| 2022 | ~6,800 |
| 2023 | ~14,000 (Peak) |
| 2024 | ~11,000 |

> **Insight:** Annual churn surged from ~1,500 in 2021 to a peak of ~14,000 in 2023 — a **~9x increase in just two years**. While 2024 shows a slight dip to ~11,000, the churn level remains critically elevated and requires urgent structural intervention.

### Recommendations:
- Set up **monthly churn rate monitoring alerts** — trigger review if churn exceeds a defined threshold
- Investigate the product, pricing, or experience changes that drove the sharp **2022–2023 acceleration**
- Implement a **proactive retention strategy** before churn compounds further into 2025

---

## Finding 4 — Risk Tier Distribution

| Risk Tier | Customers | Revenue Held |
|-----------|-----------|--------------|
| 🟢 Low Risk | ~41,075 (44.5%) | ₹1.15B |
| 🟡 Medium Risk | 38,931 (45%) | ₹758.84M |
| 🔴 High Risk | 9,069 (10.5%) | ₹9.84M |
| **Grand Total** | **89,075** | **₹1.92B** |

> **Insight:** High-risk customers represent **10.5% of the base** and hold **₹9.84M in revenue at immediate risk**. Medium Risk holds far more total revenue at ₹758.84M — making it the largest pool of at-risk value overall.

### Recommendations:
- Launch **immediate outreach** to all 9,069 High Risk customers with a targeted retention offer
- Run a **Medium Risk nurture campaign** — this segment holds nearly 80x more total revenue than High Risk
- Within each tier, prioritise **high-spend customers** first for maximum ROI on retention spend

---

## Finding 5 — Demographics Do NOT Drive Churn

| Dimension | Churn Rate Range | Conclusion |
|-----------|-----------------|------------|
| Device | 37.02% – 38.01% | No meaningful impact |
| Age Group | 37.01% – 38.87% | No meaningful impact |
| Gender | 36.76% – 37.62% | No meaningful impact |
| Acquisition Channel | 36% – 38% | No meaningful impact |

**Device breakdown:**
- Mobile App: 38.01%
- Desktop: 37.83%
- Tablet: 37.1%
- Mobile: 37.02%

**Gender breakdown:**
- Female: 37.62%
- Male: 37.33%
- Other: 37.03%
- Unknown: 36.76%

**Acquisition Channel:**  All channels (Facebook Ads, Affiliate, Influencer, Email Campaign, Instagram, Google Ads, Direct, Referral, Organic Search) cluster tightly between **36–38%**. WhatsApp is the lowest at ~36%.

> **Insight:** Churn is nearly identical across all devices, age groups, genders, and acquisition channels. Demographics and channels do **not** predict churn in this dataset.

### Recommendations:
- **Do not build demographic-specific retention strategies** — this is a waste of budget
- All retention spend should be laser-focused on **recency-based re-engagement**
- Focus on **WHEN customers last bought**, not WHO they are or HOW they were acquired

---

## Finding 6 — Customer Segments (RFM Analysis)

| Customer Segment | Count |
|-----------------|-------|
| At Risk | 27,079 |
| Loyal Customers | 25,975 |
| About to Churn | 17,987 |
| Champions | 12,829 |
| Lost | 2,672 |

> **Insight:** "At Risk" is the **largest customer segment at 27,079**, followed closely by Loyal Customers at 25,975. Combined, "At Risk" and "About to Churn" account for over **45,000 customers** actively showing churn signals — indicating the majority of the customer base is already vulnerable.

### Recommendations:
- 🔴 **Immediate action** on "About to Churn" (17,987) — these are in the last window before exit
- 🟡 **Nurture Loyal Customers** (25,975) to protect them from sliding into "At Risk"
- 🟢 **Champions** (12,829) — reward and retain via exclusive perks to maximise LTV
- ⚫ **Lost customers** (2,672) — run a win-back campaign with compelling incentives

---

## Finding 7 — Top High Risk Customer Profile

From the Top High Risk Customers table:
- All top high-risk customers have a **Churn Risk Score of 100**
- Membership Tier: **None** across all top high-risk customers
- Segments: Mix of **Lost** and **About to Churn**
- **Churn reasons cited:** App/website issues, Product quality issues, Poor customer service, Found better alternative, Moved to competitor, No longer needed, Other
- Cities include: Haora, Madurai, Nashik, Raipur, Navi Mumbai, Dhanbad, Vijayawada

> **Insight:** The highest-risk customers are overwhelmingly **non-members** and are churning due to **product, platform, and service quality issues** — not price. This points to a product experience gap more than a pricing or awareness problem.

### Recommendations:
- Prioritise fixing **app/website UX issues** — cited as the most common technical churn reason
- Escalate **"moved to competitor"** cases for win-back outreach with a strong counter-offer
- Immediately enrol top high-risk None-tier customers into a **free membership trial** to increase stickiness

---

## Summary — Priority Action Matrix

| Priority | Action | Expected Impact |
|----------|--------|----------------|
| 🔴 Immediate | Contact 9,069 High Risk customers with retention offer | ₹9.84M revenue protected |
| 🔴 Immediate | Re-engagement campaign for 365+ day inactive customers | Reduce 54.48% churn rate |
| 🔴 Immediate | Act on 17,987 "About to Churn" segment | Prevent largest imminent exit wave |
| 🟡 Short Term | Free Silver upgrade push for all None-tier customers | Reduce 53.08% → ~23% churn |
| 🟡 Short Term | Set up monthly churn monitoring + alert thresholds | Early warning system |
| 🟡 Short Term | Fix app/website issues cited in churn reasons | Address top product churn driver |
| 🟢 Long Term | Investigate root cause of 2022–2023 churn acceleration | Prevent recurrence of growth spike |
| 🟢 Long Term | Win-back campaign for 2,672 Lost customers | Revenue recovery from dormant base |
| 🟢 Long Term | Nurture Medium Risk segment (₹758.84M at stake) | Protect largest revenue pool |

---

*Dashboard: Silent Drift — E-Commerce Churn Analysis | Data Source: Power BI Dashboard*
