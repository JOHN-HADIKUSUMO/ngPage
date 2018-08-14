IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SplitString') 
          AND type in (N'TF'))
    DROP FUNCTION SplitString

GO

CREATE FUNCTION [dbo].[SplitString]
  (@SourceString VARCHAR(MAX)
  ,@Seperator VARCHAR(25)=','
  )
 RETURNS @ResultTable
  TABLE(
    [Id] INT IDENTITY(1,1),
    [Value] NVARCHAR(MAX)
   )
AS
BEGIN
    DECLARE @w_xml xml;
 
    SET @w_xml = N'<root><i>' + replace(@SourceString, @Seperator,'</i><i>') + '</i></root>';
 
    INSERT INTO @ResultTable
        ([Value])
    SELECT
        [i].value('.', 'NVARCHAR(MAX)') AS Value 
    FROM
        @w_xml.nodes('//root/i') AS [Items]([i]);
    RETURN;
 END;
