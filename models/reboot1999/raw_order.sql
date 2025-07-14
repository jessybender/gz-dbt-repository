select
    customer_id,
    min(ordered_at) as first_order_date,
    max(ordered_at) as last_order_date,
    count(order_id) as total_orders
from {{ ref('orders') }}
group by customer_id
