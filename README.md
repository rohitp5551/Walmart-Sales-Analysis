Walmart Sales Data Analysis
Introduction
This repository contains SQL code for analyzing Walmart sales data. The data is stored in a MySQL database named salesDataWalmart, and the SQL queries provided here perform various analyses and feature engineering on the dataset.
Database Structure
The database consists of a single table named sales with the following columns:

invoice_id: Unique identifier for each sale (Primary Key)
branch: Walmart branch code
city: City where the sale occurred
customer_type: Type of customer (e.g., Member, Normal)
gender: Gender of the customer
product_line: Type of product sold
unit_price: Unit price of the product
quantity: Quantity of products sold
VAT: Value Added Tax
total: Total amount of the sale
date: Date of the sale
time: Time of the sale
payment_method: Payment method used
cogs: Cost of goods sold
gross_margin_pct: Gross margin percentage
gross_income: Gross income from the sale
rating: Customer rating
.[WalmartSalesData.csv.csv](https://github.com/rohitp5551/Walmart-Sales-Analysis/files/13731395/WalmartSalesData.csv.csv)

Feature Engineering
Time of Day
The time of day is categorized as "Morning," "Afternoon," or "Evening" based on the sale's time.

Day and Month Names
Day names and month names are extracted from the date column.

Generic Questions
Unique Cities: How many unique cities does the data have?
Branch and City Mapping: In which city is each branch located?
Product Analysis
Unique Product Lines: How many unique product lines does the data have?
Most Common Payment Method: What is the most common payment method?
Best Selling Product Line: Which product line is the most popular?
Revenue Analysis: Various queries to analyze revenue, including total revenue by month and city.
Sales Analysis
Sales by Time of Day: Number of sales made in each time of the day per weekday.
Top Customer Type: Which customer type brings the most revenue?
City VAT Analysis: Which city has the largest VAT?
Customer Type VAT Analysis: Which customer type pays the most in VAT?
Customer Analysis
Unique Customer Types: How many unique customer types does the data have?
Gender Distribution: What is the gender distribution of customers?
Customer Buying Habits: Which customer type buys the most?
Rating Analysis: Analysis of customer ratings, including the best time of day for high ratings
For the code, check the  file
