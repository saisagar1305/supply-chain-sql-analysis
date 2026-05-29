create database supply_chain;
use supply_chain;
select * from supply_chain;

-- PHASE 1 — DATA UNDERSTANDING
-- Step 1 — Count Total Rows
 select count(*) as total_rows
 from supply_chain;
 
 -- Step 2 — View Dataset
 select * from  supply_chain
 limit 20;

-- Step 3 — Understand Numeric Columns
SELECT 
MIN(price) AS min_price,
MAX(price) AS max_price,
AVG(price) AS avg_price
FROM supply_chain;

-- PHASE 2 — DATA CLEANING
-- 1. Check NULL Values
SELECT *
FROM supply_chain
WHERE `Product type` IS NULL;
 SELECT *
FROM supply_chain
WHERE SKU IS NULL;

SELECT *
FROM supply_chain
WHERE `Revenue generated` IS NULL;

-- 2. Check Duplicate Products
SELECT SKU,
       COUNT(*) AS duplicate_count
FROM supply_chain
GROUP BY SKU
HAVING COUNT(*) > 1;

-- 3. Check Distinct Product Types
SELECT DISTINCT `Product type`
FROM supply_chain;

-- 4. Check Invalid Prices
SELECT *
FROM supply_chain
WHERE Price <= 0;

-- 5. Check Negative Revenue
SELECT *
FROM supply_chain
WHERE `Revenue generated` < 0;

-- 6. Check Outliers in Defect Rates
SELECT *
FROM supply_chain
WHERE `Defect rates` > 10;

-- PHASE 3 — EXPLORATORY DATA ANALYSIS (EDA)
-- SECTION A — REVENUE ANALYSIS
-- Q1 Total Revenue
SELECT ROUND(SUM(`Revenue generated`),2) AS total_revenue
FROM supply_chain;
-- Q2 Revenue by Product Type
SELECT `Product type`,
       ROUND(SUM(`Revenue generated`),2) AS revenue
FROM supply_chain
GROUP BY `Product type`
ORDER BY revenue DESC;

-- Q3 Top 10 Revenue Products
SELECT SKU,
       ROUND(SUM(`Revenue generated`),2) AS revenue
FROM supply_chain
GROUP BY SKU
ORDER BY revenue DESC
LIMIT 10;
-- Q4 Average Revenue Per Product
SELECT ROUND(AVG(`Revenue generated`),2) AS avg_revenue
FROM supply_chain;
-- SECTION B — SALES ANALYSIS
-- Q5 Most Sold Products
SELECT SKU,
       SUM(`Number of products sold`) AS units_sold
FROM supply_chain
GROUP BY SKU
ORDER BY units_sold DESC
LIMIT 10;
-- Q6 Product Type Sales
SELECT `Product type`,
       SUM(`Number of products sold`) AS total_sales
FROM supply_chain
GROUP BY `Product type`
ORDER BY total_sales DESC;
-- Q7 High Revenue but Low Sales
SELECT SKU,
       `Revenue generated`,
       `Number of products sold`
FROM supply_chain
ORDER BY `Revenue generated` DESC,
         `Number of products sold` ASC;
         
-- SECTION C — INVENTORY ANALYSIS
-- Q8 Low Stock Products
SELECT SKU,
       `stock levels`
FROM supply_chain
ORDER BY `stock levels` ASC
LIMIT 10;
-- Q9 Overstocked Products
SELECT SKU,
       `stock levels`
FROM supply_chain
ORDER BY `stock levels` DESC
LIMIT 10;
-- Q10 Inventory Risk Analysis
SELECT SKU,
       `stock levels`,
       `Number of products sold`
FROM supply_chain
ORDER BY `stock levels` DESC,
         `Number of products sold` ASC;
-- SECTION D — SHIPPING ANALYSIS
-- Q11 Average Shipping Cost
SELECT ROUND(AVG(`Shipping costs`),2) AS avg_shipping_cost
FROM supply_chain;
-- Q12 Shipping Cost by Carrier
SELECT `Shipping carriers`,
       ROUND(AVG(`Shipping costs`),2) AS avg_shipping_cost
FROM supply_chain
GROUP BY `Shipping carriers`
ORDER BY avg_shipping_cost DESC;
-- Q13 Shipping Time by Transport Mode
SELECT `transportation modes`,
       ROUND(AVG(`Shipping times`),2) AS avg_shipping_time
FROM supply_chain
GROUP BY `transportation modes`;
-- Q14 Most Efficient Transport Mode
SELECT `transportation modes`,
       ROUND(AVG(costs),2) AS avg_transport_cost,
       ROUND(AVG(`Shipping times`),2) AS avg_shipping_time
FROM supply_chain
GROUP BY `transportation modes`;

-- SECTION E — SUPPLIER ANALYSIS
-- Q15 Revenue by Supplier
SELECT `Supplier name`,
       ROUND(SUM(`Revenue generated`),2) AS revenue
FROM supply_chain
GROUP BY `Supplier name`
ORDER BY revenue DESC;
-- Q16 Supplier Defect Rate
SELECT `Supplier name`,
       ROUND(AVG(`Defect rates`),2) AS avg_defect_rate
FROM supply_chain
GROUP BY `Supplier name`
ORDER BY avg_defect_rate DESC;
-- Q17 Supplier Lead Time
SELECT `Supplier name`,
       ROUND(AVG(`Lead time`),2) AS avg_lead_time
FROM supply_chain
GROUP BY `Supplier name`
ORDER BY avg_lead_time DESC;

-- SECTION F — MANUFACTURING ANALYSIS
-- Q18 Manufacturing Cost by Product Type
SELECT `Product type`,
       ROUND(AVG(`Manufacturing costs`),2) AS avg_manufacturing_cost
FROM supply_chain
GROUP BY `Product type`;
-- Q19 Production Volume Analysis
SELECT SKU,
       `Production volumes`
FROM supply_chain
ORDER BY `Production volumes` DESC
LIMIT 10;
-- Q20 Highest Manufacturing Cost Products
SELECT SKU,
       `Manufacturing costs`
FROM supply_chain
ORDER BY `Manufacturing costs` DESC
LIMIT 10;

-- PHASE 4 — ADVANCED SQL ANALYSIS
-- Q21 Revenue Ranking
SELECT SKU,
       `Revenue generated`,
       RANK() OVER(
           ORDER BY `Revenue generated` DESC
       ) AS revenue_rank
FROM supply_chain;
-- Q22 Dense Rank Suppliers
SELECT `Supplier name`,
       SUM(`Revenue generated`) AS total_revenue,
       DENSE_RANK() OVER(
           ORDER BY SUM(`Revenue generated`) DESC
       ) AS supplier_rank
FROM supply_chain
GROUP BY `Supplier name`;
-- Q23 Running Revenue Total
SELECT SKU,
       `Revenue generated`,
       SUM(`Revenue generated`)
       OVER(ORDER BY `Revenue generated`) AS running_total
FROM supply_chain;
-- Q24 Above Average Revenue Products
WITH avg_revenue AS (
    SELECT AVG(`Revenue generated`) AS avg_rev
    FROM supply_chain
)
SELECT SKU,
       `Revenue generated`
FROM supply_chain, avg_revenue
WHERE `Revenue generated` > avg_rev;
-- Q25 Best Product Category
WITH category_revenue AS (
    SELECT `Product type`,
           SUM(`Revenue generated`) AS total_revenue
    FROM supply_chain
    GROUP BY `Product type`
)
SELECT *
FROM category_revenue
ORDER BY total_revenue DESC;