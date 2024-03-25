-- 1. Select a particular database
USE zomato;

-- 2. Count number of rows
SELECT COUNT(*) FROM users;

-- 3. return n random records
SELECT * FROM users ORDER BY rand() LIMIT 5;

-- 4. Find null values
SELECT * FROM orders WHERE restaurant_rating IS NULL;


-- 5. Find the number of orders placed by each customer
SELECT t2.user_id,t2.name, COUNT(*) AS '#orders' FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY t2.user_id,t2.name;

-- 6. Find restaurant with most number of menu_items
SELECT r_name, COUNT(*) AS 'menu_items' FROM restaurants t1 
JOIN menu t2
ON t1.r_id = t2.r_id
GROUP BY r_name;

-- 7. Find number of votes and average rating for all the restaurants
SELECT r_name, COUNT(*) AS 'num_votes', 
ROUND(AVG(restaurant_rating),2) AS 'rating' 
FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE restaurant_rating IS NOT NULL
GROUP BY r_name;

-- 8. Find the food that is being sold at most number of restaurants
SELECT f_name, COUNT(*) FROM menu t1
JOIN food t2 
ON t1.f_id = t2.f_id
GROUP by f_name
ORDER BY COUNT(*) DESC LIMIT 1;


-- 9. Find restaurants with maximum revenue in a given month
-- Maximum revenue May month
SELECT r_name, SUM(amount) AS revenue FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTHNAME(DATE(date)) = 'May'
GROUP BY r_name
ORDER BY revenue DESC LIMIT 1;

-- Maximum revenue June month
SELECT r_name, SUM(amount) AS revenue FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTHNAME(DATE(date)) = 'June'
GROUP BY r_name
ORDER BY revenue DESC LIMIT 1;

-- Maximum revenue July month
SELECT r_name, SUM(amount) AS revenue FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE MONTHNAME(DATE(date)) = 'July'
GROUP BY r_name
ORDER BY revenue DESC LIMIT 1;

-- 10. Month by month revnue for particular restaurant kfc
SELECT MONTHNAME(date), SUM(amount) as 'revenue' FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
WHERE r_name = 'kfc'
GROUP BY MONTHNAME(date)
ORDER BY MONTHNAME(date);

-- 11. Find restaurants with sales > 1500
SELECT r_name, SUM(amount) AS 'revenue' FROM orders t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
GROUP BY r_name
HAVING revenue > 1500;

-- 12. Find customers who have never ordered
SELECT user_id, name FROM users 
EXCEPT
SELECT t1.user_id, name FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id;

-- 13. Show order details of 
-- a particular customer in a given date range From 15 May to 15 June.
SELECT t1.order_id, f_name FROM orders t1
JOIN order_details t2
ON t1.order_id = t2.order_id
JOIN food t3
ON t2.f_id = t3.f_id
WHERE user_id = 1 AND date BETWEEN '2022-05-15' AND '2022-06-15';

-- 14. Find most costly restaurants(AVG price/dish)
SELECT r_name, SUM(price)/COUNT(*) AS 'avg_price' FROM menu t1
JOIN restaurants t2
ON t1.r_id = t2.r_id
GROUP BY r_name
ORDER BY avg_price DESC LIMIT 1;

-- 15. Find delivery partner compensation 
-- using the formula(#deliveries*100+1000*avg_rating)
SELECT t1.partner_id,t2.partner_name, 
(COUNT(*) *100 + AVG(delivery_rating)*1000) As 'salary'
FROM orders t1
JOIN delivery_partner t2
ON t1.partner_id = t2.partner_id
GROUP BY t1.partner_id,t2.partner_name;

-- 16. Find all veg restaurants
SELECT r_name FROM menu t1
JOIN food t2
ON t1.f_id = t2.f_id
JOIN restaurants t3
ON t1.r_id = t3.r_id
GROUP BY r_name
HAVING MIN(type) = 'Veg' AND MAX(type) = 'Veg';

-- 17. Find min and max order value for all the customers
SELECT name,MIN(amount),MAX(amount),
AVG(amount) FROM orders t1
JOIN users t2
ON t1.user_id = t2.user_id
GROUP BY name;



