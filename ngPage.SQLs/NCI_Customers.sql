IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'NCI_Customers')   
    DROP INDEX NCI_Customers ON Customers;   
GO  

CREATE NONCLUSTERED INDEX NCI_Customers   
    ON Customers (FirstName,MiddleInitial,LastName);   
GO