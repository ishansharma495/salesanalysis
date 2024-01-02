# salesanalysis
Walmart sales data report

PROJECT OVERVIEW

This report endeavors to conduct an in-depth analysis of the sales data extracted from three distinct Walmart branches situated within Myanmar (Burma) with the objective of deriving pertinent and informative insights essential for managerial decision-making. The dataset was sourced from Kaggle, a platform renowned for providing free and anonymous open data for analytical purposes. Specifically, the data was obtained from a Walmart recruitment competition in 2014, albeit the competition is presently inactive.
The rationale behind selecting this dataset was its provision of a compact yet practical set of data, necessitating comprehensive data cleansing and querying prior to visualization. The approach to analyzing this dataset comprised two fundamental segments. The initial phase entailed data cleansing and addressing queries related to revenue generation, whereas the subsequent phase focused on customer-related data and evaluations.
The data underwent thorough cleansing and formatting procedures within Microsoft Excel, followed by extensive querying performed through MySQL. Finally, the visualization of the derived insights was executed using Microsoft PowerBI, enabling the creation of comprehensive visual representations for enhanced comprehension and strategic decision-making.

HIGHLIGHTS/ LIMITATIONS

The advantages I encountered while utilizing MySQL were primarily centered around its user-friendly interface, rapid processing capabilities, and enhanced presentation of data. In contrast to Excel, SQL offered a multitude of straightforward yet robust formulas, significantly amplifying the efficiency in obtaining desired outcomes. SQL demonstrated expedited functionality, with concise formulas facilitating prompt generation of results. The seamless interoperability between SQL and PowerBI furthered the efficiency, ensuring swift data transfer, and simplifying the overall process.
Additionally, SQL's code exhibited a higher degree of clarity, enhancing its overall presentation, and enabling quick identification of errors. Notably, the querying process in SQL eliminated the need for manual sifting through extensive datasets, thereby streamlining operations.
However, the limitations encountered primarily stemmed from the inherent characteristics of the dataset itself. Issues such as unconventional column names, diverse date and number formats, and a restricted array of columns posed challenges. Despite these limitations, proactive data cleaning measures and supplementing available information facilitated the mitigation of these issues. Leveraging multiple programs enabled a more exhaustive analysis and circumvented the constraints imposed by the dataset's inherent shortcomings.


QUESTIONS (CODE + VISUAL)

PART 1: CLEANING, FORMATTING, CREATING TABLE.

•	Downloaded the data in CSV format. 
•	Cleaned the data in Excel by adjusting date and number formats.
•	Imported it into MySQL using the import wizard.

•	Created database.
•	Reformatted and categorized in MySQL by creating a table with usable column names and removed null data.

-- Line 1-23

•	Extracted data to create a time of day, day name, and month name column.

- -- Line 31-71

Used the ‘Distinct’ value:

•	Retrieved values such as branch and city location, and unique products sold. 

- -- Line 73-87

PART 2: REVENUE 

Using the ‘SUM’ function I obtained results such as:

•	What is the most selling product line.
•	What is the total revenue by month.
•	What month had the largest cogs.
•	What was the largest revenue by product line and city.   

- --Line 90-131

Using the ‘AVG’ function I identified:

•	The product line with the largest VAT as ‘average tax’. 
•	Average sales rating test to assign a good or bad rating based on ‘average quantity’. 
•	Using ‘SUM’ and ‘AVG’ functions I answered which branch sold more products than the average sold.

- --Line 134-165

PART 3: CUSTOMER DATA AND RATINGS.

Using the ‘COUNT’ function:

•	Most common product was by gender. 

Using the ‘ROUND’ and ‘AVG’ functions:

•	Average rating for each product line. 

- -- Line 168-183

Using the ‘DISTINCT’ function:

•	Identified what the customer types were, and the methods of payments used.

- -- Line 185-193

Using the ‘COUNT’ function:

•	Most common customer type was (member vs non-member)
•	Customer type that buys the most.
•	What is the gender of most customers. 
•	What was the gender distribution per branch.

- -- Line 196-229

Using the ‘AVG’ function:

•	What time customers give the most ratings.
•	What day of the week has the best average ratings.

- -- Line 231-262

Using the ‘COUNT’, ‘SUM’, ‘ROUND’, and ‘’AVG functions:

•	Which day of the week had the best ratings per branch, 
•	The number of sales made at each time of day, 
•	Which customer type brought the most revenue, 
•	Which city had the largest tax percent, 
•	Which customer type pays the most in VAT.

- -- Line 266-309 



CONCLUSION 

This analysis serves as a pivotal tool for management in comprehending the operational status of the three branches under scrutiny. The dataset encapsulates vital revenue and sales metrics essential for gauging performance, complemented by customer-centric data and ratings crucial for presenting consumer behavior and sentiment. These metrics collectively form key performance indicators (KPIs) pivotal for a comprehensive analysis.
Furthermore, this project assumes significant importance by not only furnishing critical insights into branch performance but also serving as an instrumental avenue for gaining practical proficiency in deploying SQL and PowerBI within a realistic operational framework. The seamless integration and compatibility of these tools with other software have been leveraged to orchestrate a more holistic, insightful, and informative analysis, amplifying their utility and applicability in a real-world context.

