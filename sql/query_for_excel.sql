SELECT
    f.transaction_id,
    f.date,
    c.month,
    c.quarter,
    c.is_ramadan_period,
    p.product_name,
    p.category,
    p.sub_category,
    p.brand,
    o.outlet_name,
    o.outlet_type,
    o.region,
    o.city,
    d.distributor_name,
    f.qty_sold,
    f.sell_in_value,
    f.sell_out_value,
    f.stock_available
FROM fact_sales f
JOIN dim_product p ON f.product_id = p.product_id
JOIN dim_outlet o ON f.outlet_id = o.outlet_id
JOIN dim_distributor d ON f.distributor_id = d.distributor_id
JOIN dim_calendar c ON f.date = c.date;