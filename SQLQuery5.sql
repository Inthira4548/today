--��� Query �����Ũҡ���µ��ҧ (Join)
-- 1.   ���ʴ��������������觫��� ���ͺ���ѷ�١��� ������й��ʡ�ž�ѡ�ҹ(㹤���������ǡѹ) �ѹ�����觫��� ���ͺ���ѷ���觢ͧ ���ͧ��л���ȷ���觢ͧ� ����֧�ʹ�Թ����ͧ�Ѻ�ҡ�١��Ҵ���  
SELECT 
    o.OrderID,
    c.CompanyName AS CustomerCompany,
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    o.OrderDate,
    s.CompanyName AS ShipperCompany,
    o.ShipCity,
    o.ShipCountry,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Shippers s ON o.ShipVia = s.ShipperID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    o.OrderID, c.CompanyName, e.FirstName, e.LastName, 
    o.OrderDate, s.CompanyName, o.ShipCity, o.ShipCountry
ORDER BY o.OrderID;

-- 2.   ���ʴ� ������ ���ͺ���ѷ�١��� ���ͼ��Դ��� ���ͧ ����� �ӹǹ���觫��ͷ������Ǣ�ͧ��� �ʹ�����觫��ͷ��������͡��੾����͹ ���Ҥ��֧ �չҤ�  1997
SELECT 
    c.CompanyName,
    c.ContactName,
    c.City,
    c.Country,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE o.OrderDate BETWEEN '1997-01-01' AND '1997-03-31'
GROUP BY c.CompanyName, c.ContactName, c.City, c.Country
ORDER BY TotalAmount DESC;

-- 3.   ���ʴ���������ͧ��ѡ�ҹ ���˹� �������Ѿ�� �ӹǹ���觫��� ����֧�ʹ�����觫��ͷ��������͹��Ȩԡ�¹ �ѹ�Ҥ� 2539  �·�����觫��͹�鹶١��任���� USA, Canada ���� Mexico
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    e.Title,
    e.HomePhone,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE (o.OrderDate BETWEEN '1996-11-01' AND '1996-12-31')
  AND o.ShipCountry IN ('USA', 'Canada', 'Mexico')
GROUP BY e.FirstName, e.LastName, e.Title, e.HomePhone
ORDER BY TotalAmount DESC;

-- 4.   ���ʴ������Թ��� �����Թ��� �Ҥҵ��˹���  ��Шӹǹ����������������͹ �Զع�¹ 2540
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate BETWEEN '1997-06-01' AND '1997-06-30'
GROUP BY p.ProductID, p.ProductName, p.UnitPrice
ORDER BY TotalQuantity DESC;

-- 5.   ���ʴ������Թ��� �����Թ��� �Ҥҵ��˹��� ����ʹ�Թ������������� ���͹ ���Ҥ� 2540 �ʴ��繷ȹ���2 ���˹�
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalAmount
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate BETWEEN '1997-01-01' AND '1997-01-31'
GROUP BY p.ProductID, p.ProductName, p.UnitPrice
ORDER BY TotalAmount DESC;

-- 6.   ���ʴ����ͺ���ѷ���᷹��˹��� ���ͼ��Դ��� ������ ���� Fax ���� �����Թ��� �Ҥ� �ӹǹ�������˹�����㹻� 1996
SELECT 
    s.CompanyName AS SupplierCompany,
    s.ContactName,
    s.Phone,
    s.Fax,
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    SUM(od.Quantity) AS TotalQuantity
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY s.CompanyName, s.ContactName, s.Phone, s.Fax, p.ProductID, p.ProductName, p.UnitPrice
ORDER BY s.CompanyName;

-- 7.   ���ʴ������Թ��� �����Թ��� �Ҥҵ��˹���  ��Шӹǹ�������������੾�Тͧ�Թ��ҷ���繻����� Seafood �����任���� USA 㹻� 1997
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    SUM(od.Quantity) AS TotalQuantity
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Seafood'
  AND o.ShipCountry = 'USA'
  AND YEAR(o.OrderDate) = 1997
GROUP BY p.ProductID, p.ProductName, p.UnitPrice
ORDER BY TotalQuantity DESC;

-- 8.   ���ʴ���������ͧ��ѡ�ҹ����յ��˹� Sale Representative ���اҹ�繻� ��Шӹǹ���觫��ͷ���������Ѻ�Դ�ͺ㹻� 1998
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    DATEDIFF(YEAR, e.HireDate, GETDATE()) AS YearsOfService,
    COUNT(DISTINCT o.OrderID) AS TotalOrders
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID AND YEAR(o.OrderDate) = 1998
WHERE e.Title = 'Sales Representative'
GROUP BY e.FirstName, e.LastName, e.HireDate
ORDER BY YearsOfService DESC;

-- 9.   �ʴ����������ѡ�ҹ ���˹觧ҹ �ͧ��ѡ�ҹ������Թ���������ѷ Frankenversand 㹻�  1996
SELECT DISTINCT
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    e.Title
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.CompanyName = 'Frankenversand'
  AND YEAR(o.OrderDate) = 1996;

-- 10.  ���ʴ�����ʡ�ž�ѡ�ҹ㹤���������ǡѹ �ʹ����Թ��һ����� Beverage ������Ф������ 㹻� 1996
SELECT 
    e.LastName + ' ' + e.FirstName AS EmployeeName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS BeverageSales
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE c.CategoryName = 'Beverages'
  AND YEAR(o.OrderDate) = 1996
GROUP BY e.LastName, e.FirstName
ORDER BY BeverageSales DESC;

