-- 1
SELECT DISTINCT prod_id
FROM OrderItems;

SELECT cust_id
FROM Customers;

--SELECT *
SELECT cust_id
FROM Customers;

--2
SELECT cust_name
FROM Customers
ORDER BY cust_name DESC;

SELECT cust_id,order_num
FROM Orders
ORDER BY cust_id,order_num DESC;

SELECT order_num,item_price
FROM OrderItems
ORDER BY 1 DESC,2 DESC;

--3
SELECT prod_id,prod_name
FROM Products
WHERE prod_price = 9.49;

SELECT prod_id,prod_name
FROM Products
WHERE prod_price >= 9;

SELECT order_num
FROM OrderItems
WHERE quantity >= 100;

SELECT prod_name,prod_price
FROM Products
WHERE prod_price BETWEEN 3 AND 6;

--4
SELECT vend_name
FROM Vendors
WHERE vend_country = "USA" AND vend_state ='CA';

SELECT order_num,prod_id
FROM OrderItems
WHERE prod_id IN ('BR01','BR02','BR03') AND quantity >=100;

SELECT prod_name,prod_price
FROM Products
WHERE prod_price BETWEEN 3 AND 6
ORDER BY prod_price;

--5
SELECT prod_name
FROM Products
WHERE prod_name LIKE '%toy%';

SELECT prod_name,prod_desc
FROM Products
WHERE NOT prod_name LIKE '%toy%';

SELECT prod_name,prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%' AND prod_desc LIKE '%carrots%';

SELECT prod_name,prod_desc
FROM Products
WHERE prod_desc LIKE '%toy%carrots%';

--6
SELECT
    vend_id,
    vend_name AS vname,
    vend_address AS vaddress,
    vend_city AS vcity
FROM Vendors
ORDER BY vend_name;

SELECT 
    prod_id,
    prod_price,
    prod_price*0.9 AS sale_price 
FROM Products;

--7
SELECT
    cust_id,
    cust_name,
    Concat(
        UPPER(LEFT(cust_contact, 2)),
        UPPER(LEFT(cust_city, 3)),
        ' (',
        cust_name,
        '，居住在',
        cust_address,
        ' )'
    ) AS user_login
FROM Customers;

SELECT order_num, order_date
FROM Orders
WHERE (
        YEAR(order_date) = 2020
        AND MONTH(order_date) = 1
    )
    OR YEAR(order_date) < 2020;

--8
SELECT SUM(quantity) AS sum
FROM OrderItems;

SELECT SUM(quantity) AS sum
FROM OrderItems
WHERE prod_id = 'BR01';

SELECT MAX(prod_price) AS max_price
FROM Products
WHERE prod_price <= 10;

--9
SELECT order_num,COUNT(*) AS order_lines
FROM OrderItems
GROUP BY order_num
ORDER BY order_lines;

SELECT prod_id,MIN(prod_price) AS cheapest_item
FROM Products
GROUP BY prod_id;

SELECT order_num,SUM(quantity) AS sum_price
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity)>=100;

SELECT order_num,SUM(quantity*item_price) AS sum_price
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity*item_price)>=1000
ORDER BY sum_price;

--10
SELECT cust_id
FROM Orders
WHERE order_num IN (
        SELECT order_num
        FROM OrderItems
        WHERE item_price >= 10
    );

SELECT cust_id
FROM Orders
WHERE order_num IN (
        SELECT order_num
        FROM OrderItems
        WHERE prod_id = 'BR01'
    )
ORDER BY order_date;

SELECT cust_email
FROM Customers
WHERE cust_id IN (
        SELECT cust_id
        FROM Orders
        WHERE order_num IN (
                SELECT
                    order_num
                FROM
                    OrderItems
                WHERE
                    prod_id = 'BR01'
            )
    );

SELECT cust_id, (
        SELECT
            SUM(quantity * item_price)
        FROM OrderItems
        WHERE
            Orders.order_num = OrderItems.order_num
    ) AS total_ordered
FROM Orders
ORDER BY total_ordered DESC;

SELECT prod_name, (
        SELECT SUM(quantity)
        FROM OrderItems
        WHERE
            OrderItems.prod_id = Products.prod_id
    ) AS quant_sold
FROM Products

