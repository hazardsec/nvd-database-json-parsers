# Instructions for MSSQL Parser using Static Scripts

## Create Tables
Create an import table, a target or persistent table, and a history table using the create_import_table.sql, create_target_table.sql, and create_target_history_table.sql files. You will need to follow the comments in each script to replace placeholders with the appropriate values for your environment.

## Parse and Import JSON Files
Download NVD JSON file from https://nvd.nist.gov/vuln/data-feeds and extract the compressed files to a directory.

### Backup Current State to Target History Table
Follow instructions in comments for insert_history.sql to update the different database and table names and then execute the script to update history.

### Import the Yearly Files
Parse and import the files by following the instructions in the comments in import_script.sql to replace placeholders with the appropriate values and import all files with a year suffix first 2002-Current (e.g. nvdcve-1.1-2002.json - nvdcve-1.1-2022.json). You will need to run import_script.sql for each file after updating the file_name and other placeholders.

### Merge Import Table into Persistent Table
After importing all the files with a year, update the target table (the persistent NVD database table) using the merge_table_script.sql file (you will need to follow the instructions in the comments to update certain fields).

### Truncate Import Table
After importing the yearly files, truncate the import table by running the truncate_import_table.sql script after updating the placeholders referenced in the comments

### Import the Recent File
Parse and import the Recent NVD file by following the instructions in the comments in import_script.sql to replace placeholders with the appropriate values. The filename for recent should be something like nvdcve-1.1-recent.json.

### Merge Import Table into Persistent Table for Recent
After importing the Recent file, update the target table (the persistent NVD database table) using the merge_table_script.sql file (you will need to follow the instructions in the comments to update certain fields if not already completed).

### Truncate Import Table Again
After importing the Recent file, truncate the import table by running the truncate_import_table.sql script after updating the placeholders referenced in the comments

### Import the Modified File
Parse and import the Modified NVD file by following the instructions in the comments in import_script.sql to replace placeholders with the appropriate values. The filename for recent should be something like nvdcve-1.1-modified.json.

### Merge Import Table into Persistent Table for Recent
After importing the Modified file, update the target table (the persistent NVD database table) using the merge_table_script.sql file (you will need to follow the instructions in the comments to update certain fields if not already completed).

### Truncate Import Table Again
After importing the Modified file, truncate the import table by running the truncate_import_table.sql script after updating the placeholders referenced in the comments

NOTE: NIST updates the NVD yearly files daily (if updates required), Recent and Modified files are updated every hour or so by NIST as needed
