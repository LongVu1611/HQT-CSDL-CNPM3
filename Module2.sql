--1) Liệt kê danh sách các hóa đơn (SalesOrderID) lặp trong tháng 6 năm 2008 có tổng tiền >70000, 
--thông tin gồm SalesOrderID, Orderdate, SubTotal, trong đó SubTotal =sum(OrderQty*UnitPrice). 
	select d.SalesOrderID, OrderDate, SubTotal=sum(OrderQty * UnitPrice)
	from sales.SalesOrderDetail d join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
	where  MONTH(OrderDate) = 6 and YEAR(OrderDate) = 2008  
	group by d.SalesOrderID, OrderDate
	having SUM(OrderQty * UnitPrice) > 70000

--2) Đếm tổng số khách hàng và tổng tiền của những khách hàng thuộc các quốc gia có mã vùng là US 
--(lấy thông tin từ các bảng SalesTerritory, Sales.Customer, Sales.SalesOrderHeader, Sales.SalesOrderDetail). 
--Thông tin bao gồm TerritoryID, tổng số khách hàng (countofCus), tổng tiền (Subtotal) với Subtotal = SUM(OrderQty*UnitPrice) 

	select t.TerritoryID, CountofCus= COUNT(c.CustomerID) , Subtotal=SUM(d.OrderQty * d.UnitPrice)  
	from Sales.SalesTerritory t join Sales.Customer  c on t.TerritoryID=c.TerritoryID
								join Sales.SalesOrderHeader h on h.CustomerID=h.CustomerID
								join Sales.SalesOrderDetail d on h.SalesOrderID=d.SalesOrderID
	where CountryRegionCode = 'US' 
	group by t.TerritoryID

	--3)

	select SalesOrderID, CarrierTrackingNumber, Subtotal=SUM(OrderQty * UnitPrice) 
	from Sales.SalesOrderDetail
	where CarrierTrackingNumber like '4BD%'
	group by SalesOrderID, CarrierTrackingNumber

--4) Liệt kê các sản phẩm (product)có đơn giá (unitPrice)<25 và số lượng bán trung bình >5, thông tin gồm ProductID, name,
--AverageofQty

	select pro.ProductID, pro.Name, AverageofQty=AVG(det.OrderQty) 
	from Sales.SalesOrderDetail det join Production.Product pro on det.ProductID = pro.ProductID
	where det.UnitPrice < 25
	group by pro.ProductID, pro.Name
	having AVG(det.OrderQty) > 5

--5) 

	select JobTitle, CountofEmployee=count(BusinessEntityID) 
	from HumanResources.Employee 
	group by JobTitle
	having COUNT(BusinessEntityID) > 20

--6) 

	select v.BusinessEntityID, v.Name, ProductID, sumofQty = SUM(OrderQty), SubTotal = SUM(OrderQty * UnitPrice)
	from Purchasing.Vendor v join Purchasing.PurchaseOrderHeader h on h.VendorID = v.BusinessEntityID
							 join Purchasing.PurchaseOrderDetail d on h.PurchaseOrderID = d.PurchaseOrderID
	where v.Name like '%Bicycles'
	group by v.BusinessEntityID, v.Name, ProductID
	having SUM(OrderQty * UnitPrice) > 800000	


--7) 
	select p.ProductID, p.Name, countofOrderID = COUNT(o.SalesOrderID), Subtotal = sum(OrderQty * UnitPrice) 
	from Production.Product p join Sales.SalesOrderDetail o on p.ProductID = o.ProductID
							  join sales.SalesOrderHeader h on h.SalesOrderID = o.SalesOrderID
	where Datepart(q, OrderDate) =1 and YEAR(OrderDate) = 2008
	group by p.ProductID, p.Name
	having sum(OrderQty * UnitPrice) > 10000 and COUNT(o.SalesOrderID) > 500



--8)
	select PersonID, FirstName +' '+ LastName as fullname, CountOfOrders=count(*)
	from [Person].[Person] p join [Sales].[Customer] c on p.BusinessEntityID=c.CustomerID
							 join [Sales].[SalesOrderHeader] h on h.CustomerID= c.CustomerID
	where YEAR([OrderDate])>=2007 and YEAR([OrderDate])<=2008
	group by PersonID, FirstName +' '+ LastName
	having count(*)>25

--9) 
	select p.ProductID, Name, CountofOrderQty=sum([OrderQty]), yearofSale=year([OrderDate])
	from [Production].[Product] p join [Sales].[SalesOrderDetail] d on p.ProductID=d.ProductID
								  join [Sales].[SalesOrderHeader] h on d.SalesOrderID=d.SalesOrderID
	where name like 'Bike%' or name like 'Sport%'
	group by p.ProductID, Name, year([OrderDate])
	having sum([OrderQty])>500
	
--10)
	select d.DepartmentID, d.name, AvgofRate=avg([Rate])
	from [HumanResources].[Department] d join [HumanResources].[EmployeeDepartmentHistory] h on d.DepartmentID=h.DepartmentID
						join [HumanResources].[EmployeePayHistory] e on h.BusinessEntityID=e.BusinessEntityID
	group by d.DepartmentID, d.name
	having avg([Rate])>30

