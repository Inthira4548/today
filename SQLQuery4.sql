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
 
 -- �ʴ����觫��������Ţ 10275
select CompanyName,OrderID
from Orders,Shippers 
where Shippers.ShipperID = Orders.ShipVia
and OrderID = 10275


select CompanyName,OrderID
from  Orders join Shippers
ON Shippers.ShipperID = Orders.ShipVia
where orderID = 10275


-- ��ͧ������ʾ�ѡ�ҹ ���;�ѡ�ҹ �������觫��ͷ������Ǣ�ͧ ���§����ӴѺ��ѡ�ҹ 
select e.EmployeeID , FirstName, OrderID
from Employees as e join  Orders as o on e.EmployeeID = o.EmployeeID
order by EmployeeID

-- ��ͧ��������Թ��� ���ͧ ��л���Ȣͧ����ѷ�٨�˹��� 
Select ProductID productName,city,country
from Products p join Suppliers s on p.SupplierID = s.SupplierID
-- ��ͧ��������Թ��� �����Թ��� ��Шӹǹ�������������
select p.ProductID,p.ProductName,SUM (Quantity) as �ӹǹ������������
from Products p join [Order Details] od on p.productID = od.productID 
Group by p.productID ,p.productName 
order  by  1
-- ��ͧ��ê��ͺ���ѷ���� ��Шӹǹ���觫��ͷ��١��ͧ
select CompanyName,COUNT(*)
from orders as o join Shippers as s on o.ShipVia = s.ShipperID
Group by CompanyName

SELECT O.OrderID �Ţ���觫���, C.CompanyName �١���,
E.FirstName ��ѡ�ҹ, O.ShipAddress ��价��
FROM Orders O, Customers C, Employees E WHERE O.CustomerID=C.CustomerID
AND o.EmployeeID=E.EmployeeID



select e.EmployeeID , FirstName , count(*)as [�ӹҹ order]  
from Employees e join Orders o on e.EmployeeID= o.EmployeeID 
where year(OrderDate)=1998
group by e.EmployeeID,FirstName
order by 3


select p.productID,p.productName 
from Employees e join orders o on e.EmployeeID = o. EmployeeID
                 join [Order Details] od on o.OrderID = od. OrderID
                 join products p on od. ProductID = p.ProductID
where e.FirstName = 'Nancy'
order by productID

--��ͧ��ê��ͺ���ѷ�١��Ҫ��� Around the Horn �����Թ�������Ҩҡ��������ú�ҧ

Select distinct s.Country
from customers c join orders o on c.CustomerID = o. CustomerID
join [Order Details] od on o.OrderID = od. OrderID
join Products p on od.ProductID = p.ProductID
join Suppliers s on s.SupplierID = p.SupplierID
where c. CompanyName = 'Around the Horn'

-- ����ѷ�١��Ҫ��� Around the Horn �����Թ������ú�ҧ �ӹǹ����

select p.ProductID, p.ProductName, sum(Quantity) as [sum of Quantity]
from customers c join orders o on c. CustomerID = o. CustomerID
join [Order Details] od on od.OrderID = o. OrderID
join products p on p.ProductID = od.ProductID
where c.CompanyName = 'Around the Horn'
Group by p.productID,p.productName
order by 1


--��ͧ��������Ţ���觫��� ���;�ѡ�ҹ ����ʹ������觫��͹��
Select o.OrderID, e. FirstName,
sum((od.Quantity * od.UnitPrice * (1-od.Discount))) as TotalCash
from orders o join Employees e on o. EmployeeID = e. EmployeeID
join [Order Details] od on o.OrderID = od. OrderID
GROUP by o. OrderID, e. FirstName
order by orderID
