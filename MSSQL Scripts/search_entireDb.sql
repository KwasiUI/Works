DECLARE @TableName varchar(100), @ColumnName varchar(100), @TableID INT

DECLARE Jesse_Cursor CURSOR FOR
SELECT name, id FROM syscolumns WHERE xtype in (127/*, 231*/) ORDER BY id 

OPEN Jesse_Cursor
FETCH NEXT FROM Jesse_Cursor INTO @ColumnName, @TableID

WHILE @@FETCH_STATUS = 0
BEGIN
       IF (SELECT xtype FROM sysobjects WHERE id = @TableID) = 'U'
       BEGIN
              SET @TableName = (SELECT name FROM sysobjects WHERE id = @TableID)
              PRINT('SELECT * FROM ' + @TableName + ' WHERE ' +  @ColumnName + ' = 915478')
       END
       FETCH NEXT FROM Jesse_Cursor INTO @ColumnName, @TableID
END

CLOSE Jesse_Cursor;
DEALLOCATE Jesse_Cursor;
GO
