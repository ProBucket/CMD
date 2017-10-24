DECLARE @OrderItemId int
DECLARE @SchoolPackage_Id int
DECLARE @SchoolPhoto_SchoolId int
DECLARE @SchoolPhoto_Year int
DECLARE @TeamPhoto_Id int
DECLARE @Team_SchoolId int
DECLARE @Team_Year int

DECLARE student_cursor CURSOR FOR   
SELECT oi.Id as OrderItemId,
sp.Id as SchoolPackage_Id, ps.Id as SchoolPhoto_SchoolId, p.Year as SchoolPhoto_Year,
tp.Id as TeamPhoto_Id, ts.Id as Team_SchoolId, te.Year as Team_Year
FROM OrderItems as oi
LEFT JOIN TeamPhotoes tp on tp.Id = oi.TeamPhoto_Id
LEFT JOIN TeamEvents te on te.Id = tp.TeamEvent_Id
LEFT JOIN Schools ts on ts.ID = te.School_Id
LEFT JOIN SchoolPackages sp on sp.Id = oi.SchoolPackage_Id
LEFT JOIN SchoolPhotoes p on p.Id = sp.SchoolPhoto_Id
LEFT JOIN Schools ps on ps.ID = p.SchoolId

OPEN student_cursor  
FETCH NEXT FROM student_cursor 
INTO @OrderItemId, @SchoolPackage_Id, @SchoolPhoto_SchoolId, @SchoolPhoto_Year, @TeamPhoto_Id, @Team_SchoolId, @Team_Year

WHILE @@FETCH_STATUS = 0  
BEGIN  

	IF @SchoolPackage_Id > 0
	BEGIN
		UPDATE OrderItems set School_Id = @SchoolPhoto_SchoolId, Year = @SchoolPhoto_Year where Id = @OrderItemId
	END
	IF @TeamPhoto_Id > 0
	BEGIN
		UPDATE OrderItems set School_Id = @Team_SchoolId, Year = @Team_Year where Id = @OrderItemId
	END

	FETCH NEXT FROM student_cursor
	INTO @OrderItemId, @SchoolPackage_Id, @SchoolPhoto_SchoolId, @SchoolPhoto_Year, @TeamPhoto_Id, @Team_SchoolId, @Team_Year

END
   
CLOSE student_cursor;  
DEALLOCATE student_cursor;  
