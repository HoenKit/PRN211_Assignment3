USE [master]
GO
/****** Object:  Database [PRN211_Assignment3]    Script Date: 3/18/2024 9:00:39 PM ******/
CREATE DATABASE [PRN211_Assignment3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PRN211_Assignment3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.HOANG\MSSQL\DATA\PRN211_Assignment3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PRN211_Assignment3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.HOANG\MSSQL\DATA\PRN211_Assignment3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PRN211_Assignment3] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PRN211_Assignment3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PRN211_Assignment3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET ARITHABORT OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PRN211_Assignment3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PRN211_Assignment3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PRN211_Assignment3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PRN211_Assignment3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET RECOVERY FULL 
GO
ALTER DATABASE [PRN211_Assignment3] SET  MULTI_USER 
GO
ALTER DATABASE [PRN211_Assignment3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PRN211_Assignment3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PRN211_Assignment3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PRN211_Assignment3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PRN211_Assignment3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PRN211_Assignment3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PRN211_Assignment3', N'ON'
GO
ALTER DATABASE [PRN211_Assignment3] SET QUERY_STORE = ON
GO
ALTER DATABASE [PRN211_Assignment3] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PRN211_Assignment3]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 3/18/2024 9:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](100) NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 3/18/2024 9:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[UnitStock] [int] NULL,
	[UnitPrice] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/18/2024 9:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [date] NULL,
	[UserId] [int] NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/18/2024 9:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](100) NULL,
	[CategoryId] [int] NULL,
	[UnitStock] [int] NULL,
	[UnitPrice] [decimal](10, 2) NULL,
	[Date] [date] NULL,
	[Images] [varchar](255) NULL,
	[Status] [int] NULL,
	[UserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetail]    Script Date: 3/18/2024 9:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetail](
	[UserDetailId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[DateBirth] [date] NULL,
	[Address] [varchar](255) NULL,
	[Email] [varchar](100) NULL,
	[Phone] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 3/18/2024 9:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/18/2024 9:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](100) NULL,
	[Status] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (1, N'Gold', 0)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [Status]) VALUES (2, N'Silver', 0)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderDetailId], [OrderId], [ProductId], [UnitStock], [UnitPrice]) VALUES (1, 1, 1, 1, CAST(1000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [OrderDate], [UserId], [Status]) VALUES (1, CAST(N'2024-03-18' AS Date), 2, 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [UnitStock], [UnitPrice], [Date], [Images], [Status], [UserId]) VALUES (1, N'Apple Watch', 2, 100, CAST(1000.00 AS Decimal(10, 2)), CAST(N'2024-03-29' AS Date), N'png', 0, 2)
INSERT [dbo].[Products] ([ProductId], [ProductName], [CategoryId], [UnitStock], [UnitPrice], [Date], [Images], [Status], [UserId]) VALUES (2, N'Rolex', 1, 10, CAST(5000.00 AS Decimal(10, 2)), CAST(N'2024-03-18' AS Date), N'png', 0, 2)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[UserDetail] ON 

INSERT [dbo].[UserDetail] ([UserDetailId], [UserId], [Name], [DateBirth], [Address], [Email], [Phone]) VALUES (1, 2, N'Nguyen Thanh Hoang', CAST(N'2003-12-09' AS Date), N'Da Nang', N'hoang@gmail.com', N'0905967455')
SET IDENTITY_INSERT [dbo].[UserDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoles] ON 

INSERT [dbo].[UserRoles] ([RoleId], [Name], [Status]) VALUES (1, N'Admin', 0)
INSERT [dbo].[UserRoles] ([RoleId], [Name], [Status]) VALUES (2, N'User', 0)
SET IDENTITY_INSERT [dbo].[UserRoles] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [RoleId], [UserName], [Password], [Status]) VALUES (1, 1, N'Admin', N'123', 0)
INSERT [dbo].[Users] ([UserId], [RoleId], [UserName], [Password], [Status]) VALUES (2, 2, N'hoang', N'123', 0)
INSERT [dbo].[Users] ([UserId], [RoleId], [UserName], [Password], [Status]) VALUES (4, 2, N'binh', N'123', 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Orders]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Users]
GO
ALTER TABLE [dbo].[UserDetail]  WITH CHECK ADD  CONSTRAINT [FK_UserDetail_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserDetail] CHECK CONSTRAINT [FK_UserDetail_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[UserRoles] ([RoleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserRoles]
GO
USE [master]
GO
ALTER DATABASE [PRN211_Assignment3] SET  READ_WRITE 
GO
