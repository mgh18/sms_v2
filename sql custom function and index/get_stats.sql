USE [SMS]
GO
/****** Object:  UserDefinedFunction [dbo].[get_stat2]    ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[get_stat2]
    (  
       @Teacher_id int  
       
    )  
    returns table  
    as  
    return (
	
	
	select nc.Course_Title,Count(i.Invite) as num_of_student_who_invited,
	COUNT(i.IsAccepted) as num_of_student_who_accepted, CAST(ROUND(Count(i.IsAccepted)*100.0/Count(i.Invite),2)as decimal(5,2)) as Percentage,
	CAST( COUNT(i.Invite) * COUNT(i.IsAccepted) AS float) / 
	(select  COUNT(i.Invite) as total_invite
	from Invitation i 
	where i.Teacher_ID = @Teacher_id) as newval
	from Course c inner join Invitation i on c.Sysid = i.Course_ID inner join NameOfCourse nc on c.Name = nc.Sysid
	where i.Teacher_ID = @Teacher_id
	group by  nc.Course_Title
	
	)  