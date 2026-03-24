# E-commerce-User-Churn-Retention-Analysis-Meesho-Case-Study

> An end-to-end product analytics case study identifying why users stop buying, where churn originates, and how much revenue it costs the business.

## 🧩 The Problem  
Meesho is acquiring users — but it is not retaining them.

Nearly **1 in 2 users churns**, and a large portion of buyers never return after their first purchase. This creates a major gap in long-term revenue growth.

The challenge is not just identifying churn — but understanding:
- Where users disengage  
- Whether the issue is pricing, experience, or behavior  
- And how much revenue is being lost  

This project answers three key questions:

- **Why are users churning?**  
- **Is this a product, experience, or behavior problem?**  
- **What is the revenue impact, and how can it be fixed?**

## 🎯 Objectives  

- Measure churn rate and retention performance  
- Identify high-risk user segments  
- Analyze behavioral, transactional, and demographic drivers of churn  
- Evaluate delivery experience and pricing impact  
- Understand cohort retention patterns  
- Quantify revenue loss due to churn  
- Recommend product and growth strategies  

## 🗂️ Dataset  

| Table | Description |
|------|-------------|
| users.csv | 5,000 users with demographics, device, acquisition channel, churn |
| orders.csv | 12,946 orders with GMV, delivery, returns, ratings |
| sessions.csv | 72,365 sessions tracking user behavior |
| rfm_segments.csv | RFM-based segmentation (Champions, At Risk, etc.) |
| cohort_retention.csv | Monthly retention trends |

## 🛠️ Tools & Stack  

| Tool | Role |
|------|------|
| SQL | Data analysis, joins, cohort & churn queries |
| Excel | Data preprocessing |

## 📈 Key Findings  

### 1. Churn is extremely high — 49.9%  
Nearly **half the users churn**, meaning for every 2 users acquired, 1 is lost.  
Core problem: **Retention failure, not acquisition**

### 2. 37% of users are one-time buyers  
A massive portion of users purchase once and never return.  
Core problem: **First experience is not strong enough to drive repeat behavior**


### 3. Churned users spend MORE per order  
- Churned users AOV: ₹892  
- Retained users AOV: ₹869  
**Price is NOT the problem**  
Problem lies in **post-purchase experience**

### 4. ₹48.8 lakhs revenue lost due to churn  
- Revenue gap per user: ₹1,958  
- Total churned users: 2,495  
Massive **business impact of retention failure**

### 5. No single churn reason dominates  
All churn reasons are evenly distributed (~12–13%)  

Top issues:
- Wrong item received  
- Difficult returns  
- App issues  
 **Systemic product & experience problem — not one bug**

### 6. Paid Ads bring lowest-quality users  
- Paid Ads churn: 58.3%  
- App Store churn: 44.7%  
Company is spending more to acquire **low-intent users**

### 7. Low-end Android users churn the most  
- 54.6% churn vs 45% on iOS  
Strong signal of **app performance issues on budget devices**

### 8. Older users churn more (35+ segment)  
- 53–54% churn  
UX complexity & digital literacy barriers  

### 9. Delivery has a breaking point at 8 days  
- Ratings drop sharply after day 7  
- Returns increase significantly  
**7-day delivery SLA is critical**

### 10. Delivery fee does NOT drive churn  
Free delivery users churn almost the same as high-fee users  
Problem is **expectation mismatch**, not pricing  

### 11. First-order satisfaction does NOT affect churn  
- 1-star and 5-star users churn almost equally  
Churn is NOT satisfaction-driven  
It is a **habit formation problem**

### 12. Churned users show low engagement early  
- 67% shorter sessions  
- 80% lower conversion  
Users mentally disengage **before actual churn**

### 13. All cohorts collapse after Month 3  
Retention never exceeds ~28% beyond Month 3  
**Structural retention problem across all users**

### 14. ₹45.6 lakhs recoverable via RFM segments  
- At Risk + Hibernating users = major revenue pool  
Huge opportunity for **winback campaigns**

## 🔎 Core Diagnosis  

This is NOT a pricing problem.  
This is NOT a single feature problem.  

This is a **retention system failure** driven by:

- Poor post-purchase experience (delivery, returns, wrong items)  
- Low-quality acquisition (paid ads)  
- App performance issues (low-end Android)  
- Lack of habit formation  

Users don’t leave because they hate the product  
They leave because **they never build a habit to return**

## 📊 Data Visualization (Planned)  

Dashboard is currently in progress and will include:

- Churn & retention overview (KPI cards)  
- User segmentation by city, device, and acquisition channel  
- Funnel analysis (sessions → cart → purchase)  
- Cohort retention curves  
- RFM segment distribution  
- Revenue loss and recovery opportunity  

Tool: Power BI  

## 📌 Recommendations  

### Priority 1 — Build habit formation (Highest Impact)  
- Push notifications  
- Personalized recommendations  
- Reorder nudges  

### Priority 2 — Fix delivery experience  
- Enforce **7-day SLA**  
- Proactive delay communication  

### Priority 3 — Improve acquisition quality  
- Reduce paid ad spend  
- Focus on organic & referral channels  

### Priority 4 — Optimize app for low-end Android  
- Lightweight UI  
- Faster load times  
- Reduce crashes  

### Priority 5 — Launch winback campaigns  
- Target At Risk & Hibernating users  
- Recover ₹45.6 lakhs revenue  

## 🧪 Future Scope  

- A/B testing:
- Free delivery vs paid  
- Nudges vs no nudges  
- Churn prediction model  
- Lifecycle marketing automation  

## 💡 What This Project Demonstrates  

- Product thinking — identifying root causes, not just metrics  
- SQL expertise — advanced queries, cohort, segmentation  
- Business impact — revenue-focused insights  
- Analytical storytelling — converting data into decisions  
- PM mindset — actionable, prioritized recommendations  
