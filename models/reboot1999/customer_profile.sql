select
    c.customer_id,
    c.first_name || ' ' || c.last_name as full_name,
    coalesce(o.first_order_date, null) as first_order_date,
    coalesce(o.last_order_date, null) as last_order_date,
    coalesce(o.total_orders, 0) as total_orders
from {{ ref('customers') }} c
left join {{ ref('order_summary') }} o
    on c.customer_id = o.customer_id
