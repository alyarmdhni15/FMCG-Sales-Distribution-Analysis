-- Query 1: Total sell-out per kategori dan region
SELECT p.category, o.region, SUM(f.sell_out_value) AS total_sellout
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_outlet o ON f.outlet_id = o.outlet_id
GROUP BY p.category, o.region
ORDER BY total_sellout DESC;

-- Query 2: Growth month-over-month per kategori
SELECT c.month, p.category, SUM(f.sell_out_value) AS monthly_sales
FROM fact_sales f
JOIN dim_calendar c ON f.date = c.date
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY c.month, p.category
ORDER BY c.month;

-- Query 3: Distribution coverage (jumlah outlet aktif) per region
SELECT o.region, COUNT(DISTINCT o.outlet_id) AS active_outlets
FROM fact_sales f
JOIN dim_outlet o ON f.outlet_id = o.outlet_id
GROUP BY o.region;

-- Query 4: Out-of-stock rate per SKU
SELECT p.product_name,
       SUM(CASE WHEN f.stock_available = 0 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS oos_rate
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY oos_rate DESC;

-- Query 5: Sell-in vs sell-out gap per kategori
SELECT p.category, SUM(f.sell_in_value) AS sell_in, SUM(f.sell_out_value) AS sell_out,
       SUM(f.sell_in_value) - SUM(f.sell_out_value) AS gap
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.category;