-- 11.  ���ʴ����ͻ������Թ��� �����Թ��� �����Թ��� �ʹ�Թ�������(�ѡ��ǹŴ����) ���͹���Ҥ� - �չҤ� 2540 �� �վ�ѡ�ҹ����¤�� Nancy
SELECT 
    c.CategoryName,
    p.ProductID,
    p.ProductName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE e.FirstName = 'Nancy'
  AND o.OrderDate BETWEEN '1997-01-01' AND '1997-03-31'
GROUP BY c.CategoryName, p.ProductID, p.ProductName
ORDER BY TotalAmount DESC;

-- 12.  ���ʴ����ͺ���ѷ�١��ҷ������Թ��һ����� Seafood 㹻� 1997
SELECT DISTINCT 
    cu.CompanyName
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Customers cu ON o.CustomerID = cu.CustomerID
WHERE c.CategoryName = 'Seafood'
  AND YEAR(o.OrderDate) = 1997
ORDER BY cu.CompanyName;

-- 13.  ���ʴ����ͺ���ѷ�����Թ��� ������Թ������ �١��ҷ���շ���� �����趹� Johnstown Road �ʴ��ѹ������Թ��Ҵ��� (�ٻẺ 106)
SELECT 
    s.CompanyName AS ShipperCompany,
    o.ShippedDate,
    o.ShipName,
    o.ShipAddress
FROM Orders o
JOIN Shippers s ON o.ShipVia = s.ShipperID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Address LIKE '%Johnstown Road%'
ORDER BY o.ShippedDate;



-- 14.  ���ʴ����ʻ������Թ��� ���ͻ������Թ��� �ӹǹ�Թ���㹻�������� ����ʹ��������������� �ʴ��繷ȹ��� 4 ���˹� �ѡ��ǹŴ
SELECT 
    c.CategoryID,
    c.CategoryName,
    COUNT(p.ProductID) AS TotalProducts,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 4) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalSales DESC;

-- 15.  ���ʴ����ͺ���ѷ�١��� �����������ͧ London , Cowes �����觫����Թ��һ����� Seafood �ҡ����ѷ���᷹��˹��·������㹻���ȭ���������Ť���͡�����Թ����
SELECT 
    cu.CompanyName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalAmount
FROM Orders o
JOIN Customers cu ON o.CustomerID = cu.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE cu.City IN ('London', 'Cowes')
  AND c.CategoryName = 'Seafood'
  AND s.Country = 'Japan'
GROUP BY cu.CompanyName
ORDER BY TotalAmount DESC;

-- 16.  �ʴ����ʺ���ѷ���� ���ͺ���ѷ���� �ӹǹorders ����� ��Ң��觷�����  ੾�з����任���� USA
SELECT 
    s.ShipperID,
    s.CompanyName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.Freight) AS TotalFreight
FROM Shippers s
JOIN Orders o ON s.ShipperID = o.ShipVia
WHERE o.ShipCountry = 'USA'
GROUP BY s.ShipperID, s.CompanyName
ORDER BY TotalOrders DESC;

-- 17.  ���ʴ�������;�ѡ�ҹ ����������ҡ���� 60�� ���ʴ� ���ͺ���ѷ�١���,���ͼ��Դ���,������,Fax,�ʹ����ͧ�Թ��һ����� Condiment ����١���������«��� �ʴ��繷ȹ���4���˹�,����ʴ�੾���١��ҷ��������ῡ��
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    cu.CompanyName,
    cu.ContactName,
    cu.Phone,
    cu.Fax,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 4) AS TotalCondimentSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Customers cu ON o.CustomerID = cu.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE DATEDIFF(YEAR, e.BirthDate, GETDATE()) > 60
  AND c.CategoryName = 'Condiments'
  AND cu.Fax IS NOT NULL
GROUP BY e.FirstName, e.LastName, cu.CompanyName, cu.ContactName, cu.Phone, cu.Fax
ORDER BY TotalCondimentSales DESC;

-- 18.  ���ʴ���������� �ѹ���  3 �Զع�¹ 2541 ��ѡ�ҹ���Ф� ����Թ��� �����ʹ�Թ���� ���������ʴ����ͤ����������¢ͧ����
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    ISNULL(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 0) AS TotalSales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID 
    AND o.OrderDate = '1998-06-03'
LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalSales DESC;

-- 19.  ���ʴ�������¡����觫��� ���;�ѡ�ҹ ���ͺ���ѷ�١��� ������ �ѹ����١��ҵ�ͧ����Թ��� ੾����¡�÷���վ�ѡ�ҹ�����ҡ�����繤��Ѻ�Դ�ͺ���������ʴ��ʹ�Թ�������١��ҵ�ͧ���д��� (�ȹ��� 2 ���˹�)
SELECT 
    o.OrderID,
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    cu.CompanyName,
    cu.Phone,
    o.RequiredDate,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS TotalAmount
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Customers cu ON o.CustomerID = cu.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE e.FirstName = 'Margaret'
GROUP BY o.OrderID, e.FirstName, e.LastName, cu.CompanyName, cu.Phone, o.RequiredDate
ORDER BY TotalAmount DESC;

-- 20.  ���ʴ����������ѡ�ҹ ���اҹ�繻� �������͹ �ʹ������������� ���͡��੾���١��ҷ������� USA, Canada, Mexico ��������������á�ͧ�� 2541
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeFullName,
    DATEDIFF(YEAR, e.HireDate, GETDATE()) AS YearsOfService,
    DATEDIFF(MONTH, e.HireDate, GETDATE()) AS MonthsOfService,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers cu ON o.CustomerID = cu.CustomerID
WHERE cu.Country IN ('USA', 'Canada', 'Mexico')
  AND o.OrderDate BETWEEN '1998-01-01' AND '1998-03-31'
GROUP BY e.FirstName, e.LastName, e.HireDate
ORDER BY TotalSales DESC;
