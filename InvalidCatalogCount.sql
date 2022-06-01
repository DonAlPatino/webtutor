/*select * from [(spxml_objects)] where id ='6977704728104293515'*/

DECLARE @Count1 INT, @Count2 INT, @Count3 INT

SET @Count1 = (select COUNT(*) from person_object_links)
SET @Count2 = (select COUNT(*) from person_object_link)
SET @Count3 = (select COUNT(*) from person_object_link l inner join [(spxml_objects)] so on l.id=so.id and so.is_deleted in (1,2))

PRINT 'person_object_link'
PRINT CAST(@Count1 as NVARCHAR(100)) + ' ' + CAST(@Count2 as NVARCHAR(100))+ ' ' + CAST(@Count3 as NVARCHAR(100))

SET @Count1 = (select COUNT(*) from events)
SET @Count2 = (select COUNT(*) from event)
SET @Count3 = (select COUNT(*) from event l inner join [(spxml_objects)] so on l.id=so.id and so.is_deleted in (1,2))

PRINT 'event'
PRINT CAST(@Count1 as NVARCHAR(100)) + ' ' + CAST(@Count2 as NVARCHAR(100))+ ' ' + CAST(@Count3 as NVARCHAR(100))

SET @Count1 = (select COUNT(*) from object_versions)
SET @Count2 = (select COUNT(*) from object_version)
SET @Count3 = (select COUNT(*) from object_version l inner join [(spxml_objects)] so on l.id=so.id and so.is_deleted in (1,2))

PRINT 'object_version'
PRINT CAST(@Count1 as NVARCHAR(100)) + ' ' + CAST(@Count2 as NVARCHAR(100))+ ' ' + CAST(@Count3 as NVARCHAR(100))