SELECT Orders.OrderDate,
       Customers.CompanyName AS Customer,
       Employees.FirstName + ' ' + Employees.LastName AS Employee
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID;




SELECT Customers.CompanyName,
       Customers.ContactName,
       Customers.City,
       Customers.Country,
       COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) = 1997
GROUP BY Customers.CompanyName, Customers.ContactName, Customers.City, Customers.Country;


SELECT Customers.CompanyName,
       Customers.ContactName,
       Customers.City,
       Customers.Country,
       Customers.Phone,
       COUNT(Orders.OrderID) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) = 1996
  AND MONTH(Orders.OrderDate) = 12
  AND Customers.Country IN ('USA', 'Canada', 'Mexico')
GROUP BY Customers.CompanyName, Customers.ContactName, Customers.City, Customers.Country, Customers.Phone;



SELECT Products.ProductName,
       [Order Details].UnitPrice,
       SUM([Order Details].Quantity) AS TotalQuantity
FROM [Order Details]
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(Orders.OrderDate) = 1997
  AND MONTH(Orders.OrderDate) = 6
GROUP BY Products.ProductName, [Order Details].UnitPrice;


SELECT Products.ProductName,
       [Order Details].UnitPrice,
       SUM([Order Details].Quantity) AS TotalQuantity
FROM [Order Details]
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
WHERE YEAR(Orders.OrderDate) = 1997
  AND MONTH(Orders.OrderDate) = 1
GROUP BY Products.ProductName, [Order Details].UnitPrice
HAVING SUM([Order Details].Quantity) > 2;
