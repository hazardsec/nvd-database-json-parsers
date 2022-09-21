# Script for Automating Import of NVD Feeds

This script will support being run by 'sqlcmd' to automate the import process for downloaded NVD JSON Data Feeds.

## Example Usage
sqlcmd -i "\\wsl$\Ubuntu\home\username\code\nvd-to-markdown\vulnerability-management\community\cve-nvd\nvd-database-json-parsers\MSSQL\dynamic-params-script\nvd-data-feed-import.sql" -v file_name_prefix = "nvdcve-1.1-" -v file_path = """C:\Users\username\Downloads\NVDJSON\""" -v db_name = "MyDB" -v schema_name = "dbo" -v import_table_name = "nvd_import" -v target_table_name = "nvd_db" -v history_table_name = "nvd_db_history" -v incremental = "0"

The script assumes that the suffix of the files is '.json' and the only thing between the file_name_prefix and '.json' is the year (2002 - current) or recet or modified for the other files. Setting incremental to 1 will only import the 'recent' and 'modified' files. Setting incremental to 0 will import all years plus the 'recent' and 'modified' files. The files must be downloaded to the 'file_path' before running this script.