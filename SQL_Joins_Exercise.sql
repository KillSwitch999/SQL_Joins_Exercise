/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
 
-- All products that are in the "Computers" category
SELECT p.*
FROM products AS p
JOIN categories AS c ON c.CategoryID = p.CategoryID
WHERE c.Name = 'Computers';

-- Product name + Category name (for all products)
SELECT p.Name  AS ProductName,
       c.Name  AS CategoryName
FROM products AS p
JOIN categories AS c ON c.CategoryID = p.CategoryID
ORDER BY p.Name;

 
/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT p.Name   AS ProductName,
       p.Price,
       r.Rating
FROM products AS p
JOIN reviews  AS r ON r.ProductID = p.ProductID
WHERE r.Rating = 5
ORDER BY p.Name;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
SELECT e.EmployeeID,
       e.FirstName,
       e.LastName,
       SUM(s.Quantity) AS TotalQuantitySold
FROM employees AS e
JOIN sales     AS s ON s.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalQuantitySold DESC
LIMIT 1;
/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT d.Name AS DepartmentName,
       c.Name AS CategoryName
FROM categories  AS c
JOIN departments AS d ON d.DepartmentID = c.DepartmentID
WHERE c.Name IN ('Appliances', 'Games')
ORDER BY DepartmentName, CategoryName;


/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
SELECT p.Name AS ProductName,
       SUM(s.Quantity)                         AS TotalSold,
       SUM(s.Quantity * s.PricePerUnit)        AS TotalRevenue
FROM products AS p
JOIN sales    AS s ON s.ProductID = p.ProductID
WHERE p.Name = 'Eagles: Hotel California'
GROUP BY p.ProductID, p.Name;

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT p.Name     AS ProductName,
       r.Reviewer AS ReviewerName,
       r.Rating,
       r.Comment
FROM products AS p
JOIN reviews  AS r ON r.ProductID = p.ProductID
WHERE p.Name = 'Visio TV'
  AND r.Rating = (
        SELECT MIN(r2.Rating)
        FROM reviews  AS r2
        JOIN products AS p2 ON p2.ProductID = r2.ProductID
        WHERE p2.Name = 'Visio TV'
  )
ORDER BY ReviewerName;


-- ------------------------------------------ Extra - May be difficult
/* Your goal is to write a query that serves as an employee sales report.
This query should return:
-  the employeeID
-  the employee's first and last name
-  the name of each product
-  and how many of that product they sold */
SELECT e.EmployeeID,
       e.FirstName,
       e.LastName,
       p.Name            AS ProductName,
       SUM(s.Quantity)   AS QuantitySold
FROM employees AS e
JOIN sales     AS s ON s.EmployeeID = e.EmployeeID
JOIN products  AS p ON p.ProductID  = s.ProductID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, p.ProductID, p.Name
ORDER BY e.LastName, e.FirstName, p.Name;
