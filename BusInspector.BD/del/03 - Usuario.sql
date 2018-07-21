
/****** Object:  Table [dbo].[Usuario]    Script Date: 09/07/2018 11:32:53 p. m. ******/
DROP TABLE [dbo].[Usuario]
GO

/****** Object:  Table [dbo].[Usuario]    Script Date: 09/07/2018 11:32:53 p. m. ******/
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
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [Proyecto]
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 
GO
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId]) VALUES (1, N'admin', N'1234', N'A', NULL)
GO
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId]) VALUES (4, N'sebac', N'1234', N'C', CAST(2 AS Numeric(18, 0)))
GO
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId]) VALUES (5, N'juang', N'1234', N'C', CAST(123 AS Numeric(18, 0)))
GO
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId]) VALUES (6, N'briank', N'1234', N'I', CAST(3 AS Numeric(18, 0)))
GO
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId]) VALUES (7, N'matiasa', N'1234', N'I', CAST(6 AS Numeric(18, 0)))
GO
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId]) VALUES (8, N'rominao', N'1234', N'I', CAST(7 AS Numeric(18, 0)))
GO
INSERT [dbo].[Usuario] ([IdUsuario], [NombreUsuario], [Password], [Rol], [RolId]) VALUES (9, N'romanr', N'1234', N'I', CAST(8 AS Numeric(18, 0)))
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
