use WTDB
GO         
DECLARE @number INT, @Day INT
SET @number = 7;
-- Day before delete
SET @Day = -60;
/*
select count(*) from dbo.[(spxml_objects)] where id in (select id from statistic_datas where modification_date < DATEADD(DAY, @Day, getDate()) )
select count(*) from statistic_data where id in (select id from statistic_datas where modification_date < DATEADD(DAY, @Day, getDate()) )
select count(*) from statistic_datas where modification_date < DATEADD(DAY, @Day, getDate())
*/
---48461356

select count(*) from dbo.[(spxml_objects)] where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) )
select count(*) from statistic_data where id in (select id from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate()) )
select count(*) from statistic_datas where creation_date < DATEADD(DAY, @Day, getDate())
----2663973 24/04/22