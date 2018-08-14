/*
DECLARE @Keywords NVARCHAR(100) = 'the,wife,that'
DECLARE @PageNo INT = 1
DECLARE @PageSize INT = 10
DECLARE @BlockSize INT = 10
DECLARE @OrderBy INT = 0
DECLARE @SortOrder INT = 0
DECLARE @TotalPages INT = 0
DECLARE @TotalRecords INT = 0

EXEC [dbo].[Orders_ReadAllByKeywords] @Keywords,@PageNo OUT,@PageSize,@BlockSize,@OrderBy,@SortOrder,@TotalPages OUT,@TotalRecords OUT
SELECT @PageNo 
SELECT @TotalPages
SELECT @TotalRecords
*/

IF  EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'Orders_ReadAllByKeywords') 
          AND type in (N'P', N'PC'))
    DROP PROCEDURE Orders_ReadAllByKeywords
GO


CREATE PROCEDURE [dbo].[Orders_ReadAllByKeywords]
(
	@Keywords NVARCHAR(100) = NULL,
	@PageNo INT = 1 OUT,
	@PageSize INT = 10,
	@BlockSize INT = 10,
	@OrderBy INT = 0,
	@SortOrder INT = 0,
	@TotalPages INT OUT,
	@TotalRecords INT OUT	
)
AS
BEGIN
	DECLARE @start INT = 0
	DECLARE @stop INT = 0
	DECLARE @numberofpages INT = 0
	DECLARE @numberofrecords INT = 0

    DECLARE @tempKeywords TABLE(
		Id INT,
		Value NVARCHAR(MAX)
	)

	INSERT INTO @tempKeywords SELECT * FROM [dbo].[SplitString](@Keywords,',')

	DECLARE @tempOrdered TABLE(
	RowId INT,
	Id INT,
	Fullname NVARCHAR(122),
    Product NVARCHAR(50),
	Quantity INT,
	Price DECIMAL
	)

	IF EXISTS(SELECT * FROM @tempKeywords) 
	   BEGIN
	        DECLARE @query NVARCHAR(MAX)
			DECLARE @subquery NVARCHAR(MAX)
			SET @subquery = (SELECT ' Fullname LIKE ''%' + VALUE + '%'' OR Product LIKE ''%' + VALUE + '%'' OR ' FROM @tempKeywords FOR XML PATH(''))
			SET @query = '
			DECLARE @tempOrders TABLE(
			Id INT,
			Fullname NVARCHAR(122),
			Product NVARCHAR(50),
			Quantity INT,
			Price DECIMAL
			)

			INSERT INTO @tempOrders 
			SELECT TOP 1000
			Id,
			Fullname,
			Product,
			Quantity,
			Price
			FROM Orders
			WHERE ' + Substring(@subquery,0,len(@subquery)-2) + '
			GROUP BY Id,Fullname,Product,Quantity,Price'
			
			IF @OrderBy = 0 /* By Tag Id */
			   BEGIN
			       IF @SortOrder = 0 /* Ascending */
				      BEGIN
					      SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Id ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
					  END
				   ELSE
				      BEGIN
						  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Id DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
					  END
			   END		
			ELSE
			   BEGIN
			       IF @OrderBy = 1 /* By Fullname */
				      BEGIN
						   IF @SortOrder = 0 /* Ascending */
							  BEGIN
								  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Fullname ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
							  END
						   ELSE
							  BEGIN
								  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Fullname DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
							  END
					  END
				   ELSE
				      BEGIN
						  IF @OrderBy = 2 /* By Product */
							 BEGIN
								   IF @SortOrder = 0 /* Ascending */
									  BEGIN
										  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Product ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
									  END
								   ELSE
									  BEGIN
										  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Product DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
									  END
							 END
						  ELSE
							 BEGIN
								 IF @OrderBy = 3 /* By Quantity */
									BEGIN
									   IF @SortOrder = 0 /* Ascending */
										  BEGIN
											  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Quantity ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
										  END
									   ELSE
										  BEGIN
											  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Quantity DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
										  END
							        END
								 ELSE
								    BEGIN  /* By Price */
									   IF @SortOrder = 0 /* Ascending */
										  BEGIN
											  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Price ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
										  END
									   ELSE
										  BEGIN
											  SET @query = @query + ' SELECT ROW_NUMBER() OVER(ORDER BY Price DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders '
										  END
									END
							 END
					  END
			   END

			INSERT INTO @tempOrdered EXECUTE(@query)

		END
	ELSE
		BEGIN
			DECLARE @tempOrders TABLE(
			Id INT,
			Fullname NVARCHAR(122),
			Product NVARCHAR(50),
			Quantity INT,
			Price DECIMAL
			)

			INSERT INTO @tempOrders
			SELECT TOP 1000
			Id,
			Fullname,
			Product,
			Quantity,
			Price
			FROM Orders
			GROUP BY Id,Fullname,Product,Quantity,Price

			IF @OrderBy = 0 /* By Id */
				BEGIN
					IF @SortOrder = 0 /* Ascending */
						BEGIN
							INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Id ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
						END
					ELSE
						BEGIN
							INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Id DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
						END
				END		
			ELSE
				BEGIN
					IF @OrderBy = 1 /* By Title */
						BEGIN
							IF @SortOrder = 0 /* Ascending */
								BEGIN
									INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Fullname ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
								END
							ELSE
								BEGIN
									INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Fullname DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
								END
						END
					ELSE
						BEGIN
							IF @OrderBy = 2 /* By NumberOfPhotos */
								BEGIN
									IF @SortOrder = 0 /* Ascending */
										BEGIN
											INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Product ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
										END
									ELSE
										BEGIN
											INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Product DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
										END
								END
							ELSE
								BEGIN
									IF @OrderBy = 3 /* By NumberOfNews */
										BEGIN
											IF @SortOrder = 0 /* Ascending */
												BEGIN
													INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Quantity ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
												END
											ELSE
												BEGIN
													INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Quantity DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
												END
										END
									ELSE
										BEGIN /* By CreatedDate */
											IF @SortOrder = 0 /* Ascending */
												BEGIN
													INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Price ASC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
												END
											ELSE
												BEGIN
													INSERT INTO @tempOrdered SELECT ROW_NUMBER() OVER(ORDER BY Price DESC) AS RowId,Id,Fullname,Product,Quantity,Price FROM @tempOrders 
												END
										END
								END
						END
				END
		END

		IF @PageSize <= 0 
		    BEGIN
				SET @PageSize = 10
	        END

	    SET @numberofrecords = COALESCE((SELECT TOP 1 MAX(RowId) FROM @tempOrdered),0)

	    IF @numberofrecords = 0
	        BEGIN
	            SET @numberofpages = 0
		        SET @PageNo = 0
	        END
	    ELSE
	        BEGIN
	            IF @numberofrecords <= @PageSize
		            BEGIN
		                SET @numberofpages = 1
				        SET @PageNo = 1
			        END
		        ELSE
		            BEGIN
			            SET @numberofpages = @numberofrecords/@PageSize
				        IF @numberofrecords % @PageSize > 0
				            BEGIN
								SET @numberofpages = @numberofpages + 1
					        END

				        IF @PageNo > @numberofpages
				            BEGIN
					            SET @PageNo = @numberofpages
					        END
			        END
			END

			SET @start = (@PageNo - 1) * @PageSize + 1
			SET @stop = @PageNo * @PageSize
			SET @TotalPages = @numberofpages
			SET @TotalRecords = @numberofrecords
  
			SELECT Id,Fullname,Product,Quantity,Price FROM @tempOrdered WHERE RowId >= @start AND RowID <= @stop		
END

GO
