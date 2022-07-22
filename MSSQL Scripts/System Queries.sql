select * from information_schema.columns  where column_name Like '%Last%'

SELECT COLUMN_NAME AS 'Column_Name', TABLE_NAME AS 'Table_Name'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME ='draft_nbr'
ORDER BY Table_Name, Column_Name
