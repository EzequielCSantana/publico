-- Usado sql server 2018
if NOT exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[appLogin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN	
CREATE TABLE [dbo].[appLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](20) NOT NULL,
	[senha] [varchar](20) NOT NULL,
	[ultimoAcesso] [datetime] NOT NULL,
 CONSTRAINT [PK_appLogin] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	PRINT('TABELA appLogin CRIADA COM SUCESSO !')
END ELSE PRINT('TABELA appLogin JÁ EXIST !')
GO
if NOT exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[appTexto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	CREATE TABLE [dbo].[appTexto](
		[id] [int] IDENTITY(1,1) NOT NULL,
		[usuario] [int] NOT NULL,
		[texto] [varchar](max) NOT NULL,
		[data] [datetime] NOT NULL,
	 CONSTRAINT [PK_appTexto] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	--
	ALTER TABLE [dbo].[appLogin] ADD  CONSTRAINT [DF_appLogin_ultimoAcesso]  DEFAULT (getdate()) FOR [ultimoAcesso]
	--
	ALTER TABLE [dbo].[appTexto]  WITH CHECK ADD  CONSTRAINT [FK_appTexto_appLogin] FOREIGN KEY([usuario])
	REFERENCES [dbo].[appLogin] ([id])
	--
	ALTER TABLE [dbo].[appTexto] CHECK CONSTRAINT [FK_appTexto_appLogin]
	--
	PRINT('TABELA appTexto CRIADA COM SUCESSO !')
END ELSE PRINT('TABELA appTexto JÁ EXIST !')
GO
GO

