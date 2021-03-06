USE [master]
GO
/****** Object:  Database [Proyecto]    Script Date: 18/07/2018 10:23:38 a. m. ******/
CREATE DATABASE [Proyecto]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Proyecto', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Proyecto1.mdf' , SIZE = 5184KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Proyecto_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Proyecto1_log.ldf' , SIZE = 4736KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Proyecto] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Proyecto].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Proyecto] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Proyecto] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Proyecto] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Proyecto] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Proyecto] SET ARITHABORT OFF 
GO
ALTER DATABASE [Proyecto] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Proyecto] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Proyecto] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Proyecto] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Proyecto] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Proyecto] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Proyecto] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Proyecto] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Proyecto] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Proyecto] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Proyecto] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Proyecto] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Proyecto] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Proyecto] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Proyecto] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Proyecto] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Proyecto] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Proyecto] SET RECOVERY FULL 
GO
ALTER DATABASE [Proyecto] SET  MULTI_USER 
GO
ALTER DATABASE [Proyecto] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Proyecto] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Proyecto] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Proyecto] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Proyecto] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Proyecto] SET QUERY_STORE = OFF
GO
USE [Proyecto]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Proyecto]
GO
/****** Object:  Table [dbo].[Inspeccion]    Script Date: 18/07/2018 10:23:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inspeccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Inspector] [int] NULL,
	[Interno] [numeric](18, 0) NULL,
	[Fecha] [datetime] NULL,
	[Seccion] [int] NULL,
 CONSTRAINT [PK_Inspeccion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seccion_Horario]    Script Date: 18/07/2018 10:23:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seccion_Horario](
	[Seccion] [int] NOT NULL,
	[Recorrido] [int] NOT NULL,
	[Frecuencia] [int] NOT NULL,
	[Hora] [time](7) NULL,
 CONSTRAINT [PK_Seccion_Horario] PRIMARY KEY CLUSTERED 
(
	[Seccion] ASC,
	[Recorrido] ASC,
	[Frecuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Frecuencia]    Script Date: 18/07/2018 10:23:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Frecuencia](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](150) NULL,
	[HorarioInicial] [time](7) NULL,
 CONSTRAINT [PK_Frecuencia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conductor]    Script Date: 18/07/2018 10:23:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conductor](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Dni] [int] NULL,
	[Legajo] [int] NULL,
	[CodInspector] [int] NULL,
	[Baja] [datetime] NULL,
 CONSTRAINT [PK_Conductor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conductor_Recorrido_Frecuencia]    Script Date: 18/07/2018 10:23:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conductor_Recorrido_Frecuencia](
	[Conductor] [numeric](18, 0) NOT NULL,
	[Recorrido] [int] NOT NULL,
	[Frecuencia] [int] NOT NULL,
 CONSTRAINT [PK_Conductor_Recorrido_Frecuencia] PRIMARY KEY CLUSTERED 
(
	[Conductor] ASC,
	[Recorrido] ASC,
	[Frecuencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interno_Conductor]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interno_Conductor](
	[Interno] [numeric](18, 0) NOT NULL,
	[Conductor] [numeric](18, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_Interno_Conductor] PRIMARY KEY CLUSTERED 
(
	[Interno] ASC,
	[Conductor] ASC,
	[Fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seccion]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](150) NULL,
	[direccion] [varchar](500) NULL,
	[nota] [varchar](500) NULL,
	[fechaBaja] [datetime] NULL,
	[CodParada] [int] NULL,
	[CodInspector] [int] NULL,
	[Latitud] [decimal](9, 6) NULL,
	[Longitud] [decimal](9, 6) NULL,
 CONSTRAINT [PK_Seccion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inspector]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inspector](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](150) NULL,
	[dni] [numeric](18, 0) NULL,
	[legajo] [numeric](18, 0) NULL,
	[FechaCarga] [datetime] NULL,
	[FechaBaja] [datetime] NULL,
 CONSTRAINT [PK_Inspector] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Control_Inspecciones]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vw_Control_Inspecciones]
as

select distinct  [id]
      ,[Inspector_id]
      ,[Inspector_Nombre]
      ,[Interno]
      ,[Conductor_Id]
      ,[Conductor_Nombre]
      ,[Fecha]
      ,[Seccion_Id]
      ,[Seccion_Nombre]
      ,[hora_Inspeccion]
      ,[hora_Seccion]
,DATEDIFF(minute,hora_seccion,hora_inspeccion) DifMinutos
,CASE when DATEDIFF(minute,hora_seccion,hora_inspeccion)>5 then 'SI' else 'NO' end Atrasado
,CASE when DATEDIFF(minute,hora_seccion,hora_inspeccion)<-2 then 'SI' else 'NO' end Adelanto


 from (

SELECT        i.id, i.Inspector Inspector_id,inspector.nombre Inspector_Nombre, i.Interno,c.id as Conductor_Id,c.Nombre Conductor_Nombre, i.Fecha, i.Seccion Seccion_Id, s.nombre Seccion_Nombre,convert(time,i.Fecha) hora_Inspeccion, --cfr.Conductor, cfr.Frecuencia,cfr.Recorrido ,

	(SELECT top 1 hora
	FROM dbo.Frecuencia INNER JOIN
	dbo.Seccion_Horario ON dbo.Frecuencia.Id = dbo.Seccion_Horario.Frecuencia INNER JOIN
	dbo.Seccion ON dbo.Seccion_Horario.Seccion = dbo.Seccion.id						 
	where cfr.recorrido=seccion_horario.recorrido 
	and i.seccion=seccion.id						
	and cfr.frecuencia=seccion_horario.frecuencia						 
	order by  DATEDIFF(second,0,cast(convert(time,i.Fecha) as datetime)) -DATEDIFF(second,0,cast(seccion_horario.hora as datetime))  asc

						 ) hora_Seccion
FROM            dbo.Conductor_Recorrido_Frecuencia  cfr INNER JOIN
				Interno_Conductor ic on ic.Conductor=cfr.Conductor
				inner join  Inspeccion i ON ic.interno= i.Interno
				and convert(date,i.Fecha)=convert(date,ic.Fecha)
				inner join Conductor c on cfr.conductor=c.id
				inner join Seccion s on s.id=i.Seccion
				inner join Inspector on Inspector.id=i.Inspector
				where c.baja is null
				and inspector.fechabaja is null
				) as a
GO
/****** Object:  View [dbo].[vw_Inspeccion]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_Inspeccion]
as
select   distinct    dbo.Inspeccion.id,inspeccion.interno,c.id Conductor_id,c.Nombre Conductor_Nombre, dbo.Inspector.id AS Inspector_id, dbo.Inspector.nombre AS Inspector_Nombre, dbo.Inspeccion.Fecha, dbo.Seccion.id AS Seccion_Id, dbo.Seccion.nombre AS Seccion_Nombre
FROM            dbo.Inspeccion INNER JOIN
                         dbo.Inspector ON dbo.Inspeccion.Inspector = dbo.Inspector.id INNER JOIN
                         dbo.Seccion ON dbo.Inspeccion.Seccion = dbo.Seccion.id
left join interno_conductor ic on inspeccion.interno=ic.interno 
and convert(date,Inspeccion.Fecha)=convert(date,ic.Fecha)
left join conductor c on c.id=ic.conductor
where c.baja is null
				and inspector.fechabaja is null
GO
/****** Object:  Table [dbo].[Observacion]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Observacion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](max) NULL,
	[fecha] [datetime] NULL,
	[inspector] [int] NULL,
	[seccion] [int] NULL,
	[interno] [numeric](18, 0) NOT NULL,
	[patente] [varchar](50) NULL,
	[CodInspector] [int] NULL,
 CONSTRAINT [PK_Observacion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Interno]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Interno](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Modelo] [varchar](150) NULL,
	[Marca] [varchar](150) NULL,
	[Patente] [varchar](50) NULL,
	[Año] [smallint] NULL,
	[CantidadPasajeros] [int] NULL,
	[Activo] [nchar](2) NOT NULL,
 CONSTRAINT [PK_Interno] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Observacion]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vw_Observacion]
as
select distinct    dbo.Observacion.id, dbo.Observacion.Descripcion, dbo.Observacion.fecha, dbo.Inspector.id AS Inspector_id, dbo.Inspector.nombre AS Inspector_Nombre, dbo.Seccion.id AS Seccion_Id, dbo.Seccion.nombre AS Seccion_Nombre, 
                         dbo.Observacion.interno AS Interno_id, dbo.Interno.Patente AS Interno_Patente
						 ,Conductor.id Conductor_id ,Conductor.Nombre Conductor_Nombre
FROM            dbo.Observacion INNER JOIN
                         dbo.Interno ON dbo.Observacion.interno = dbo.Interno.id 
						 left  join interno_conductor on interno.id=interno_conductor.interno
						 and convert(date,Observacion.fecha)=convert(date,interno_conductor.fecha) left join
						 
                         dbo.Inspector ON dbo.Observacion.inspector = dbo.Inspector.id left JOIN
                         dbo.Seccion ON dbo.Observacion.seccion = dbo.Seccion.id
						 left join conductor on interno_conductor.conductor=conductor.id
where conductor.baja is null
				and inspector.fechabaja is null
				and interno.activo='SI'
GO
/****** Object:  Table [dbo].[logs]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[tipo] [int] NULL,
	[descripcion] [nvarchar](4000) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[logs_tipo]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[logs_tipo](
	[id] [int] NOT NULL,
	[descripcion] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parada]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parada](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](150) NULL,
	[direccion] [varchar](500) NULL,
	[nota] [varchar](500) NULL,
	[CodInspector] [int] NULL,
 CONSTRAINT [PK_Parada] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recorrido]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recorrido](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Recorrido] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 18/07/2018 10:23:39 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[NombreUsuario] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Rol] [char](1) NULL,
	[RolId] [numeric](18, 0) NULL,
	[fechabaja] [date] NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Conductor] ON 

INSERT [dbo].[Conductor] ([id], [Nombre], [Dni], [Legajo], [CodInspector], [Baja]) VALUES (CAST(2 AS Numeric(18, 0)), N'Sebastian Caceres', 30983000, 12, 3, NULL)
INSERT [dbo].[Conductor] ([id], [Nombre], [Dni], [Legajo], [CodInspector], [Baja]) VALUES (CAST(123 AS Numeric(18, 0)), N'Juan Gabriel', 30983000, 4564, NULL, NULL)
INSERT [dbo].[Conductor] ([id], [Nombre], [Dni], [Legajo], [CodInspector], [Baja]) VALUES (CAST(124 AS Numeric(18, 0)), N'eluney', 50309830, 78, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Conductor] OFF
INSERT [dbo].[Conductor_Recorrido_Frecuencia] ([Conductor], [Recorrido], [Frecuencia]) VALUES (CAST(2 AS Numeric(18, 0)), 1, 1)
INSERT [dbo].[Conductor_Recorrido_Frecuencia] ([Conductor], [Recorrido], [Frecuencia]) VALUES (CAST(2 AS Numeric(18, 0)), 1, 2)
INSERT [dbo].[Conductor_Recorrido_Frecuencia] ([Conductor], [Recorrido], [Frecuencia]) VALUES (CAST(123 AS Numeric(18, 0)), 1, 2)
SET IDENTITY_INSERT [dbo].[Frecuencia] ON 

INSERT [dbo].[Frecuencia] ([Id], [Descripcion], [HorarioInicial]) VALUES (1, N'Frecuencia 8 30', CAST(N'08:30:00' AS Time))
INSERT [dbo].[Frecuencia] ([Id], [Descripcion], [HorarioInicial]) VALUES (2, N'Frecuencia 9:00', CAST(N'09:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[Frecuencia] OFF
SET IDENTITY_INSERT [dbo].[Inspeccion] ON 

INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (1, 6, CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-24T18:05:51.087' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (2, 6, CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-24T18:29:10.900' AS DateTime), 1017)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (3, 6, CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-24T18:50:32.737' AS DateTime), 1018)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (4, 6, CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-24T01:54:43.177' AS DateTime), 1019)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (18, 6, CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-04T11:15:57.813' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (21, 6, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-04T20:13:38.057' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (25, 6, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-04T20:34:26.340' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (26, 6, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-04T20:40:00.940' AS DateTime), 1019)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (27, 6, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-04T20:40:10.597' AS DateTime), 1019)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (30, 6, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-11T19:56:23.913' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (33, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-11T23:50:41.073' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (34, 6, CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-14T15:26:31.087' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (36, 7, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T15:28:23.897' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (37, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T15:30:46.470' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (38, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T15:30:56.143' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (39, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T15:31:12.767' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (40, 7, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T15:54:15.667' AS DateTime), 1017)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (41, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T15:56:52.210' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (42, 7, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T15:58:10.150' AS DateTime), 1017)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (44, 3, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T16:06:16.050' AS DateTime), 1019)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (45, 6, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T16:08:02.007' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (47, 3, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T16:11:27.977' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (48, 6, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-17T22:58:44.173' AS DateTime), 1016)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (49, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-18T09:29:05.173' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (50, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-18T09:31:05.257' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (51, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-18T09:31:12.150' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (52, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-18T09:31:14.367' AS DateTime), 1030)
INSERT [dbo].[Inspeccion] ([id], [Inspector], [Interno], [Fecha], [Seccion]) VALUES (53, 9, CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-18T09:31:22.827' AS DateTime), 1030)
SET IDENTITY_INSERT [dbo].[Inspeccion] OFF
SET IDENTITY_INSERT [dbo].[Inspector] ON 

INSERT [dbo].[Inspector] ([id], [nombre], [dni], [legajo], [FechaCarga], [FechaBaja]) VALUES (3, N'Brian Kuz', CAST(33397855 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-22T12:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Inspector] ([id], [nombre], [dni], [legajo], [FechaCarga], [FechaBaja]) VALUES (6, N'Matias Albornoz', CAST(30983000 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-22T12:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Inspector] ([id], [nombre], [dni], [legajo], [FechaCarga], [FechaBaja]) VALUES (7, N'Romina Orieta', CAST(35347612 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-22T12:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Inspector] ([id], [nombre], [dni], [legajo], [FechaCarga], [FechaBaja]) VALUES (8, N'Roman Roldan', CAST(29900872 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-22T12:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Inspector] ([id], [nombre], [dni], [legajo], [FechaCarga], [FechaBaja]) VALUES (9, N'IV Laferrere', CAST(585858 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-22T12:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Inspector] ([id], [nombre], [dni], [legajo], [FechaCarga], [FechaBaja]) VALUES (10, N'Jose', CAST(30983000 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-18T09:49:10.840' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Inspector] OFF
SET IDENTITY_INSERT [dbo].[Interno] ON 

INSERT [dbo].[Interno] ([id], [Modelo], [Marca], [Patente], [Año], [CantidadPasajeros], [Activo]) VALUES (CAST(2 AS Numeric(18, 0)), N'AA-132-AB', N'RENAULT', N'AA-132-AB', 1990, 30, N'SI')
INSERT [dbo].[Interno] ([id], [Modelo], [Marca], [Patente], [Año], [CantidadPasajeros], [Activo]) VALUES (CAST(123 AS Numeric(18, 0)), N'AA-134-AB', N'RENAULT', N'AA-132-AB', 1990, 30, N'SI')
SET IDENTITY_INSERT [dbo].[Interno] OFF
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-10T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-13T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-22T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-24T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-24T18:05:51.087' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-06-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-10T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-13T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-22T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-24T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-28T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-07-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-10T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-22T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-24T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-28T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-08-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(2 AS Numeric(18, 0)), CAST(2 AS Numeric(18, 0)), CAST(N'2018-09-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2017-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-10T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-13T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-22T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-24T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-06-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-04T20:13:38.057' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-10T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-13T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-22T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-24T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-28T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-07-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-08T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-10T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-11T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-13T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-15T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-21T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-22T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-23T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-24T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-28T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-30T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-08-31T00:00:00.000' AS DateTime))
INSERT [dbo].[Interno_Conductor] ([Interno], [Conductor], [Fecha]) VALUES (CAST(123 AS Numeric(18, 0)), CAST(123 AS Numeric(18, 0)), CAST(N'2018-09-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[logs] ON 

INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (55, CAST(N'2018-06-23T13:52:36.057' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (56, CAST(N'2018-06-23T13:53:02.327' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (57, CAST(N'2018-06-23T14:09:11.670' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (58, CAST(N'2018-06-23T14:09:55.963' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (59, CAST(N'2018-06-23T14:33:34.297' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (60, CAST(N'2018-06-23T14:34:30.217' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (61, CAST(N'2018-06-23T14:35:27.353' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (62, CAST(N'2018-06-23T14:38:15.830' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (63, CAST(N'2018-06-23T14:59:39.700' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (64, CAST(N'2018-06-23T15:01:03.937' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (65, CAST(N'2018-06-23T15:03:11.233' AS DateTime), 0, N'validar(12989432,1)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (66, CAST(N'2018-06-24T00:10:25.493' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (67, CAST(N'2018-06-24T00:10:57.067' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (68, CAST(N'2018-06-24T00:11:07.907' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (69, CAST(N'2018-06-24T01:02:26.043' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (70, CAST(N'2018-06-24T01:08:17.507' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (71, CAST(N'2018-06-24T01:14:58.160' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (72, CAST(N'2018-06-24T01:17:19.037' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (73, CAST(N'2018-06-24T01:19:25.803' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (74, CAST(N'2018-06-24T01:20:57.637' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (75, CAST(N'2018-06-24T01:25:52.677' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (76, CAST(N'2018-06-24T01:26:36.163' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (77, CAST(N'2018-06-24T01:28:36.003' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (78, CAST(N'2018-06-24T01:29:24.220' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (79, CAST(N'2018-06-24T01:35:41.313' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (80, CAST(N'2018-06-24T01:43:45.203' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (81, CAST(N'2018-06-24T01:57:05.860' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (82, CAST(N'2018-06-24T01:59:17.333' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (83, CAST(N'2018-06-24T02:03:03.347' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (84, CAST(N'2018-06-24T02:21:43.680' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (85, CAST(N'2018-06-24T02:21:43.837' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (86, CAST(N'2018-06-24T02:21:54.867' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (87, CAST(N'2018-06-24T02:21:54.887' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (88, CAST(N'2018-06-24T02:23:19.787' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (89, CAST(N'2018-06-24T02:23:19.817' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (90, CAST(N'2018-06-24T02:29:20.393' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (91, CAST(N'2018-06-24T02:29:20.413' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (92, CAST(N'2018-06-24T02:53:46.750' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (93, CAST(N'2018-06-24T02:53:46.780' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (94, CAST(N'2018-06-24T03:04:06.193' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (95, CAST(N'2018-06-27T06:48:49.947' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (96, CAST(N'2018-06-27T06:51:36.820' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (97, CAST(N'2018-06-27T06:53:41.827' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (98, CAST(N'2018-06-27T06:58:28.960' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (99, CAST(N'2018-06-27T06:59:16.817' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (100, CAST(N'2018-06-27T06:59:17.997' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (101, CAST(N'2018-06-27T07:16:10.717' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (102, CAST(N'2018-06-27T07:16:12.773' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (103, CAST(N'2018-06-27T07:23:31.273' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (104, CAST(N'2018-06-27T07:57:39.573' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (105, CAST(N'2018-06-27T07:57:45.627' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (106, CAST(N'2018-06-27T07:58:12.737' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (107, CAST(N'2018-06-27T08:01:43.150' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (108, CAST(N'2018-06-27T08:01:43.207' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (109, CAST(N'2018-06-27T08:01:45.233' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (110, CAST(N'2018-06-27T08:01:45.253' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (111, CAST(N'2018-06-27T08:01:47.277' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (112, CAST(N'2018-06-27T08:01:47.297' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (113, CAST(N'2018-06-27T08:01:49.377' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (114, CAST(N'2018-06-27T08:01:49.400' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (115, CAST(N'2018-06-27T08:01:51.480' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (116, CAST(N'2018-06-27T08:01:51.503' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (117, CAST(N'2018-06-27T08:01:53.487' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (118, CAST(N'2018-06-27T08:01:53.503' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (119, CAST(N'2018-06-27T08:01:55.530' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (120, CAST(N'2018-06-27T08:01:55.557' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (121, CAST(N'2018-06-27T08:02:36.807' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (122, CAST(N'2018-06-27T08:02:42.400' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (123, CAST(N'2018-06-27T08:02:44.460' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (124, CAST(N'2018-06-27T08:02:46.497' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (125, CAST(N'2018-06-27T08:02:48.573' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (126, CAST(N'2018-06-27T08:02:50.677' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (127, CAST(N'2018-06-27T08:02:52.677' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (128, CAST(N'2018-06-27T08:02:54.773' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (129, CAST(N'2018-06-27T08:02:56.853' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (130, CAST(N'2018-06-27T08:15:30.683' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (131, CAST(N'2018-06-27T08:16:20.870' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (132, CAST(N'2018-06-27T08:16:34.467' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (133, CAST(N'2018-06-27T08:17:28.227' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (134, CAST(N'2018-06-27T08:25:46.257' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (135, CAST(N'2018-06-27T08:26:46.990' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (136, CAST(N'2018-06-27T20:24:40.303' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (137, CAST(N'2018-06-27T20:48:14.957' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (138, CAST(N'2018-06-27T21:52:39.677' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (139, CAST(N'2018-06-27T21:58:41.283' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (140, CAST(N'2018-06-27T21:58:42.607' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (141, CAST(N'2018-06-27T21:59:06.617' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (142, CAST(N'2018-06-27T21:59:26.553' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (143, CAST(N'2018-06-28T05:40:11.530' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (144, CAST(N'2018-06-28T05:40:13.540' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (145, CAST(N'2018-06-28T05:40:15.567' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (146, CAST(N'2018-06-28T05:40:17.573' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (147, CAST(N'2018-06-28T05:40:19.573' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (148, CAST(N'2018-06-28T05:48:31.240' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (149, CAST(N'2018-06-28T05:48:35.807' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (150, CAST(N'2018-06-28T05:48:36.937' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (151, CAST(N'2018-06-28T05:48:38.117' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (152, CAST(N'2018-06-28T05:48:39.177' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (153, CAST(N'2018-06-28T05:48:40.323' AS DateTime), 0, N'validar(30983000,123)')
GO
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (154, CAST(N'2018-06-28T05:48:41.403' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (155, CAST(N'2018-06-28T05:48:42.523' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (156, CAST(N'2018-06-28T05:48:43.647' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (157, CAST(N'2018-06-28T05:48:44.803' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (158, CAST(N'2018-06-28T05:51:15.490' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (159, CAST(N'2018-06-28T05:51:45.043' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (160, CAST(N'2018-06-28T05:55:43.237' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (161, CAST(N'2018-06-28T06:31:51.093' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (162, CAST(N'2018-06-28T06:31:52.383' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (163, CAST(N'2018-06-28T06:38:41.457' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (164, CAST(N'2018-06-28T07:04:44.170' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (165, CAST(N'2018-06-28T07:09:27.417' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (166, CAST(N'2018-06-28T07:14:51.597' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (167, CAST(N'2018-06-28T07:23:15.463' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (168, CAST(N'2018-06-28T07:23:16.597' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (169, CAST(N'2018-06-28T07:26:58.883' AS DateTime), 0, N'validar(,)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (170, CAST(N'2018-06-28T07:26:58.977' AS DateTime), 1, N'Error: La cadena de entrada no tiene el formato correcto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (171, CAST(N'2018-06-29T16:48:31.463' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (172, CAST(N'2018-06-29T16:48:35.927' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (173, CAST(N'2018-06-29T16:48:37.890' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (174, CAST(N'2018-06-29T16:48:39.890' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (175, CAST(N'2018-06-29T16:48:41.893' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (176, CAST(N'2018-06-29T16:48:43.887' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (177, CAST(N'2018-06-29T16:48:45.877' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (178, CAST(N'2018-06-29T16:48:47.910' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (179, CAST(N'2018-06-29T16:48:49.950' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (180, CAST(N'2018-06-29T16:49:27.083' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (181, CAST(N'2018-06-29T16:49:29.047' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (182, CAST(N'2018-06-29T16:58:09.917' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (183, CAST(N'2018-06-29T16:58:11.100' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (184, CAST(N'2018-06-29T17:20:45.167' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (185, CAST(N'2018-06-29T17:21:26.730' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (186, CAST(N'2018-06-29T17:21:27.890' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (187, CAST(N'2018-07-03T13:19:04.610' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (188, CAST(N'2018-07-03T13:20:20.987' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (189, CAST(N'2018-07-04T07:03:52.547' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (190, CAST(N'2018-07-04T09:38:06.353' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (191, CAST(N'2018-07-04T10:46:22.893' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (192, CAST(N'2018-07-04T10:46:41.417' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (193, CAST(N'2018-07-04T10:47:13.647' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (194, CAST(N'2018-07-04T10:48:39.997' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (195, CAST(N'2018-07-04T10:49:06.387' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (196, CAST(N'2018-07-04T11:05:48.677' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (197, CAST(N'2018-07-04T11:13:53.563' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (198, CAST(N'2018-07-04T11:15:34.327' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (199, CAST(N'2018-07-04T11:25:37.777' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (200, CAST(N'2018-07-04T11:26:22.280' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (201, CAST(N'2018-07-04T19:48:20.390' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (202, CAST(N'2018-07-04T19:48:20.537' AS DateTime), 1, N'Error: Ya se agregó un elemento con la misma clave.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (203, CAST(N'2018-07-04T20:01:22.203' AS DateTime), 1, N'Error: Referencia a objeto no establecida como instancia de un objeto.')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (204, CAST(N'2018-07-04T20:01:29.167' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (205, CAST(N'2018-07-04T20:02:03.997' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (206, CAST(N'2018-07-04T20:04:45.933' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (207, CAST(N'2018-07-04T20:20:30.993' AS DateTime), 0, N'validar(585858,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (208, CAST(N'2018-07-04T20:23:51.507' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (209, CAST(N'2018-07-04T20:24:53.057' AS DateTime), 0, N'validar(585858,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (210, CAST(N'2018-07-04T20:35:02.077' AS DateTime), 0, N'validar(30983000,123)')
INSERT [dbo].[logs] ([id], [fecha], [tipo], [descripcion]) VALUES (211, CAST(N'2018-07-04T20:35:50.933' AS DateTime), 0, N'validar(30983000,123)')
SET IDENTITY_INSERT [dbo].[logs] OFF
INSERT [dbo].[logs_tipo] ([id], [descripcion]) VALUES (0, N'info')
INSERT [dbo].[logs_tipo] ([id], [descripcion]) VALUES (1, N'error')
INSERT [dbo].[logs_tipo] ([id], [descripcion]) VALUES (2, N'warning')
SET IDENTITY_INSERT [dbo].[Observacion] ON 

INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (1, N'asasas123', CAST(N'2018-07-04T20:13:38.057' AS DateTime), 6, 1016, CAST(123 AS Numeric(18, 0)), N'aaa123', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (2, N'as123as', CAST(N'2018-07-04T20:13:38.057' AS DateTime), 6, 1019, CAST(123 AS Numeric(18, 0)), N'aa', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (3, N'Tarde
', CAST(N'2018-06-24T18:05:51.087' AS DateTime), 6, 1017, CAST(2 AS Numeric(18, 0)), N'Mvz480', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (4, N'No se detuvo al momento de la firma', CAST(N'2018-06-24T18:05:51.087' AS DateTime), 6, 1019, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (5, N'Noooooooo', CAST(N'2018-06-24T18:05:51.087' AS DateTime), 6, 1019, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (6, N'2', CAST(N'2018-07-11T22:50:42.870' AS DateTime), 6, 1016, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (7, N'2', CAST(N'2018-07-11T22:52:10.517' AS DateTime), 6, 1016, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (8, N'4', CAST(N'2018-07-11T23:19:31.247' AS DateTime), 6, 1016, CAST(4 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (9, N'2', CAST(N'2018-07-11T23:20:03.940' AS DateTime), 6, 1016, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (10, N'5', CAST(N'2018-07-11T23:20:36.667' AS DateTime), 6, 1016, CAST(5 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (11, N'1', CAST(N'2018-07-11T23:28:29.580' AS DateTime), 6, 1016, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (12, N'3', CAST(N'2018-07-11T23:33:07.677' AS DateTime), 6, 1016, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (13, N'Hola', CAST(N'2018-07-14T15:25:51.457' AS DateTime), 7, 1018, CAST(123 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (14, N'Se', CAST(N'2018-07-14T16:01:13.367' AS DateTime), 3, 1016, CAST(123 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (15, N'Hols', CAST(N'2018-07-14T16:17:29.890' AS DateTime), 7, 1017, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (16, N'El colectivo no paro en ramos mejia', CAST(N'2018-07-14T16:18:00.270' AS DateTime), 3, 1016, CAST(123 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (17, N'Nunca paro se fue corriendo', CAST(N'2018-07-14T16:18:05.183' AS DateTime), 6, 1019, CAST(2 AS Numeric(18, 0)), N'', NULL)
INSERT [dbo].[Observacion] ([id], [Descripcion], [fecha], [inspector], [seccion], [interno], [patente], [CodInspector]) VALUES (18, N'Tg', CAST(N'2018-07-17T22:59:07.460' AS DateTime), 6, 1016, CAST(123 AS Numeric(18, 0)), N'', NULL)
SET IDENTITY_INSERT [dbo].[Observacion] OFF
SET IDENTITY_INSERT [dbo].[Parada] ON 

INSERT [dbo].[Parada] ([id], [nombre], [direccion], [nota], [CodInspector]) VALUES (2, N'Ramos Mejia', N'121', N'31', NULL)
INSERT [dbo].[Parada] ([id], [nombre], [direccion], [nota], [CodInspector]) VALUES (3, N'Paso Del Rey', N'Moron 224', N'34', NULL)
SET IDENTITY_INSERT [dbo].[Parada] OFF
SET IDENTITY_INSERT [dbo].[Recorrido] ON 

INSERT [dbo].[Recorrido] ([Id], [Descripcion]) VALUES (1, N'Semirapido Castillo-Constitucion')
INSERT [dbo].[Recorrido] ([Id], [Descripcion]) VALUES (3, N'Retiro - Constitucion')
SET IDENTITY_INSERT [dbo].[Recorrido] OFF
SET IDENTITY_INSERT [dbo].[Seccion] ON 

INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1016, N'Salta y OBrien', N'av 123', N'ss', NULL, NULL, NULL, CAST(-34.628877 AS Decimal(9, 6)), CAST(-58.384107 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1017, N'Indenpendencia y la Rioja', N'av123', N'una nota', NULL, NULL, NULL, CAST(-34.619712 AS Decimal(9, 6)), CAST(-58.409971 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1018, N'Av Rivadavia y colpayo', N'a', NULL, NULL, NULL, NULL, CAST(-34.619987 AS Decimal(9, 6)), CAST(-58.442453 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1019, N'Plaza Flores', N'a', NULL, NULL, NULL, NULL, CAST(-34.628585 AS Decimal(9, 6)), CAST(-58.465720 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1020, N'Av rivadavia y Corro', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1021, N'AV Gral Paz', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1022, N'Est. Ramos Mejia', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1023, N'Av de mayo y pizazarro', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1024, N'Rotodan San justo', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1025, N'Gral Manuel de rosa y Malvinas', N'aa', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1026, N'Rosas y Zarate', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1027, N'Rosas y Federico Russo', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1029, N'Ruta 21 y zavala', N'a', NULL, NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
INSERT [dbo].[Seccion] ([id], [nombre], [direccion], [nota], [fechaBaja], [CodParada], [CodInspector], [Latitud], [Longitud]) VALUES (1030, N'IVirtual Laferrere', N'av siempre viva', N'una nota', NULL, NULL, NULL, CAST(0.000000 AS Decimal(9, 6)), CAST(0.000000 AS Decimal(9, 6)))
SET IDENTITY_INSERT [dbo].[Seccion] OFF
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1016, 1, 1, CAST(N'18:00:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1016, 1, 2, CAST(N'15:50:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1017, 1, 1, CAST(N'18:10:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1017, 1, 2, CAST(N'15:55:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1018, 1, 1, CAST(N'18:30:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1018, 1, 2, CAST(N'15:57:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1019, 1, 1, CAST(N'18:50:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1019, 1, 2, CAST(N'18:58:00' AS Time))
INSERT [dbo].[Seccion_Horario] ([Seccion], [Recorrido], [Frecuencia], [Hora]) VALUES (1030, 1, 2, CAST(N'15:40:00' AS Time))
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId], [fechabaja]) VALUES (1, N'admin', N'123', N'A', CAST(2 AS Numeric(18, 0)), NULL)
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId], [fechabaja]) VALUES (4, N'sebac', N'123', N'C', CAST(2 AS Numeric(18, 0)), NULL)
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId], [fechabaja]) VALUES (5, N'juang', N'123', N'C', CAST(123 AS Numeric(18, 0)), NULL)
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId], [fechabaja]) VALUES (6, N'briank', N'123', N'I', CAST(3 AS Numeric(18, 0)), NULL)
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId], [fechabaja]) VALUES (7, N'matiasa', N'123', N'I', CAST(6 AS Numeric(18, 0)), NULL)
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId], [fechabaja]) VALUES (8, N'rominao', N'123', N'I', CAST(7 AS Numeric(18, 0)), NULL)
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId], [fechabaja]) VALUES (9, N'romanr', N'123', N'I', CAST(8 AS Numeric(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
ALTER TABLE [dbo].[logs] ADD  CONSTRAINT [df_logs_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[Conductor_Recorrido_Frecuencia]  WITH CHECK ADD  CONSTRAINT [FK_Conductor_Recorrido_Frecuencia_Conductor] FOREIGN KEY([Conductor])
REFERENCES [dbo].[Conductor] ([id])
GO
ALTER TABLE [dbo].[Conductor_Recorrido_Frecuencia] CHECK CONSTRAINT [FK_Conductor_Recorrido_Frecuencia_Conductor]
GO
ALTER TABLE [dbo].[Conductor_Recorrido_Frecuencia]  WITH CHECK ADD  CONSTRAINT [FK_Conductor_Recorrido_Frecuencia_Frecuencia] FOREIGN KEY([Frecuencia])
REFERENCES [dbo].[Frecuencia] ([Id])
GO
ALTER TABLE [dbo].[Conductor_Recorrido_Frecuencia] CHECK CONSTRAINT [FK_Conductor_Recorrido_Frecuencia_Frecuencia]
GO
ALTER TABLE [dbo].[Conductor_Recorrido_Frecuencia]  WITH CHECK ADD  CONSTRAINT [FK_Conductor_Recorrido_Frecuencia_Recorrido] FOREIGN KEY([Recorrido])
REFERENCES [dbo].[Recorrido] ([Id])
GO
ALTER TABLE [dbo].[Conductor_Recorrido_Frecuencia] CHECK CONSTRAINT [FK_Conductor_Recorrido_Frecuencia_Recorrido]
GO
ALTER TABLE [dbo].[Inspeccion]  WITH CHECK ADD  CONSTRAINT [FK_Inspeccion_Conductor] FOREIGN KEY([Interno])
REFERENCES [dbo].[Conductor] ([id])
GO
ALTER TABLE [dbo].[Inspeccion] CHECK CONSTRAINT [FK_Inspeccion_Conductor]
GO
ALTER TABLE [dbo].[Inspeccion]  WITH CHECK ADD  CONSTRAINT [FK_Inspeccion_Inspector] FOREIGN KEY([Inspector])
REFERENCES [dbo].[Inspector] ([id])
GO
ALTER TABLE [dbo].[Inspeccion] CHECK CONSTRAINT [FK_Inspeccion_Inspector]
GO
ALTER TABLE [dbo].[logs]  WITH CHECK ADD  CONSTRAINT [fk_logs_logs_tipo] FOREIGN KEY([tipo])
REFERENCES [dbo].[logs_tipo] ([id])
GO
ALTER TABLE [dbo].[logs] CHECK CONSTRAINT [fk_logs_logs_tipo]
GO
ALTER TABLE [dbo].[Parada]  WITH CHECK ADD  CONSTRAINT [FK_Parada_Inspector] FOREIGN KEY([CodInspector])
REFERENCES [dbo].[Inspector] ([id])
GO
ALTER TABLE [dbo].[Parada] CHECK CONSTRAINT [FK_Parada_Inspector]
GO
ALTER TABLE [dbo].[Seccion_Horario]  WITH CHECK ADD  CONSTRAINT [FK_Seccion_Horario_Frecuencia] FOREIGN KEY([Frecuencia])
REFERENCES [dbo].[Frecuencia] ([Id])
GO
ALTER TABLE [dbo].[Seccion_Horario] CHECK CONSTRAINT [FK_Seccion_Horario_Frecuencia]
GO
ALTER TABLE [dbo].[Seccion_Horario]  WITH CHECK ADD  CONSTRAINT [FK_Seccion_Horario_Recorrido] FOREIGN KEY([Recorrido])
REFERENCES [dbo].[Recorrido] ([Id])
GO
ALTER TABLE [dbo].[Seccion_Horario] CHECK CONSTRAINT [FK_Seccion_Horario_Recorrido]
GO
ALTER TABLE [dbo].[Seccion_Horario]  WITH CHECK ADD  CONSTRAINT [FK_Seccion_Horario_Seccion] FOREIGN KEY([Seccion])
REFERENCES [dbo].[Seccion] ([id])
GO
ALTER TABLE [dbo].[Seccion_Horario] CHECK CONSTRAINT [FK_Seccion_Horario_Seccion]
GO
USE [master]
GO
ALTER DATABASE [Proyecto] SET  READ_WRITE 
GO
