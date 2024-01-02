-- Creating the database
CREATE DATABASE IF NOT EXISTS walmart_sales;

-- Creating & reformatting table
CREATE TABLE IF NOT EXISTS walmartsalesdata(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Ensure data is correct 
SELECT
	*
FROM walmartsalesdata;


-- Adding the time_of_day column to the table
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM walmartsalesdata;
ALTER TABLE walmartsalesdata ADD COLUMN time_of_day VARCHAR(20);

UPDATE walmartsalesdata
SET time_of_day = ( CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Adding the day_name column to the table
SELECT
	date,
	DAYNAME(date)
FROM walmartsalesdata;

ALTER TABLE walmartsalesdata ADD COLUMN day_name VARCHAR(10);

UPDATE walmartsalesdata
SET day_name = DAYNAME(date);


-- Adding the month_name column to the table
SELECT
	date,
	MONTHNAME(date)
FROM walmartsalesdata;

ALTER TABLE walmartsalesdata ADD COLUMN month_name VARCHAR(10);

UPDATE walmartsalesdata
SET month_name = MONTHNAME(date);

-- How many distinct cities are included in the dataset?
SELECT 
	DISTINCT city
FROM walmartsalesdata;

-- What city is each branch located in?
SELECT 
	DISTINCT city,
    branch
FROM walmartsalesdata;

-- How many distinct product lines are represented in the dataset?
SELECT
	DISTINCT product_line
FROM walmartsalesdata;


-- Which product line has the highest sales volume?
SELECT
	SUM(quantity) as qty,
    product_line
FROM walmartsalesdata
GROUP BY product_line
ORDER BY qty DESC;

-- What is the monthly total revenue?
SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM walmartsalesdata
GROUP BY month_name 
ORDER BY total_revenue;


-- Which month recorded the highest Cost of Goods Sold (COGS)?
SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM walmartsalesdata
GROUP BY month_name 
ORDER BY cogs;


-- Which product line generated the highest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM walmartsalesdata
GROUP BY product_line
ORDER BY total_revenue DESC;

-- Which city achieved the highest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM walmartsalesdata
GROUP BY city, branch 
ORDER BY total_revenue;


-- Which product line incurred the highest Value Added Tax (VAT)?
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM walmartsalesdata
GROUP BY product_line
ORDER BY avg_tax DESC;

 
-- line showing "Good", "Bad". Good if its greater than average sales

SELECT 
	AVG(quantity) AS avg_qnty
FROM walmartsalesdata;

SELECT
	product_line,
	CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM walmartsalesdata
GROUP BY product_line;


-- Which branch had sales that exceeded the average number of products sold across all branches?
SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM walmartsalesdata
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmartsalesdata);


-- What product line is most frequently purchased by each gender?
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM walmartsalesdata
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the mean rating for each product line?
SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM walmartsalesdata
GROUP BY product_line
ORDER BY avg_rating DESC;

-- How many distinct types of customers are represented in the data?
SELECT
	DISTINCT customer_type
FROM walmartsalesdata;

-- How many distinct payment methods are included in the dataset?
SELECT
	DISTINCT payment
FROM walmartsalesdata;


-- Which customer type occurs most frequently in the data?
SELECT
	customer_type,
	count(*) as count
FROM walmartsalesdata
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type has the highest purchasing volume?
SELECT
	customer_type,
    COUNT(*)
FROM walmartsalesdata
GROUP BY customer_type;


-- What is the predominant gender among the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesdata
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the breakdown of gender distribution for each branch?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesdata
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;
-- Gender per branch is more or less the same

-- During which part of the day do customers tend to provide the most ratings?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Looks like time of the day does not really affect the rating


-- At what time of the day do customers tend to provide the most ratings for each individual branch?
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;
-- Branch A and C are doing better in ratings

-- Which day of the week displays the highest average ratings?
SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
GROUP BY day_name 
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings


-- Which specific day of the week, per branch, exhibits the highest average ratings?
SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM walmartsalesdata
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;


-- Number of sales made in each time of the day per weekday?
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM walmartsalesdata
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;
-- Evenings experience thee most sales

-- Which customer type contributes the highest revenue?
SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM walmartsalesdata
GROUP BY customer_type
ORDER BY total_revenue;

-- Which city exhibits the highest tax/VAT percentage?
SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM walmartsalesdata
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type contributes the most in terms of Value Added Tax (VAT) payments?
SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM walmartsalesdata
GROUP BY customer_type
ORDER BY total_tax;