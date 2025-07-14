SELECT
    o.orders_id,
    o.date_date,

    -- Operational margin calculation with type casting
    ROUND(
        o.margin 
        + SAFE_CAST(s.shipping_fee AS FLOAT64) 
        - (SAFE_CAST(s.log_cost AS FLOAT64) + SAFE_CAST(s.ship_cost AS FLOAT64)),
        2
    ) AS operational_margin,

    -- Order details
    o.quantity,
    o.revenue,
    o.purchase_cost,
    o.margin,

    -- Shipping costs
    SAFE_CAST(s.shipping_fee AS FLOAT64) AS shipping_fee,
    SAFE_CAST(s.log_cost AS FLOAT64) AS log_cost,
    SAFE_CAST(s.ship_cost AS FLOAT64) AS ship_cost

FROM {{ ref('int_orders_margin') }} AS o
LEFT JOIN {{ ref('stg_raw__ship') }} AS s
    USING (orders_id)

ORDER BY o.orders_id DESC

