# Task 25 — Multi-Table Sales Analysis

This project combines **orders, products, and customers** for end-to-end relational sales analysis.

## Tools
- SQL / SQLite
- Power BI-ready CSV files
- Python-generated dashboard preview

## Deliverables
- `orders.csv`
- `products.csv`
- `customers.csv`
- `multi_table_sales.db`
- `task25_analysis.sql`
- `dashboard_preview.png`
- `dashboard.html`
- `POWER_BI_GUIDE.md`
- `5_insights.md`
- Aggregated CSV files for Power BI

## Validation result
- Orders: 900
- Customers: 80
- Products: 50
- Net Sales: 982,741.38
- Orphan customer references: 0
- Orphan product references: 0
- Direct total = joined total: 982,741.38 = 982,741.38

## How to use
1. Open `task25_analysis.sql` in SQLite/MySQL-compatible SQL tooling.
2. Import the three core CSVs into Power BI.
3. Create the two relationships described in `POWER_BI_GUIDE.md`.
4. Add the DAX measures and recommended visuals.
5. Use `dashboard_preview.png` as the dashboard layout reference.
6. Open `dashboard.html` in a browser for a simple interactive-ready project page.

## Dataset note
The included dataset is a **Northwind-style synthetic relational dataset** created specifically for this Task 25 practice exercise. It preserves the required relational structure and is suitable for demonstrating joins, validation, aggregation, and dashboarding.
