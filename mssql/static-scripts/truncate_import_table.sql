-- REPLACE <db_name> WITH EXISTING DATABASE NAME
DECLARE @db_name nvarchar(MAX) = '<db_name>';
-- REPLACE <schema_name> WITH EXISTING OWNER NAME
DECLARE @schema_name nvarchar(MAX) = '<schema_name>';
-- REPLACE <table_name> WITH EXISTING IMPORT TABLE NAME
DECLARE @import_table_name nvarchar(MAX) = '<table_name>'

DECLARE @query [nvarchar](MAX) = N'TRUNCATE TABLE [' + @db_name + '].[' + @schema_name + '].[' + @import_table_name + '];'

EXEC sp_executesql @query;