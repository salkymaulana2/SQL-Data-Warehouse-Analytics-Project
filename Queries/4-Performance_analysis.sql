/* Analyze the yearly performance of products by comparing their sales
to both the average sales performance of product and the previous years sales */

with yearly_product_sales as 
(
	select 
	year(f.order_date) as order_year,
	p.product_name,
	sum(f.sales_amount) as current_sales
	from gold.fact_sales as f
	left join gold.dim_products as p
	on f.product_key = p.product_key
	where f.order_date is not null
	group by year(f.order_date), p.product_name
)
select order_year, product_name, current_sales,
avg(current_sales) over (partition by product_name) as avg_sales,
current_sales - avg(current_sales) over (partition by product_name) as diff_avg,
case	when current_sales - avg(current_sales) over (partition by product_name) > 0 then 'above average' 
		when current_sales - avg(current_sales) over (partition by product_name) < 0 then 'below average'
		else 'average' end as avg_change,

--- year - over - year analysis --

lag(current_sales) over (partition by product_name order by order_year) as prv_sales,
current_sales - lag(current_sales) over (partition by product_name order by order_year) as diff_prv,
case	when current_sales - lag(current_sales) over (partition by product_name order by order_year) > 0 then 'increase' 
		when current_sales - lag(current_sales) over (partition by product_name order by order_year) < 0 then 'decrease'
		else 'same' end as prv_change
from yearly_product_sales
order by product_name, order_year