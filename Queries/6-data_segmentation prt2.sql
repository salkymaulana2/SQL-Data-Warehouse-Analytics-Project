/* group customers into 3 segments based on their behaviour:
VIP: at least 12 month, and history spending more than $5000
regular: at least 12 month, and history spending of $5000 or less
new: customer with lifespan less than 12 months
and find total customers of each group */

WITH customer_spending as (
	select c.customer_key, sum(f.sales_amount) as total_spending,
	min(order_date) as first_order,
	max(order_date) as last_order,
	datediff(month, min(order_date), max(order_date)) as lifespan
	from gold.fact_sales as f
	left join gold.dim_customers as c
	on f.customer_key = c.customer_key
	group by c.customer_key
	)

select customer_segment, count(customer_key) as total_customer
from (
select 
customer_key,
case when lifespan >= 12 and total_spending > 5000 then 'VIP'
     when lifespan >= 12 and total_spending <= 5000 then 'regular'
	 else 'new' end as customer_segment
from customer_spending) t
group by customer_segment
order by total_customer


