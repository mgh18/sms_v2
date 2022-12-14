USE [master]
GO
/****** Object:  Database [SMS]    Script Date: 22/11/13 6:04:19 PM ******/
CREATE DATABASE [SMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SMS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SMS] SET RECOVERY FULL 
GO
ALTER DATABASE [SMS] SET  MULTI_USER 
GO
ALTER DATABASE [SMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SMS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SMS', N'ON'
GO
ALTER DATABASE [SMS] SET QUERY_STORE = OFF
GO
USE [SMS]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[Name] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[Day] [int] NULL,
	[Time] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invitation]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invitation](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[Teacher_ID] [int] NULL,
	[Course_ID] [int] NULL,
	[Student_ID] [int] NULL,
	[Invite] [bit] NOT NULL,
	[IsAccepted] [bit] NULL,
 CONSTRAINT [PK_Invitation_1] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NameOfCourse]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NameOfCourse](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[Course_Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_NameOfCourse] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[get_stat2]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[get_stat2]
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
GO
/****** Object:  UserDefinedFunction [dbo].[get_stats]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[get_stats]
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
	where i.Teacher_ID = @Teacher_id) as wavg
	from Course c inner join Invitation i on c.Sysid = i.Course_ID inner join NameOfCourse nc on c.Name = nc.Sysid
	where i.Teacher_ID = @Teacher_id
	group by  nc.Course_Title
	
	)  
GO
/****** Object:  UserDefinedFunction [dbo].[popularity]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[popularity](@teacher_id int)
returns table as
return
(select round(min(g.wavg),2) as minimum, round (max(g.wavg),2) as maximum
from get_stats(@teacher_id) as g
)
GO
/****** Object:  UserDefinedFunction [dbo].[LeastPopularCourse]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create FUNCTION  [dbo].[LeastPopularCourse]
(   
    @teacher_id int
)

RETURNS  table
AS

return
    (select g.Course_Title as LeastPopularCourse
	from get_stats(@teacher_id) as g 
	where g.wavg = (select min(g1.wavg) from get_stats(@teacher_id) as g1)

	)
GO
/****** Object:  UserDefinedFunction [dbo].[MostPopularCourse]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION  [dbo].[MostPopularCourse]
(   
    @teacher_id int
)

RETURNS  table
AS

return
    (select g.Course_Title as MostPopularCourse
	from get_stats(@teacher_id) as g 
	where g.wavg = (select max(g1.wavg) from get_stats(@teacher_id) as g1)

	)
GO
/****** Object:  Table [dbo].[Account]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[TeacherID] [int] NULL,
	[StudentID] [int] NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hours]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hours](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[HoursTitle] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Hours] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MenuItem]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuItem](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Link] [nvarchar](50) NULL,
	[Icon] [nvarchar](50) NULL,
 CONSTRAINT [PK_MenuItem] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMenu]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMenu](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[MenuId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_RoleMenu] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[Id] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Role] [int] NOT NULL,
	[Photo] [nvarchar](50) NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[CreatedBy] [int] NULL,
 CONSTRAINT [PK_Studentq] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teach]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teach](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[TeacherID] [int] NULL,
	[CourseID] [int] NULL,
 CONSTRAINT [PK_Teach] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[Id] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Role] [int] NULL,
	[Photo] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Weekdays]    Script Date: 22/11/13 6:04:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Weekdays](
	[Sysid] [int] IDENTITY(1,1) NOT NULL,
	[DayName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Weekdays] PRIMARY KEY CLUSTERED 
(
	[Sysid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (1, 1, NULL, N'0014041', 2)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (2, 2, NULL, N'0014042', 2)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (3, NULL, 1, N'0018081', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (4, NULL, 2, N'0018082', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (5, NULL, 3, N'0018083', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (6, NULL, 4, N'0018084', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (7, NULL, 5, N'0018085', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (8, NULL, 6, N'0018086', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (9, NULL, 7, N'0018087', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (10, NULL, 8, N'0018088', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (11, NULL, 9, N'0018089', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (12, NULL, 10, N'0018090', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (13, NULL, 14, N'0018091', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (14, NULL, 15, N'0018092', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (15, NULL, 16, N'0018093', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (16, NULL, 17, N'0018094', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (17, NULL, 18, N'0018095', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (18, NULL, 19, N'0018096', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (19, NULL, 20, N'0018097', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (20, NULL, 21, N'0018098', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (21, NULL, 22, N'0018099', 3)
INSERT [dbo].[Account] ([Sysid], [TeacherID], [StudentID], [Password], [RoleID]) VALUES (22, NULL, 23, N'0018100', 3)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Course] ON 

INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (1, 1, 1, 2, 4)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (2, 2, 1, 1, 3)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (4, 3, 2, 4, 3)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (5, 4, 2, 2, 2)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (6, 5, 2, 4, 2)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (23, 6, 2, 1, 2)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (24, 7, 2, 3, 1)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (37, 9, 1, 4, 3)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (38, 10, 2, 2, 1)
INSERT [dbo].[Course] ([Sysid], [Name], [CreatedBy], [Day], [Time]) VALUES (40, 9, 2, 1, 4)
SET IDENTITY_INSERT [dbo].[Course] OFF
GO
SET IDENTITY_INSERT [dbo].[Hours] ON 

INSERT [dbo].[Hours] ([Sysid], [HoursTitle]) VALUES (1, N'۱۴:۰۰-۱۲:۰۰')
INSERT [dbo].[Hours] ([Sysid], [HoursTitle]) VALUES (2, N'۱۶:۰۰-۱۴:۳۰')
INSERT [dbo].[Hours] ([Sysid], [HoursTitle]) VALUES (3, N'۱۸:۰۰-۱۶:۱۵')
INSERT [dbo].[Hours] ([Sysid], [HoursTitle]) VALUES (4, N'۲۰:۰۰-۱۸:۳۰')
SET IDENTITY_INSERT [dbo].[Hours] OFF
GO
SET IDENTITY_INSERT [dbo].[Invitation] ON 

INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1, 1, 1, 2, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (3, 1, 1, 4, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (4, 1, 1, 6, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (5, 1, 1, 8, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (6, 1, 1, 10, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (7, 1, 1, 15, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (8, 1, 1, 17, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (9, 1, 1, 1, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (10, 1, 2, 22, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (11, 1, 2, 21, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (15, 1, 2, 6, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (16, 1, 1, 18, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (17, 1, 2, 7, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (18, 1, 2, 4, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (19, 1, 2, 5, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (20, 1, 2, 19, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (22, 1, 2, 3, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (23, 1, 1, 23, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (25, 2, 4, 2, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (26, 2, 4, 4, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (27, 2, 4, 6, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (28, 2, 4, 1, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (29, 2, 24, 5, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (30, 2, 6, 8, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (31, 2, 4, 20, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (32, 2, 4, 21, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (33, 2, 4, 23, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (34, 2, 4, 22, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (35, 2, 23, 1, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (36, 2, 23, 2, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (37, 2, 5, 21, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (38, 2, 5, 6, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (40, 2, 24, 2, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (41, 2, 24, 19, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (42, 2, 4, 7, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (43, 2, 24, 22, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (44, 2, 5, 2, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (45, 2, 6, 7, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (46, 2, 6, 17, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (47, 2, 6, 4, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (48, 2, 6, 1, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (50, 2, 23, 20, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (51, 2, 23, 3, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (53, 2, 4, 8, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (54, 2, 6, 20, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (55, 2, 5, 3, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (56, 2, 23, 18, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (57, 2, 23, 9, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (58, 2, 23, 10, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (59, 1, 2, 23, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (62, 1, 2, 1, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (66, 1, 1, 22, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (67, 1, 1, 21, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (68, 1, 1, 20, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (77, 2, 4, 14, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1100, 2, 24, 6, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1101, 1, 37, 6, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1102, 1, 37, 4, 1, NULL)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1103, 1, 37, 20, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1104, 1, 37, 23, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1105, 2, 38, 3, 1, 0)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1106, 2, 37, 2, 1, 1)
INSERT [dbo].[Invitation] ([Sysid], [Teacher_ID], [Course_ID], [Student_ID], [Invite], [IsAccepted]) VALUES (1107, 1, 2, 2, 1, 0)
SET IDENTITY_INSERT [dbo].[Invitation] OFF
GO
SET IDENTITY_INSERT [dbo].[MenuItem] ON 

INSERT [dbo].[MenuItem] ([Sysid], [Name], [Link], [Icon]) VALUES (1, N'ادمین', NULL, NULL)
INSERT [dbo].[MenuItem] ([Sysid], [Name], [Link], [Icon]) VALUES (2, N'استاد', NULL, NULL)
INSERT [dbo].[MenuItem] ([Sysid], [Name], [Link], [Icon]) VALUES (3, N'دانشجو', NULL, NULL)
SET IDENTITY_INSERT [dbo].[MenuItem] OFF
GO
SET IDENTITY_INSERT [dbo].[NameOfCourse] ON 

INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (1, N'پایگاه داده')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (2, N'پایگاه داده پیشرفته')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (3, N'سیستم عامل')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (4, N'سیستم های توزیع شده')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (5, N'یادگیری ماشین')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (6, N'زبان ماشین')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (7, N'مبانی زبان های کامپیوتری')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (8, N'مدار منطقی')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (9, N'کامپایلر')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (10, N'زبان برنامه نویسی پایتون')
INSERT [dbo].[NameOfCourse] ([Sysid], [Course_Title]) VALUES (11, N'زبان برنامه نویسی C++')
SET IDENTITY_INSERT [dbo].[NameOfCourse] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Sysid], [Name]) VALUES (1, N'ادمین')
INSERT [dbo].[Role] ([Sysid], [Name]) VALUES (2, N'استاد')
INSERT [dbo].[Role] ([Sysid], [Name]) VALUES (3, N'دانشجو')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[RoleMenu] ON 

INSERT [dbo].[RoleMenu] ([Sysid], [RoleId], [MenuId], [CreatedBy]) VALUES (1, 1, 1, 1)
INSERT [dbo].[RoleMenu] ([Sysid], [RoleId], [MenuId], [CreatedBy]) VALUES (2, 2, 2, 1)
INSERT [dbo].[RoleMenu] ([Sysid], [RoleId], [MenuId], [CreatedBy]) VALUES (7, 3, 3, 1)
SET IDENTITY_INSERT [dbo].[RoleMenu] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (1, N'8081', N'Karim', N'Omidi', N'Omidi22', N'k_omidi@yahoo.com', N'0919222112', N'0018081', 3, N'No Photo', N'کریم امیدی', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (2, N'8082', N'Shadi', N'Ramezani', N'sh_R80', N'sh90@gmail.com', N'0912779372', N'0018082', 3, N'No Photo', N'شادی رمضانی', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (3, N'8083', N'Vida', N'Boshehri', N'v1392', N'v_boo2@yahoo.com', N'0912312342', N'0018083', 3, N'No Photo', N'ویدا بوشهری', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (4, N'8084', N'Reza', N'Ebrahimi', N'roomin1', N'abtahi.reza@gmail.com', N'0915628360', N'0018084', 3, N'No Photo', N'رضا ابراهیمی', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (5, N'8085', N'Soha', N'Noorani', N'soho', N's_nuri@gmail.com', N'0912880483', N'0018085', 3, N'No Photo', N'سها نورانی', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (6, N'8086', N'Matin', N'Mohammadi', N'mtn22', N'matin_mohammadi@yahoo.com', N'0935480332', N'0018086', 3, N'No Photo', N'متین محمدی', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (7, N'8087', N'Negar', N'Hajizadeh', N'Haj_Negar', N'negar_haji100@yahoo.com', N'0930133901', N'0018087', 3, N'No Photo', N'نگار حاجی زاده', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (8, N'8088', N'AmirAli', N'Yousefi', N'aay_n', N'aay_norman@gmail.com', N'0910233218', N'0018088', 3, N'No Photo', N'امیرعلی یوسفی', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (9, N'8089', N'Amin', N'Noor', N'aminlumier', N'noor_lum@gmail.com', N'0912374830', N'0018089', 3, N'No Photo', N'امین نور', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (10, N'8090', N'Gita', N'Shajare', N'gsha', N'g_shajare@gmail.com', N'0919237372', N'0018090', 3, N'No Photo', N'گیتا شحره', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (14, N'8091', N'Jale', N'Tabatabaie', N'taba_j', N'taba_jale@yahoo.com', N'0910283788', N'0018091', 3, N'No Photo', N'ژاله طباطبایی', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (15, N'8092', N'Sanaz', N'Afshar', N's_afshar', N'sa_af@yahoo.com', N'0912843212', N'0018092', 3, N'No Photo', N'ساناز افشار', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (16, N'8093', N'Soroush', N'Ebrahimi', N's_ebrahim', N'ebrahimi89@gmail.com', N'0919383730', N'0018093', 3, N'No Photo', N'سروش ابراهیمی', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (17, N'8094', N'Leila', N'Kosari', N'vi1993', N'leila_1993@gmail.com', N'0912736611', N'0018094', 3, N'No Photo', N'لیلا کوثری', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (18, N'8095', N'Ali', N'Rashti', N'r_ali', N'r_ali@gmail.com', N'0919830219', N'0018095', 3, N'No Photo', N'علی رشتی', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (19, N'8096', N'Fatima', N'Saeidi', N'f_saeidi', N'fa_saeidi@gmail.com', N'0915119273', N'0018096', 3, N'No Photo', N'فاطیما سعیدی', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (20, N'8097', N'Sepehr', N'Mollahoseini', N'mse23', N'sep_er_m@gmail.com', N'0919237372', N'0018097', 3, N'No Photo', N'سپهر ملاحسینی', 2)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (21, N'8098', N'Elham', N'Shirvanian', N'shirvanian', N'elham_sh@gmail.com', N'0935283872', N'0018098', 3, N'No Photo', N'الهام شیروانیان', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (22, N'8099', N'Sasan', N'Golfar', N'sasan891', N'Golfar.sasan@yahoo.com', N'0918277215', N'0018099', 3, N'No Photo', N'ساسان گلفر', 1)
INSERT [dbo].[Student] ([Sysid], [Id], [FirstName], [LastName], [UserName], [Email], [Phone], [Password], [Role], [Photo], [FullName], [CreatedBy]) VALUES (23, N'8100', N'Hoda', N'Jalali', N'Hoda200', N'jalali_h@gmail.com', N'0912554320', N'0018100', 3, N'No Photo', N'هدی جلالی', 2)
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Teach] ON 

INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (1, 1, 1)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (2, 1, 2)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (3, 2, 4)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (4, 2, 5)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (5, 2, 6)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (6, 2, 23)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (7, 2, 24)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (1027, 1, 37)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (1028, 2, 38)
INSERT [dbo].[Teach] ([Sysid], [TeacherID], [CourseID]) VALUES (1029, 2, 40)
SET IDENTITY_INSERT [dbo].[Teach] OFF
GO
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([Sysid], [Id], [FirstName], [LastName], [Email], [Role], [Photo], [Password], [FullName]) VALUES (1, N'4041', N'Ali Ahmadi', N'Ahmadi', N'ali_a@gmailc.om', 2, N'No Photo', N'0014041', N'علی احمدی')
INSERT [dbo].[Teacher] ([Sysid], [Id], [FirstName], [LastName], [Email], [Role], [Photo], [Password], [FullName]) VALUES (2, N'4042', N'Zahra', N'Mohebbi', N'z_moh1@yahoo.com', 2, N'No Photo', N'0014042', N'زهرا محبی')
SET IDENTITY_INSERT [dbo].[Teacher] OFF
GO
SET IDENTITY_INSERT [dbo].[Weekdays] ON 

INSERT [dbo].[Weekdays] ([Sysid], [DayName]) VALUES (1, N'شنبه')
INSERT [dbo].[Weekdays] ([Sysid], [DayName]) VALUES (2, N'یکشنبه')
INSERT [dbo].[Weekdays] ([Sysid], [DayName]) VALUES (3, N'دوشنبه')
INSERT [dbo].[Weekdays] ([Sysid], [DayName]) VALUES (4, N'سه شنبه')
INSERT [dbo].[Weekdays] ([Sysid], [DayName]) VALUES (5, N'چهارشنبه')
SET IDENTITY_INSERT [dbo].[Weekdays] OFF
GO
/****** Object:  Index [NonClusteredIndex-20221108-135901]    Script Date: 22/11/13 6:04:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20221108-135901] ON [dbo].[Course]
(
	[Name] ASC,
	[CreatedBy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-20221108-141932]    Script Date: 22/11/13 6:04:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20221108-141932] ON [dbo].[Course]
(
	[CreatedBy] ASC,
	[Day] ASC,
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-20221102-233123]    Script Date: 22/11/13 6:04:20 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20221102-233123] ON [dbo].[Invitation]
(
	[Teacher_ID] ASC,
	[Course_ID] ASC,
	[Student_ID] ASC,
	[Invite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Invitation] ADD  CONSTRAINT [DF_Invitation_Invite]  DEFAULT ((0)) FOR [Invite]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([Sysid])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([Sysid])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Student]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Teacher] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([Sysid])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Teacher]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Hours] FOREIGN KEY([Time])
REFERENCES [dbo].[Hours] ([Sysid])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Hours]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_NameOfCourse] FOREIGN KEY([Name])
REFERENCES [dbo].[NameOfCourse] ([Sysid])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_NameOfCourse]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Weekdays] FOREIGN KEY([Day])
REFERENCES [dbo].[Weekdays] ([Sysid])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Weekdays]
GO
ALTER TABLE [dbo].[Invitation]  WITH CHECK ADD  CONSTRAINT [FK_Invitation_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Sysid])
GO
ALTER TABLE [dbo].[Invitation] CHECK CONSTRAINT [FK_Invitation_Course]
GO
ALTER TABLE [dbo].[Invitation]  WITH CHECK ADD  CONSTRAINT [FK_Invitation_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Sysid])
GO
ALTER TABLE [dbo].[Invitation] CHECK CONSTRAINT [FK_Invitation_Student]
GO
ALTER TABLE [dbo].[Invitation]  WITH CHECK ADD  CONSTRAINT [FK_Invitation_Teacher] FOREIGN KEY([Teacher_ID])
REFERENCES [dbo].[Teacher] ([Sysid])
GO
ALTER TABLE [dbo].[Invitation] CHECK CONSTRAINT [FK_Invitation_Teacher]
GO
ALTER TABLE [dbo].[RoleMenu]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenu_MenuItem] FOREIGN KEY([MenuId])
REFERENCES [dbo].[MenuItem] ([Sysid])
GO
ALTER TABLE [dbo].[RoleMenu] CHECK CONSTRAINT [FK_RoleMenu_MenuItem]
GO
ALTER TABLE [dbo].[RoleMenu]  WITH CHECK ADD  CONSTRAINT [FK_RoleMenu_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Sysid])
GO
ALTER TABLE [dbo].[RoleMenu] CHECK CONSTRAINT [FK_RoleMenu_Role]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([Sysid])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Role]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Teacher] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Teacher] ([Sysid])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Teacher]
GO
ALTER TABLE [dbo].[Teach]  WITH CHECK ADD  CONSTRAINT [FK_Teach_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([Sysid])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Teach] CHECK CONSTRAINT [FK_Teach_Course]
GO
ALTER TABLE [dbo].[Teach]  WITH CHECK ADD  CONSTRAINT [FK_Teach_Teacher] FOREIGN KEY([TeacherID])
REFERENCES [dbo].[Teacher] ([Sysid])
GO
ALTER TABLE [dbo].[Teach] CHECK CONSTRAINT [FK_Teach_Teacher]
GO
ALTER TABLE [dbo].[Teacher]  WITH CHECK ADD  CONSTRAINT [FK_Teacher_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([Sysid])
GO
ALTER TABLE [dbo].[Teacher] CHECK CONSTRAINT [FK_Teacher_Role]
GO
USE [master]
GO
ALTER DATABASE [SMS] SET  READ_WRITE 
GO
