CREATE DATABASE IF NOT EXISTS salesDataWalmart;  #This database stores Walmart sales data

USE salesDataWalmart;  #Switching to the salesDataWalmart database

CREATE TABLE IF NOT EXISTS sales(
  invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
  branch VARCHAR(5) NOT NULL,
  city VARCHAR(30) NOT NULL,
  customer_type VARCHAR(30) NOT NULL,
  gender VARCHAR(10) NOT NULL,
  product_line VARCHAR (100) NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  quantity INT NOT NULL,
  VAT FLOAT (6,4) NOT NULL,
  total DECIMAL(12,4) NOT NULL,
  date DATETIME NOT NULL,
  time TIME NOT NULL,
  payment_method VARCHAR(15) NOT NULL,
  cogs DECIMAL(10,2) NOT NULL,
  gross_margin_pct FLOAT(11,9),
  gross_income DECIMAL(12,4) NOT NULL,
  rating FLOAT(2,1)
);




-- --------- ---- -------------------------------------Feature Engineering---------------------------------------------------------

-- time_of_day---------------------------------------

SELECT 
    time,
    (CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
     END) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
			WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
			WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
			ELSE 'Evening'
		END
);
SET SQL_SAFE_UPDATES = 0;

-- --------- day_names----------------------------------------------------------------------

SELECT
	date,
    Dayname(date)
FROM sales;

ALTER TABLE sales ADD COLUMN day_names VARCHAR(10);
UPDATE sales
SET day_names = (Dayname(date));

-- month_names------------------------------------------------------------

SELECT
	date, 
    MONTHNAME(date) 
FROM sales ;

ALTER TABLE sales ADD COLUMN month_names VARCHAR(10);
UPDATE sales
SET month_names = (MONTHNAME(date));
--  ------------------------------------------------------------------------------------------------

-- ---------------------------------- GENERIC QUESTION -----------------------------------------------
# HOW MANY UNIQUE CITIES DOES THE DATA HAVE?
SELECT DISTINCT city FROM sales ;
# IN WHICH CITY IS EACH BRANCH 
SELECT DISTINCT branch FROM sales ;
SELECT DISTINCT city, branch FROM sales ;
-- ----------------------------------------------------------------------------------------------------

