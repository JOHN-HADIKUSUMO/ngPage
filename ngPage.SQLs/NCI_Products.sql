IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'NCI_Products')   
    DROP INDEX NCI_Products ON Products;   
GO  

CREATE NONCLUSTERED INDEX NCI_Products   
    ON Products (Name);   
GO