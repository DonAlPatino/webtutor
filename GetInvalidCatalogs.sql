declare @sql as nvarchar(4000 )
declare @form as varchar(256 )
declare @catalog as varchar(256 )
IF EXISTS (SELECT object_id( 'tempdb..#wrong_tables') where object_id('tempdb..#wrong_tables' ) is not NULL)
DROP TABLE #wrong_tables
create table #wrong_tables (form varchar(256 ))
DECLARE tr_cursor CURSOR FOR select distinct form from [(spxml_objects)] -- where (is_deleted = 1 and is_deleted = 2)
open tr_cursor
FETCH NEXT FROM tr_cursor
INTO @form
WHILE @@FETCH_STATUS = 0
BEGIN
select top 1 @catalog = tablename from [(spxml_metadata)] where spxml_form_elem like '%.'+ @form and doc_list = 1 and spxml_form_elem not like 'common.%'
set @sql = 'if exists(select id from ['+@catalog +']
where id in (select id from [(spxml_objects)] where is_deleted = 1)
or id in (select id from [(spxml_objects)] where is_deleted = 2)
)
select '''+@form +''' as form'
print @sql
insert #wrong_tables (form)
execute sp_executesql @sql
if (object_id (@form)) is null
begin
insert #wrong_tables (form)
select '[' +@form +'] not found'
end
if (object_id (@catalog)) is null
begin
insert #wrong_tables (form)
select '[' +@catalog +'] not found'
end
if (object_id (@form)) is not null
begin
set @sql = '
declare @v1 int
select @v1=count(*) from [' +@catalog+ ']
declare @v2 int
select @v2=count(*) from [(spxml_objects)] so
inner join ['+@form +'] obj on
so.id=obj.id
where form='''+@form +''' and is_deleted is null
if (@v1<>@v2)
select '''+@form +''' as form'
--print @sql
insert #wrong_tables (form)
execute sp_executesql @sql
end
FETCH NEXT FROM tr_cursor
INTO @form
END
close tr_cursor
deallocate tr_cursor
select distinct * from #wrong_tables