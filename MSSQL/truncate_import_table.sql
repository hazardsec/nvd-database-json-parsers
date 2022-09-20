-- REPLACE <db_name> WITH EXISTING DATABASE NAME
DECLARE @db_name nvarchar(MAX) = '<db_name>';
-- REPLACE <db_owner> WITH EXISTING OWNER NAME
DECLARE @db_owner nvarchar(MAX) = '<db_owner>';
-- REPLACE <table_name> WITH EXISTING IMPORT TABLE NAME
DECLARE @import_table_name nvarchar(MAX) = '<table_name>'

DECLARE @query [nvarchar](MAX) = N'TRUNCATE TABLE [' + @db_name + '].[' + @db_owner + '].[' + @import_table_name + '];'

EXEC sp_executesql @query;