-- ------------------------------ PRODUCT-----------------------------------------------------------------
# HOW MANY UNIQUE PRODUCT LINE DOES THE DATA HAVE
SELECT count(DISTINCT product_line) FROM sales ;
# WHAT IS THE MOST COMMON PAYMENT METHOD
SELECT payment_method,COUNT(payment_method) AS count FROM sales GROUP BY payment_method ORDER BY count DESC;
# WHAT IS THE MOST SELLING PRODUCT LINE
SELECT product_line, COUNT(product_line) AS count FROM sales GROUP BY product_line ORDER BY count DESC ;
# HOW MANY UNIQUE PRODUCT LINE DOES THE DATA HAVE
SELECT COUNT(DISTINCT product_line) FROM sales ;
# WHAT IS THE MOST COMMON PAYMENT METHOD
SELECT payment_method, COUNT(payment_method) as count FROM sales group bY payment_method order by count DESC ;
# WHAT IS THE MOST SELLING PRODUCT NAME
SELECT product_line, COUNT(product_line) as count FROM sales group bY product_line order by count DESC ;
# WHAT IS THE TOTAL REVENUE BY MONTH
SELECT month_names AS month, SUM(total) AS total_revenue FROM sales GROUP BY month_names ORDER BY total_revenue DESC;
# WHAT MONTH HAD THE LARGEST COGS
SELECT month_names AS month, SUM(cogs) AS cogs FROM sales GROUP BY month_names ORDER BY cogs DESC;
# WHAT PRODUCT LINE HAD LARGEST REVENUE
SELECT product_line, SUM(total) AS total_revenue FROM sales GROUP BY product_line ORDER BY total_revenue DESC;
# WHAT IS THE CITY WITH THE LARGEST REVENUE
SELECT branch, city, SUM(total) AS total_revenue FROM sales GROUP BY city,branch ORDER BY total_revenue DESC;
# WHAT PRODUCT LINE HAD THE LARGEST VAT 
SELECT product_line , AVG(VAT) AS avg_tax FROM sales GROUP BY product_line ORDER BY avg_tax DESC;
# WHICH BRANCH SOLD MORE PRODUCT THAN AVERAGE PRODUCT SOLD
SELECT branch, SUM(quantity) AS qty FROM sales GROUP BY branch HAVING SUM(quantity)>(SELECT AVG(quantity) FROM SALES);
# WHAT IS THE MOST COMMON PRODUCT LINE BY GENDER
SELECT gender , product_line, COUNT(gender) as total_cnt FROM sales GROUP BY gender , product_line order by product_line DESC;
# WHAT IS THE AVERAGE RATING OF EACH PRODUCT LINE
SELECT ROUND(AVG(rating),2) AS avg_rating, product_line FROM sales GROUP BY product_line ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------SALES-------------------------------------------------------------------------------
# NUMBER OF SALES MADE IN EACH TIME OF THE DAY PER WEEKDAY
SELECT time_of_day,COUNT(*) AS total_sales FROM sales WHERE day_names = "monday" GROUP BY time_of_day ORDER BY total_sales DESC;
# WHICH OF THE CUSTOMER TYPES BRINGS THE MOST REVENUE
SELECT customer_type, SUM(total) AS total_revenue FROM sales GROUP BY customer_type ORDER BY total_revenue DESC;
# WHICH CITY HAS THE LARGEST TAX PERCENT/ VAT (VALUE ADDED TAX)
SELECT city, AVG(VAT) AS VAT FROM sales GROUP BY city ORDER BY VAT DESC;
# WHICH CUSTOMER TYPE PAYS THE MOST IN VAT
SELECT customer_type, AVG(VAT) AS VAT fROM sales GROUP BY customer_type ORDER BY VAT DESC;
-- --------------------------------------------------------------------------------------------------------------------------
 
 -- ---------------------------------------- CUSTOMERS ---------------------------------------------------------------
 # HOW MANY UNIQUE CUSTOMERS TYPES DOES THE DATA HAVE
 SELECT DISTINCT customer_type fROM sales;
 # HOW MANY UNIQUE PAYMENT METHOD DOES THE DATA HAVE
 SELECT DISTINCT payment_method fROM sales;
 # WHICH CUSTOMER TYPE BUYS THE MOST
 SELECT customer_type,COUNT(*) AS ctmr_cnt FROM sales GROUP BY customer_type;
 # WHAT IS THE GENDER OF MOST OF THE CUSTOMER
 SELECT gender, COUNT(*) AS gender_cnt FROM sales GROUP BY gender ORDER BY gender_cnt;
 # WHAT IS THE GENGER DISTRIBUTION  PER BRANCH
 SELECT gender ,count(*) AS gender_cnt FROM sales WHERE branch = "A" GROUP BY gender ORDER BY gender_cnt;
 # WHAT TIME OF THE DAY DO CUSTOMER GIVE MOST RATING
 SELECT time_of_day,ROUND(AVG (rating),2) AS avg_rating FROM sales GROUP BY time_of_day ORDER BY avg_rating; 
 # WHICH TIME OF THE DAY DO CUSTOMER GIVE MOST RATING PER BRANCH
 SELECT time_of_day,ROUND(AVG (rating),2) AS avg_rating FROM sales WHERE branch = "C" GROUP BY time_of_day ORDER BY avg_rating;  
 # WHICH DAY OF THE WEEK HAS  THE BEST avg rating
 SELECT day_names ,ROUND(AVG (rating),2) AS avg_rating FROM sales GROUP BY day_names ORDER BY avg_rating DESC;
 # WHICH DAY OF THE WEEK HAS THE BEST AVERAGE RATING PER BRANCH
 SELECT day_names ,ROUND(AVG (rating),2) AS avg_rating  FROM sales WHERE branch= "C" GROUP BY day_names ORDER BY avg_rating DESC;