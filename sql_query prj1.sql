create table retail sales(
 transactions_id int primary key,
 sale_date	date,
 sale_time	time,
 customer_id	int,
 gender	varchar(10),
 age int,	
 category varchar(15),	
 quantiy int,	
 price_per_unit	float,
 cogs	float,
 total_sale float
);
select * from retail_sales;
select count(*) from retail_sales;

-- DATA CLEANING

select * from retail_sales
where
quantiy is NULL
OR 
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is Null
or
customer_id is Null
or 
gender is Null
or
age is Null
or
category is Null
or
price_per_unit is Null
or
cogs is Null
or
total_sale is Null
delete from retail_sales
where
quantiy is NULL
OR 
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is Null
or
customer_id is Null
or 
gender is Null
or
age is Null
or
category is Null
or
price_per_unit is Null
or
cogs is Null
or
total_sale is Null

--DATA EXPLORATION

--HOW MANY SALES WE HAVE
SELECT COUNT(*)AS TOTAL_SALE FROM RETAIL_SALES;

--HOW MANY UNIQUE CUSTOMERS WE HAVE
SELECT COUNT(DISTINCT CUSTOMER_ID)AS CUSTOMERS FROM RETAIL_SALES;

--DATA ANALYSIS

--1-- WRITE  A SQL QUERY  TO RETRIEVE ALL COLUMNS FOR SALES MADE ON 2022-11-05

SELECT * FROM RETAIL_SALES 
WHERE sale_date='2022-11-05';

--2--WRITE A SQL QUERY TO RETRIEVE ALL TRANSATIONS WHERE THE CATEGORY IS "CLOTHING" AND QUANTITY SOLD IS >3 IN THE MONTH OF NOV-22
SELECT *
FROM RETAIL_SALES
WHERE 
CATEGORY='Clothing'
and 
to_char(sale_date,'YYYY-MM')='2022-11'
AND
quantiy>=3 

--3--WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY 

SELECT 
CATEGORY,
SUM (TOTAL_SALE)AS NETSALE,
COUNT(*)AS TOTALORDERS
FROM RETAIL_SALES
GROUP BY 1


--4--WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM BEAUTY CATEGORY

SELECT 
AVG(AGE) AS AVG_AGE
FROM RETAIL_SALES
WHERE CATEGORY='Beauty'


--5-- WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE TOTAL SALE IS >1000

SELECT * FROM RETAIL_SALES
WHERE TOTAL_SALE>1000

--6-- WRITE A SQL QUERY TO FIND TOTAL NO.OF TRANSACTIONS (TRANSACTION _ID)MADE BY EACH GENDER IN EACH CATEGORY

SELECT 
CATEGORY,
GENDER,
COUNT(*)AS TOTAL_TRANS
FROM RETAIL_SALES
GROUP 
BY 
CATEGORY,
GENDER
ORDER BY 1

--7--WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH.FIND OUT EST SELLING MONTH IN EACH YEAR(if we want rank use rank asked in interview)

SELECT 
 year,
 month,
 avg_sale
from
(
select
	EXTRACT(year from sale_date)as year,
	extract(month from sale_date)as month,
	AVG(TOTAL_SALE)AS AVG_SALE,
    RANK()over
	(PARTITION by EXTRACT(year from sale_date) order by AVG(TOTAL_SALE) desc) as rank
from retail_sales
group by 1,2
)as t1 
where rank=1
--order by 2,3

--WRITE A SQL QUERY TO FIND OUT TOP 5 CUSTOMERS BASED ON HIGHEST TOTAL SALES

SELECT  
customer_id,
sum(total_sale)as total_sales
FROM RETAIL_SALES
group by 1
order by 1,2
limit 5

--9--WRITE A SQL QUERY TO FIND THE NO.OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY

SELECT
	CATEGORY,
	COUNT(DISTINCT CUSTOMER_ID)AS UNIQUE_CUSTOMERS
FROM RETAIL_SALES
GROUP BY 1

--10-- WRITE A SQL QUERY TO CREATE EACH SHIFT AND NO.OF ORDERS(EX:MRNG<=12, AFTRN BTWN 12-17, EVNG>17)

WITH hourly_sale
as
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift






























































































