# WALMART SALES DATA REPORT

**PROJECT OVERVIEW**

This report endeavors to conduct an in-depth analysis of the sales data extracted from three distinct Walmart branches situated within Myanmar (Burma) with the objective of deriving pertinent and informative insights essential for managerial decision-making. The dataset was sourced from Kaggle, a platform renowned for providing free and anonymous open data for analytical purposes. Specifically, the data was obtained from a Walmart recruitment competition in 2014, albeit the competition is presently inactive.
The rationale behind selecting this dataset was its provision of a compact yet practical set of data, necessitating comprehensive data cleansing and querying prior to visualization. The approach to analyzing this dataset comprised two fundamental segments. The initial phase entailed data cleansing and addressing queries related to revenue generation, whereas the subsequent phase focused on customer-related data and evaluations.
The data underwent thorough cleansing and formatting procedures within Microsoft Excel, followed by extensive querying performed through MySQL. Finally, the visualization of the derived insights was executed using Microsoft PowerBI, enabling the creation of comprehensive visual representations for enhanced comprehension and strategic decision-making.

**HIGHLIGHTS/ LIMITATIONS**

The advantages I encountered while utilizing MySQL were primarily centered around its user-friendly interface, rapid processing capabilities, and enhanced presentation of data. In contrast to Excel, SQL offered a multitude of straightforward yet robust formulas, significantly amplifying the efficiency in obtaining desired outcomes. SQL demonstrated expedited functionality, with concise formulas facilitating prompt generation of results. The seamless interoperability between SQL and PowerBI furthered the efficiency, ensuring swift data transfer, and simplifying the overall process.
Additionally, SQL's code exhibited a higher degree of clarity, enhancing its overall presentation, and enabling quick identification of errors. Notably, the querying process in SQL eliminated the need for manual sifting through extensive datasets, thereby streamlining operations.
However, the limitations encountered primarily stemmed from the inherent characteristics of the dataset itself. Issues such as unconventional column names, diverse date and number formats, and a restricted array of columns posed challenges. Despite these limitations, proactive data cleaning measures and supplementing available information facilitated the mitigation of these issues. Leveraging multiple programs enabled a more exhaustive analysis and circumvented the constraints imposed by the dataset's inherent shortcomings.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
**ANALYSIS (CODE + VISUAL)**

**PART 1: CLEANING, FORMATTING, CREATING TABLE**

•	Downloaded the data in CSV format

•	Cleaned the data in Excel by adjusting date and number formats

•	Imported it into MySQL using the import wizard

•	Created database

•	Reformatted and categorized in MySQL by creating a table with usable column names and removed null data


<summary>
<details>

```ruby
CREATE DATABASE IF NOT EXISTS walmart_sales;

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
```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

•	Extracted data to create a time of day, day name, and month name column
<summary>
<details>
	
```ruby
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

SELECT
	date,
	DAYNAME(date)
FROM walmartsalesdata;

ALTER TABLE walmartsalesdata ADD COLUMN day_name VARCHAR(10);

UPDATE walmartsalesdata
SET day_name = DAYNAME(date);

SELECT
	date,
	MONTHNAME(date)
FROM walmartsalesdata;

ALTER TABLE walmartsalesdata ADD COLUMN month_name VARCHAR(10);

UPDATE walmartsalesdata
SET month_name = MONTHNAME(date);

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Used the ‘Distinct’ value:

•	Retrieved values such as branch and city location, and unique products sold 
<summary>
<details>
	
```ruby
SELECT 
	DISTINCT city
FROM walmartsalesdata;

SELECT 
	DISTINCT city,
    branch
FROM walmartsalesdata;

SELECT
	DISTINCT product_line
FROM walmartsalesdata;

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**PART 2: REVENUE**

Using the ‘SUM’ function I obtained results such as:

•	What is the most selling product line

•	What is the total revenue by month

•	What month had the largest cogs

•	What was the largest revenue by product line and city  

<summary>
<details>

```ruby
SELECT
	SUM(quantity) as qty,
    product_line
FROM walmartsalesdata
GROUP BY product_line
ORDER BY qty DESC;

SELECT
	month_name AS month,
	SUM(total) AS total_revenue
FROM walmartsalesdata
GROUP BY month_name 
ORDER BY total_revenue;


SELECT
	month_name AS month,
	SUM(cogs) AS cogs
FROM walmartsalesdata
GROUP BY month_name 
ORDER BY cogs;


SELECT
	product_line,
	SUM(total) as total_revenue
FROM walmartsalesdata
GROUP BY product_line
ORDER BY total_revenue DESC;

SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM walmartsalesdata
GROUP BY city, branch 
ORDER BY total_revenue;

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Using the ‘AVG’ function I identified:

•	The product line with the largest VAT as ‘average tax’ 

•	Average sales rating test to assign a good or bad rating based on ‘average quantity’ 

•	Using ‘SUM’ and ‘AVG’ functions I answered which branch sold more products than the average sold

<summary>
<details>

```ruby
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM walmartsalesdata
GROUP BY product_line
ORDER BY avg_tax DESC;

 
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


