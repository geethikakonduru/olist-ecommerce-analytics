# Brazilian E-Commerce Analytics (Olist Dataset)

## Project Overview
End-to-end customer analytics project using the Olist public dataset (100k+ orders, 9 related tables). The project covers cohort retention analysis, RFM customer segmentation, CLV calculation, and revenue performance — delivered through advanced SQL and an interactive Power BI dashboard.

## Key Business Questions Answered
- Which customer cohorts retain best after 30, 60, and 90 days?
- How are customers distributed across RFM segments?
- What percentage of customers are At Risk of churning?
- Does review score correlate with repeat purchase behaviour?
- Which product categories drive cumulative revenue growth?

## Key Findings
- 23.5% of customers fall into the At Risk segment(high past spend but no recent activity) representing the largest opportunity for re-engagement campaigns
- Customers who leave a 5-star review have a measurably higher repeat purchase rate than those who leave 1-star reviews
- Cohort retention drops significantly after month 1, consistent with a marketplace model where most customers are one-time buyers

## Technical Stack
- Python (pandas) — data loading and validation
- SQLite — relational database and SQL analysis
- Power BI — interactive dashboard with DAX measures
- Git — version control

## SQL Techniques Used
- Multi-table JOINs across 5 tables
- CTEs (Common Table Expressions)
- Window functions: RANK, NTILE, ROW_NUMBER, running totals
- Cohort analysis using customer_unique_id
- RFM segmentation with NTILE scoring
- Date arithmetic with JULIANDAY and STRFTIME
- COALESCE for null handling

## Dashboard Pages
1. **Executive Overview** — Total revenue, orders, avg order value, monthly trend, revenue by category
2. **Cohort Retention** — Retention heatmap by acquisition month and months since first purchase
3. **Customer Segments** — RFM segment distribution, scatter plot, top customers
4. **Review Impact** — Review score vs repeat purchase rate and average order value

## Data Source
[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
