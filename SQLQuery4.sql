select  CategoryName,ProductName,UnitPrice
from Products ,Categories 
where Products.CategoryID = Categories.CategoryID

Select  CategoryName,ProductName,UnitPrice
from Products as P join Categories as C 
on P.CategoryID = C.CategoryID



select CompanyName,OrderID
from Orders,Shippers 
where Shippers.ShipperID = Orders.ShipVia

select p.ProductID,p.ProductName,s.CompanyName,s.Country 
from Products p , Suppliers s 
where p.SupplierID = s.SupplierID

select CompanyName,OrderID
from Orders,Shippers 
where Shippers.ShipperID = Orders.ShipVia
and OrderID = 10275
