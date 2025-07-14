SELECT
    s.products_id,
    s.date_date,
    s.orders_id,
    s.revenue,
    s.quantity,
    CAST(p.purchase_price AS FLOAT64) AS purchase_price,
    CAST(ROUND(s.quantity * CAST(p.purchase_price AS FLOAT64), 2) AS INT64) AS purchase_cost,
    CAST(ROUND(s.revenue - s.quantity * CAST(p.purchase_price AS FLOAT64), 2) AS INT64) AS margin
FROM
    {{ ref("stg_raw__sales") }} s
LEFT JOIN
    {{ ref("stg_raw__product") }} p ON s.products_id = p.products_id