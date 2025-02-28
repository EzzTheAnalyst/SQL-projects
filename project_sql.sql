/*1. Select customer together with the products that he bought*/
SELECT c.customername, o.orderid, p.productname FROM Customers as c
INNER JOIN Orders as o ON c.customerid = o.customerid
INNER JOIN Order_details as od ON o.orderid = od.orderid
INNER JOIN Products as p ON p.productid = od.productid;


/*2. Select orders together with the name of the shipping company*/
SELECT * FROM Orders as o
INNER JOIN shippers as s ON o.shipperid = s.shipperid;

/*3. Select customers with id greater than 50 together with each order they made*/
SELECT * FROM Customers as c
INNER JOIN Orders as o ON c.customerid = o.customerid
WHERE c.customerid > 50;

SELECT * FROM (SELECT * FROM Customers
WHERE customerid > 50) as t1
INNER JOIN orders as o ON t1.customerid = o.customerid;


/*4. Select employees together with orders with order id greater than 10400*/
SELECT * FROM orders as o
INNER JOIN employees as e ON o.employeeid = e.EmployeeID
WHERE o.orderid > 10400;

/*5. Select the most expensive product*/
SELECT * FROM Products
ORDER BY price desc
LIMIT 1;

/*6. Select the second most expensive product*/
SELECT * FROM Products
ORDER BY price desc
LIMIT 1 OFFSET 1;

/*7. Select 5 most expensive products*/
SELECT * FROM Products
ORDER BY price desc
LIMIT 5;

/*8. Select 5 most expensive products without the most expensive (in final 4 products)*/
SELECT * FROM Products
ORDER BY price desc
LIMIT 4 OFFSET 1;

/*9. Select name of the cheapest product (only name) without using LIMIT and OFFSET*/
CREATE VIEW vr_table AS(
SELECT min(price) as min_price FROM Products);

SELECT * FROM Products, vr_table
WHERE price = vr_table.min_price;


/*10. Select name of the cheapest product (only name) using subquery*/
SELECT * FROM Products
WHERE price = (
SELECT min(price) FROM Products
);

/*11. Select number of employees with LastName that starts with 'D'*/
SELECT COUNT(*) as emp_end_w_D FROM employees
WHERE LastName LIKE "D%";

/*12. Select customer name together with the number of orders made by the corresponding customer 
sort the result by number of orders in decreasing order*/
SELECT c.customername, COUNT(*) as num_of_orders FROM Customers as c
INNER JOIN Orders as o ON c.customerid = o.customerid
GROUP BY c.customername
ORDER BY num_of_orders DESC;

/*13. Add up the price of all products*/
SELECT SUM(price) FROM Products;

/*14. Select orderID together with the total price of  that Order, order the result by total price of order in increasing order*/
CREATE VIEW orders_total_price2 AS(
SELECT o.orderid, SUM(od.quantity * p.price) as total_price, o.customerid FROM Orders as o
INNER JOIN order_details as od ON o.orderid = od.orderid
INNER JOIN products as p ON od.productid = p.productid
GROUP BY o.orderid
ORDER BY total_price ASC);

/*15. Select customer who spend the most money*/
SELECT c.customername, SUM(otp.total_price) as total_spends FROM Customers as c
INNER JOIN orders_total_price2 as otp ON c.customerid = otp.customerid
GROUP BY c.customername
ORDER BY total_spends DESC;

/*16. Select customer who spend the most money and lives in Canada*/
SELECT c.customername, SUM(otp.total_price) as total_spends FROM Customers as c
INNER JOIN orders_total_price2 as otp ON c.customerid = otp.customerid
WHERE c.country = 'Canada'
GROUP BY c.customername
ORDER BY total_spends DESC;

/*17. Select customer who spend the second most money*/
SELECT c.customername, SUM(otp.total_price) as total_spends FROM Customers as c
INNER JOIN orders_total_price2 as otp ON c.customerid = otp.customerid
WHERE c.country = 'Canada'
GROUP BY c.customername
ORDER BY total_spends DESC
LIMIT 1 OFFSET 1;

/*15. Select shipper together with the total price of proceed orders*/

