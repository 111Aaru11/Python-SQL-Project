select * from df_orders

--FIND TOP 10 HIGHEST REVENUE GENERATING PRODUCTS
select top 10 product_id, sum(sell_price) as sales
from df_orders
group by product_id
order by sales desc

--FIND TOP 5 HIGHEST SELLING PRODUCTS REGIONwise
select top 5 product_id, region, sum(sell_price) as sales
from df_orders
group by product_id, region
order by sales desc

select product_id, region, sum(sell_price) as sales
from df_orders
group by product_id, region
order by region,sales desc

--FIND TOP 5 HIGHEST SELLING PRODUCTS IN EACH REGION
--Method - 1
select distinct region from df_orders

select top 5 product_id, region, sum(sell_price) as sales 
from df_orders
where region = 'EAST'
group by product_id, region
order by sales desc

select top 5 product_id, region, sum(sell_price) as sales 
from df_orders
where region = 'South'
group by product_id, region
order by sales desc

select top 5 product_id, region, sum(sell_price) as sales 
from df_orders
where region = 'West'
group by product_id, region
order by sales desc

select top 5 product_id, region, sum(sell_price) as sales 
from df_orders
where region = 'Central'
group by product_id, region
order by sales desc

--Method - 2(cte and ranking)

with cte as(
select product_id, region,sum(sell_price) as sales
from df_orders
group by region,product_id)
select * from (
select *
	,rank() over(partition by region order by sales desc) as rn
from cte) A
where rn<=5

--FIND MONTH OVER MONTH GROWTH COMPARISON FOR 2022 AND 2023 SALES EG JAN 2022 VS JAN 2023
--Method-1
select distinct year(order_date) from df_orders

select year(order_date) as order_year ,month(order_date), 
sum(sell_price) as sales
from df_orders
where year(order_date) = '2023'
group by year(order_date),month(order_date)
order by month(order_date)

select year(order_date) as order_year ,month(order_date), 
sum(sell_price) as sales
from df_orders
where year(order_date) = '2022'
group by year(order_date),month(order_date)
order by month(order_date)

--Method-2

with cte as(
select year(order_date) as order_year, month(order_date) as order_month , sum(sell_price) as sales
from df_orders
group by year(order_date), month(order_date)
)
select order_month
, sum(case when order_year = 2022 then sales else 0 end) as sales_2022
, sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by order_month
order by order_month

--FOR EACH CATEGORY WHICH MONTH HAD HIGHEST SALES

select distinct category from df_orders

select category , max(sell_price) as sales
from df_orders
where category = 'Furniture'
group by category

select category , max(sell_price) as sales
from df_orders
where category = 'Office Supplies'
group by category

select category , max(sell_price) as sales
from df_orders
where category = 'Technology'
--group by category

--Method -2

with cte as (
select category ,year(order_date) as order_year, month(order_date) as order_month, sum(sell_price) as sales 
from df_orders
group by category,year(order_date), month(order_date)
)
select * from (
select *, 
	row_number() over(partition by category order by sales desc) as rn
from cte
) A 
where rn = 1

--OR

with cte as (
select category ,format(order_date,'yyyyMM') as order_date_format, max(sell_price) as sales 
from df_orders
group by category,format(order_date,'yyyyMM')
)
select * from (
select *, 
	row_number() over(partition by category order by sales desc) as rn
from cte
) A 
where rn = 1

--WHICH SUB-CATEGORY HAD THE HIGHEST GROWTH BY PROFIT IN 2023 COMPARE TO 2022

with cte as(
select sub_category,year(order_date) as order_year,
sum(sell_price) as sales
from df_orders
group by sub_category,year(order_date)
)
, cte2 as (
select sub_category
, sum(case when order_year = 2022 then sales else 0 end) as sales_2022
, sum(case when order_year = 2023 then sales else 0 end) as sales_2023
from cte
group by sub_category
)
select top 1 *, 
 (sales_2023 - sales_2023)*100/sales_2022
from cte2
order by (sales_2023 - sales_2023)*100/sales_2022