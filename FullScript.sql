use WTDB
GO    
--SET STATISTICS TIME ON;  
GO  
DECLARE @Day INT, @CountSPX INT, @Data INT, @Datas INT
DECLARE @CountSPX1 INT, @Data1 INT, @Datas1 INT

-- Day before delete
SET @Day = -60;

SET @CountSPX = (select count(*) from dbo.[(spxml_objects)] where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) ))
SET @Data = (select count(*) from statistic_data where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) ))
SET @Datas = (select count(*) from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()))

PRINT '---------Counting of records in tables'
PRINT @CountSPX
PRINT @Data
PRINT @Datas

PRINT '----------Number of records in circles'
if @CountSPX > 0
	SET @CountSPX1 = @CountSPX/1000000 + 1
ELSE
	SET @CountSPX1 = 0
PRINT @CountSPX1

if @Data > 0
	SET @Data1 = @Data/1000000 + 1
ELSE
	SET @Data1 = 0
PRINT @Data1

if @Datas > 0
	SET @Datas1 = @Datas/1000000 + 1
ELSE
	SET @Datas1 = 0
PRINT @Datas1

PRINT '---------Delete from (spxml_objects)'

WHILE @CountSPX1 > 0
    BEGIN
	--delete TOP (1000000) from dbo.[(spxml_objects)] where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) )
	PRINT @CountSPX1
    SET @CountSPX1 = @CountSPX1 - 1
    END;

Checkpoint

PRINT '---------Delete from statistic_data'

WHILE @Data1 > 0
    BEGIN
	--delete TOP (1000000) from statistic_data where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) )
	PRINT @Data1
    SET @Data1 = @Data1 - 1
    END;

Checkpoint
--Need check that sub tables is empty!!!

SET @CountSPX = (select count(*) from dbo.[(spxml_objects)] where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) ))
SET @Data = (select count(*) from statistic_data where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) ))

PRINT '--------Counting of records in tables after delete in subtables'
PRINT @CountSPX
PRINT @Data

PRINT '--------Delete from statistic_datas'

WHILE @Datas1 > 0
    BEGIN
	delete TOP (1000000) from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate())
	PRINT @Datas1
    SET @Datas1 = @Datas1 - 1
    END;

Checkpoint

--SET STATISTICS TIME OFF;  
GO  