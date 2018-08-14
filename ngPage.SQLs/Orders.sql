IF EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Orders') AND type in (N'V'))
   DROP VIEW Orders

GO

CREATE VIEW Orders
AS
SELECT
S.SalesID AS Id,
(SELECT FirstName + CASE COALESCE (MiddleInitial, '') WHEN '' THEN ' ' ELSE ' ' + MiddleInitial + ' ' END + LastName  FROM Customers WHERE CustomerID = S.CustomerID )AS Fullname,
(SELECT Name FROM Products WHERE ProductID = S.ProductID) AS Product,
S.Quantity,
(SELECT Price FROM Products WHERE ProductID = S.ProductID) AS Price
FROM  Sales S

GO
