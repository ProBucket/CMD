
==================================================================
-- Create SQL statements to actually drop those FK relations 

SELECT 
    'ALTER TABLE [' +  OBJECT_SCHEMA_NAME(parent_object_id) +
    '].[' + OBJECT_NAME(parent_object_id) + 
    '] DROP CONSTRAINT [' + name + ']'
FROM sys.foreign_keys
WHERE referenced_object_id = object_id('TeamCutOffs')


delete from StudentCaptures where Student_Id in ( select Id from Students where School_Id = 1500 and Year = 2018 )
