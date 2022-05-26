use WTDB
--DELETE FROM [(spxml_objects)] WHERE form='statistic_data' AND id not in (SELECT id FROM statistic_data)
SELECT count(*) FROM statistic_data
SELECT count(*) FROM [(spxml_objects)] WHERE form='statistic_data' AND is_deleted in (1,2)
SELECT count(*) FROM statistic_datas
SELECT count(*) FROM [(spxml_objects)] WHERE form='statistic_data'

/*2663973
0
2659381
2663973*/

--SELECT TOP 10 * FROM statistic_datas ORDER BY creation_date DESC 
--SELECT TOP 10 * FROM statistic_data ORDER BY created DESC
