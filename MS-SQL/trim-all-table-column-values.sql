--
-- Trims all table column values
-- ref: http://stackoverflow.com/a/28871186
--
 
-- BEGIN CONFIG --
declare @tableSchema nvarchar(128)  = N'dbo';
declare @tableName sysname          = N'MyTableName';
-- END CONFIG --
 
declare @sql nvarchar(max);
 
select @sql = COALESCE(@sql+N',[', '[')+COLUMN_NAME+N']=ltrim(rtrim(['+COLUMN_NAME+N']))'
from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = @tableSchema
    and TABLE_NAME = @tableName
    and DATA_TYPE like N'%char%'
    and COLUMNPROPERTY(OBJECT_ID(TABLE_SCHEMA+N'.'+TABLE_NAME), COLUMN_NAME, 'IsComputed') = 0;
 
set @sql = N'update ['+@tableSchema+N'].['+@tableName+N'] set '+@sql;
 
print (@sql);
-- exec (@sql); -- uncomment to execute statement.
