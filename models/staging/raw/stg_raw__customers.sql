with

    customers as (
        select
            string_field_0 as customer_id, 
            string_field_1 as customer_name
        from {{ source("raw", "customers") }}
    ),

    orders as (
        select
            id, 
            customer,
            ordered_at
        from {{ source("raw", "orders") }}
    ),

    orders_per_customer as (
        select
            o.customer,
            count(o.id) as total_orders,
            min(o.ordered_at) as first_purchase,
            max(o.ordered_at) as last_purchase
        from orders o
        group by o.customer
    )

select
    c.customer_id,
    c.customer_name,
    pc.first_purchase,
    pc.last_purchase,
    coalesce(pc.total_orders, 0) as total_orders
from customers c
left join orders_per_customer pc
    on c.customer_id = pc.customer
order by total_orders desc