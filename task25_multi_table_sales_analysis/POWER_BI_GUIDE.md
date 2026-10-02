# Power BI Dashboard Guide — Task 25

## Recommended model
Load these three core tables:
- `customers.csv` — one row per customer
- `products.csv` — one row per product
- `orders.csv` — one row per order

Relationships:
- customers[CustomerID] 1 → * orders[CustomerID]
- products[ProductID] 1 → * orders[ProductID]

Use single-direction filtering from dimensions to orders.

## Measures
```DAX
Total Sales = SUM(orders[NetSales])

Total Orders = DISTINCTCOUNT(orders[OrderID])

Units Sold = SUM(orders[Quantity])

Average Order Value = DIVIDE([Total Sales], [Total Orders])

Discount Amount = SUM(orders[DiscountAmount])

Gross Sales = SUM(orders[GrossSales])
```

## Suggested visuals
1. KPI cards: Total Sales, Total Orders, Units Sold, Average Order Value.
2. Line chart: Month vs Total Sales.
3. Bar chart: Category vs Total Sales.
4. Bar chart/map: Country vs Total Sales.
5. Table: ProductName, Category, Total Sales, Units Sold.
6. Slicers: OrderDate, Country, Segment, Category.

## Validation
Direct order total = `982,741.38`.
Joined total = `982,741.38`.
They match, so the joins do not double-count sales.

## Double-counting warning
Do not join two fact-like tables at different grains without controlling the grain. Before summing sales, validate key uniqueness and relationship cardinality. Use `DISTINCTCOUNT(OrderID)` for order counts.