SELECT 
	branch, 
    SUM(quantity) AS qnty
FROM walmartsalesdata
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmartsalesdata);

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**PART 3: CUSTOMER DATA AND RATINGS**

Using the ‘COUNT’ function:

•	Most common product was by gender 

Using the ‘ROUND’ and ‘AVG’ functions:

•	Average rating for each product line 

<summary>
<details>

```ruby
SELECT
	gender,
    product_line,
    COUNT(gender) AS total_cnt
FROM walmartsalesdata
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

SELECT
	ROUND(AVG(rating), 2) as avg_rating,
    product_line
FROM walmartsalesdata
GROUP BY product_line
ORDER BY avg_rating DESC;

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Using the ‘DISTINCT’ function:

•	Identified what the customer types were, and the methods of payments used

<summary>
<details>

```ruby
SELECT
	DISTINCT customer_type
FROM walmartsalesdata;

SELECT
	DISTINCT payment
FROM walmartsalesdata;

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Using the ‘COUNT’ function:

•	Most common customer type was (member vs non-member)

•	Customer type that buys the most

•	What is the gender of most customers

•	What was the gender distribution per branch

<summary>
<details>

```ruby
SELECT
	customer_type,
	count(*) as count
FROM walmartsalesdata
GROUP BY customer_type
ORDER BY count DESC;

SELECT
	customer_type,
    COUNT(*)
FROM walmartsalesdata
GROUP BY customer_type;


SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesdata
GROUP BY gender
ORDER BY gender_cnt DESC;

SELECT
	gender,
	COUNT(*) as gender_cnt
FROM walmartsalesdata
WHERE branch = "C"
GROUP BY gender
ORDER BY gender_cnt DESC;

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Using the ‘AVG’ function:

•	What time customers give the most ratings

•	What day of the week has the best average ratings

<summary>
<details>

```ruby
SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
GROUP BY time_of_day
ORDER BY avg_rating DESC;


SELECT
	time_of_day,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

SELECT
	day_name,
	AVG(rating) AS avg_rating
FROM walmartsalesdata
GROUP BY day_name 
ORDER BY avg_rating DESC;


SELECT 
	day_name,
	COUNT(day_name) total_sales
FROM walmartsalesdata
WHERE branch = "C"
GROUP BY day_name
ORDER BY total_sales DESC;

```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Using the ‘COUNT’, ‘SUM’, ‘ROUND’, and ‘’AVG functions:

•	Which day of the week had the best ratings per branch 

•	The number of sales made at each time of day 

•	Which customer type brought the most revenue 

•	Which city had the largest tax percent 

•	Which customer type pays the most in VAT

<summary>
<details>

```ruby
SELECT
	time_of_day,
	COUNT(*) AS total_sales
FROM walmartsalesdata
WHERE day_name = "Sunday"
GROUP BY time_of_day 
ORDER BY total_sales DESC;

SELECT
	customer_type,
	SUM(total) AS total_revenue
FROM walmartsalesdata
GROUP BY customer_type
ORDER BY total_revenue;

SELECT
	city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM walmartsalesdata
GROUP BY city 
ORDER BY avg_tax_pct DESC;

SELECT
	customer_type,
	AVG(tax_pct) AS total_tax
FROM walmartsalesdata
GROUP BY customer_type
ORDER BY total_tax;
```
</summary>
</details>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CONCLUSION 

This analysis serves as a pivotal tool for management in comprehending the operational status of the three branches under scrutiny. The dataset encapsulates vital revenue and sales metrics essential for gauging performance, complemented by customer-centric data and ratings crucial for presenting consumer behavior and sentiment. These metrics collectively form key performance indicators (KPIs) pivotal for a comprehensive analysis.
Furthermore, this project assumes significant importance by not only furnishing critical insights into branch performance but also serving as an instrumental avenue for gaining practical proficiency in deploying SQL and PowerBI within a realistic operational framework. The seamless integration and compatibility of these tools with other software have been leveraged to orchestrate a more holistic, insightful, and informative analysis, amplifying their utility and applicability in a real-world context.