--11
SELECT cust_name, order_num
FROM Customers, Orders
WHERE
    Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;

SELECT cust_name, order_num
FROM Customers
    INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;

SELECT
    cust_name,
    Orders.order_num,
    sum(quantity * item_price) as ordertotal
FROM
    Customers,
    Orders,
    OrderItems
WHERE
    Customers.cust_id = Orders.cust_id
    AND Orders.order_num = OrderItems.order_num
GROUP BY
    cust_name,
    Orders.order_num
ORDER BY cust_name, order_num;

SELECT cust_id, order_date
FROM Orders, OrderItems
WHERE
    prod_id = 'BR01'
    AND Orders.order_num = OrderItems.order_num;

SELECT cust_id, order_date
FROM Orders
    INNER JOIN OrderItems ON prod_id = 'BR01' AND Orders.order_num = OrderItems.order_num

SELECT cust_email
FROM Customers
    INNER JOIN Orders ON Orders.cust_id = Customers.cust_id
    INNER JOIN OrderItems ON Orders.order_num = OrderItems.order_num
WHERE prod_id = 'BR01'

SELECT
    cust_name,
    SUM(quantity * item_price) AS total_price
FROM
    Orders,
    Customers,
    OrderItems
WHERE
    Customers.cust_id = Orders.cust_id
    AND Orders.order_num = OrderItems.order_num
GROUP BY cust_name
HAVING
    SUM(item_price * quantity) >= 1000
ORDER BY cust_name;

SELECT
    cust_name,
    SUM(item_price * quantity) AS total_price
FROM Customers
    INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
    INNER JOIN OrderItems ON Orders.order_num = OrderItems.order_num
GROUP BY cust_name
HAVING
    SUM(item_price * quantity) >= 1000
ORDER BY cust_name;

--12
SELECT C.cust_name, O.order_num
FROM Customers AS C
LEFT JOIN Orders AS O ON C.cust_id = O.cust_id
UNION
SELECT C.cust_name, O.order_num
FROM Customers AS C
RIGHT JOIN Orders AS O ON C.cust_id = O.cust_id;

SELECT cust_name, order_num
FROM Customers
LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

SELECT prod_name, order_num
FROM Products
RIGHT OUTER JOIN OrderItems ON OrderItems.prod_id = Products.prod_id
ORDER BY prod_name;

SELECT prod_name, SUM(quantity) AS total
FROM Products
RIGHT OUTER JOIN OrderItems ON OrderItems.prod_id = Products.prod_id
GROUP BY prod_name
ORDER BY prod_name;

SELECT Vendors.vend_id, COUNT(prod_id)
FROM Vendors
LEFT OUTER JOIN Products ON Vendors.vend_id = Products.vend_id
GROUP BY Vendors.vend_id;

--13
SELECT prod_id,quantity
FROM OrderItems
WHERE quantity=100
UNION
SELECT prod_id,quantity
FROM OrderItems
WHERE prod_id LIKE 'BNBG%';

SELECT prod_id,quantity
FROM OrderItems
WHERE quantity=100 OR prod_id LIKE 'BNBG%';

SELECT prod_name
FROM Products
UNION
SELECT cust_name
FROM Customers
ORDER BY prod_name;

--14
INSERT INTO Customers(cust_id,
 cust_name,
cust_address,
 cust_city,
cust_state,
 cust_zip,
 cust_country,
 cust_contact,
 cust_email)
VALUES(1000000010,
 'Toy Land',
 '123 Any Street',
 'New York',
 'NY',
 '11111',
 'USA',
 NULL,
 NULL);

select * into orderscopy from orders
select * into orderitemscopy from orderitems

--15
UPDATE Vendors
SET vend_state=UPPER(vend_state);

UPDATE Customers
SET cust_state=UPPER(cust_state);

DELETE FROM Customers
WHERE cust_id = 1000000010;

--16
ALTER TABLE Vendors
ADD vend_web CHAR(255);

UPDATE Vendors
SET vend_web='https://www.google.com.hk'
WHERE vend_id='BRE02'

--17
CREATE VIEW CustomersWithOrders AS
SELECT Customers.cust_id,cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country,cust_contact,cust_email
FROM Customers
INNER JOIN Orders ON Orders.cust_id = Customers.cust_id;

