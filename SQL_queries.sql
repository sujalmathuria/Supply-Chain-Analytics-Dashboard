CREATE TABLE supply_chain (
    product_type VARCHAR(100),
    sku VARCHAR(50),
    price NUMERIC(10,2),
    availability INT,
    number_of_products_sold INT,
    revenue_generated NUMERIC(12,2),
    customer_demographics VARCHAR(50),
    stock_levels INT,
    lead_times INT,
    order_quantities INT,
    shipping_times INT,
    shipping_carriers VARCHAR(100),
    shipping_costs NUMERIC(10,2),
    supplier_name VARCHAR(150),
    location VARCHAR(100),
    lead_time INT,
    production_volumes INT,
    manufacturing_lead_time INT,
    manufacturing_costs NUMERIC(12,2),
    inspection_results VARCHAR(50),
    defect_rates NUMERIC(5,2),
    transportation_modes VARCHAR(50),
    routes VARCHAR(100),
    costs NUMERIC(12,2)
);

SELECT * FROM supply_chain;

SELECT COUNT(*) AS total_records
FROM supply_chain;

SELECT COUNT(DISTINCT product_type) AS total_products
FROM supply_chain;

SELECT COUNT(DISTINCT supplier_name) AS total_suppliers
FROM supply_chain;

SELECT ROUND(SUM(revenue_generated),2) AS total_revenue
FROM supply_chain;

SELECT
product_type,
ROUND(SUM(revenue_generated),2) AS revenue
FROM supply_chain
GROUP BY product_type
ORDER BY revenue DESC;

SELECT
supplier_name,
ROUND(SUM(revenue_generated),2) AS revenue
FROM supply_chain
GROUP BY supplier_name
ORDER BY revenue DESC;

SELECT
shipping_carriers,
ROUND(AVG(shipping_costs),2) AS avg_shipping_cost
FROM supply_chain
GROUP BY shipping_carriers
ORDER BY avg_shipping_cost DESC;

SELECT
transportation_modes,
COUNT(*) AS total_orders
FROM supply_chain
GROUP BY transportation_modes
ORDER BY total_orders DESC;

SELECT
supplier_name,
ROUND(AVG(lead_times),2) AS avg_lead_time
FROM supply_chain
GROUP BY supplier_name
ORDER BY avg_lead_time DESC;

SELECT product_type,
SUM(revenue_generated) AS revenue
FROM supply_chain
GROUP BY product_type;
2. Filtering
SELECT *
FROM supply_chain
WHERE defect_rates > 2;
3. CASE WHEN
SELECT product_type,
CASE
    WHEN defect_rates > 2 THEN 'High Defect'
    ELSE 'Low Defect'
END AS defect_category
FROM supply_chain;
4. CTE
WITH supplier_revenue AS (
    SELECT supplier_name,
           SUM(revenue_generated) AS revenue
    FROM supply_chain
    GROUP BY supplier_name
)
SELECT *
FROM supplier_revenue
ORDER BY revenue DESC;
5. Window Function ⭐
SELECT
supplier_name,
SUM(revenue_generated) AS revenue,
RANK() OVER (
ORDER BY SUM(revenue_generated) DESC
) AS supplier_rank
FROM supply_chain
GROUP BY supplier_name;
6. Top 5 Suppliers
SELECT supplier_name,
SUM(revenue_generated) revenue
FROM supply_chain
GROUP BY supplier_name
ORDER BY revenue DESC
LIMIT 5;
7. Transportation Cost Analysis
SELECT transportation_modes,
ROUND(AVG(costs),2)
FROM supply_chain
GROUP BY transportation_modes;
8. Inspection Result Analysis
SELECT inspection_results,
COUNT(*)
FROM supply_chain
GROUP BY inspection_results;
9. Revenue Contribution %
SELECT
product_type,
ROUND(
100.0 * SUM(revenue_generated) /
SUM(SUM(revenue_generated)) OVER(),
2
) AS revenue_pct
FROM supply_chain
GROUP BY product_type;
##Supplier Performance Score
SELECT
supplier_name,
ROUND(AVG(defect_rates),2) defect_rate,
ROUND(AVG(lead_times),2) lead_time
FROM supply_chain
GROUP BY supplier_name;

SELECT COUNT(*)
FROM supply_chain
WHERE supplier_name IS NULL;

SELECT COUNT(*)
FROM supply_chain
WHERE product_type IS NULL;

SELECT COUNT(*)
FROM supply_chain
WHERE revenue_generated IS NULL;

SELECT sku,
COUNT(*)
FROM supply_chain
GROUP BY sku
HAVING COUNT(*) > 1;

SELECT *
FROM supply_chain
WHERE revenue_generated < 0
OR shipping_costs < 0
OR costs < 0;

SELECT *
FROM supply_chain
WHERE TRIM(supplier_name) = '';

SELECT COUNT(*)
FROM supply_chain;
SELECT supplier_name,
SUM(revenue_generated) revenue,
RANK() OVER(
ORDER BY SUM(revenue_generated) DESC
) supplier_rank
FROM supply_chain  
GROUP BY supplier_name;


SELECT supplier_name,
SUM(revenue_generated) revenue,
RANK() OVER(
ORDER BY SUM(revenue_generated) DESC
) supplier_rank
FROM supply_chain
GROUP BY supplier_name;

WITH revenue_cte AS (
SELECT product_type,
SUM(revenue_generated) revenue
FROM supply_chain
GROUP BY product_type
)
SELECT *
FROM revenue_cte
ORDER BY revenue DESC;










