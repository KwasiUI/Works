DECLARE @Date DATETIME, @FullImport INT, @FullExport INT, @Transshipment INT, @MtyImportExport INT, @Restows INT
TRUNCATE TABLE db_Result

DECLARE DataSum_Cursor CURSOR FOR
SELECT DISTINCT dDate FROM db_Data ORDER BY dDate

OPEN DataSum_Cursor
FETCH NEXT FROM DataSum_Cursor INTO @Date
WHILE @@FETCH_STATUS = 0
BEGIN
      SET @FullImport = (SELECT iFullImport FROM db_Data WHERE dDate = @Date)
      SET @FullExport = (SELECT iFullExport FROM db_Data WHERE dDate = @Date)
      SET @Transshipment = (SELECT iTransshipment FROM db_Data WHERE dDate = @Date)
      SET @MtyImportExport = (SELECT iMtyImportExport FROM db_Data WHERE dDate = @Date)
      SET @Restows = (SELECT iRestows FROM db_Data WHERE dDate = @Date)

      INSERT INTO db_Result VALUES(@Date,'Full Import',@FullImport)
      INSERT INTO db_Result VALUES(@Date,'Full Export',@FullExport)
      INSERT INTO db_Result VALUES(@Date,'Transshipment',@Transshipment)
      INSERT INTO db_Result VALUES(@Date,'Mty Import / Export',@MtyImportExport)
      INSERT INTO db_Result VALUES(@Date,'Restows',@Restows)
      
      FETCH NEXT FROM DataSum_Cursor INTO @Date
END

CLOSE DataSum_Cursor
DEALLOCATE DataSum_Cursor
GO
