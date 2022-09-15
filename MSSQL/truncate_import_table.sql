-- REPLACE <db_name> WITH EXISTING DATABASE NAME
DECLARE @db_name varchar(100) = '<db_name>';
-- REPLACE <db_owner> WITH EXISTING OWNER NAME
DECLARE @db_owner varchar(100) = '<db_owner>';
-- REPLACE <table_name> WITH EXISTING IMPORT TABLE NAME
DECLARE @import_table_name varchar(100) = '<table_name>'

DECLARE @query [nvarchar](MAX) = N'TRUNCATE TABLE [@db_name].[@db_owner].[@import_table_name];'

EXEC sp_executesql @query;