USE restaurant_db;

--- 'EXPLORING THE MENU TABLE' ----

SELECT * 
FROM menu_items;

----- NUMBER OF ITMES IN THE MENU ----
SELECT 
	COUNT(item_name) AS number_of_items
FROM menu_items;


------ MOST EXPENSIVE AND LEAST EXPENSIVE ITEMS IN THE MENU ------
SELECT 
	item_name,
    price
FROM menu_items
ORDER BY 
	price DESC;
    
    
----- Italian dishes are on the menu -----
SELECT 
	item_name,
    category,
    price
FROM menu_items
WHERE 
	category = 'Italian'
ORDER BY 
	price DESC;
    
    
----- DISHES IN EACH CATEGORY ----
SELECT 
	category,
    AVG(price) AS average_price
FROM menu_items
GROUP BY 
	category;
    
    
    
----- 'EXPLORING THE ORDER TABLE' -----


SELECT * 
FROM order_details;


------ ORDERS PER DAY ----- 
SELECT 
	order_date,
    COUNT(order_id) AS number_of_orders
FROM order_details
GROUP BY 
	order_date;

    
---- WHICH ORDERS HAVE MORE ITEMS -----
SELECT 
	order_id,
	COUNT(item_id) AS number_of_items
FROM order_details
GROUP BY 
	order_id;
    

------ ORDERS HAVE MORE THAN 12 ITEMS ------
SELECT 
	order_id,
	COUNT(item_id) AS number_of_items
FROM order_details
GROUP BY 
	order_id
HAVING 
	COUNT(item_id) > 12;



-------- 'ANALYZING CUSTOMER BEHAVIOR' -------


---- JOINING THE TWO TABLES ----
SELECT * 
FROM restaurant_db.order_details AS od  
	LEFT JOIN restaurant_db.menu_items AS mi 
	ON od.item_id = mi.menu_item_id;


----- LEAST AND MOST ORDERED ITEMS AND SPECIFYING THEIR CATEGORIES
SELECT 
	mi.item_name,
	mi.category,
	COUNT(od.order_id) AS number_of_orders
FROM restaurant_db.order_details AS od 
	LEFT JOIN restaurant_db.menu_items AS mi 
	ON od.item_id = mi.menu_item_id
GROUP BY 
	mi.item_name,
	mi.category
ORDER BY 
	COUNT(od.order_id) DESC;


----- TOP 5 ORDERS THAT SPENT THE MOST MONEY ------
SELECT 
	od.order_id,
	SUM(mi.price) AS total_order_price
FROM restaurant_db.order_details AS od  
	LEFT JOIN restaurant_db.menu_items AS mi 
	ON od.item_id = mi.menu_item_id
GROUP BY 
	od.order_id
ORDER BY 
	SUM(mi.price) DESC
LIMIT 5;


------- DETAILS OF THE HIGHEST SPENT ORDER -------
SELECT 
	od.order_id,
	mi.item_name,
	mi.price
FROM restaurant_db.order_details AS od  
	LEFT JOIN restaurant_db.menu_items AS mi 
	ON od.item_id = mi.menu_item_id
WHERE 
	od.order_id = 440
ORDER BY
	mi.price DESC;


---- DETAILS OF THE 5 HIGHEST SPENT ORDERS -------
SELECT 
	od.order_id,
	mi.item_name,
	mi.price
FROM restaurant_db.order_details AS od  
	LEFT JOIN restaurant_db.menu_items AS mi 
	ON od.item_id = mi.menu_item_id
WHERE 
	od.order_id IN (440, 2075, 1957, 330, 2675)
ORDER BY
	od.order_id DESC;
