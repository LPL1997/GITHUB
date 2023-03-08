SELECT *
FROM TR_baseWHATS


USE [BI_STAGE]
GO

/****** Object:  Table [dbo].[TR_BaseWHATS]    Script Date: 29/01/2023 14:04:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FN_BaseWHATS](
	[CPF_CNPJ] float NOT NULL,
	[DDD] [int] NOT NULL,
	[Telefone] [int] NOT NULL,
	[DATA_BMG] [datetime] NULL,
	[M�S] [nvarchar](255) NULL,
	[ONDE] [nvarchar](255) NULL
) ON [PRIMARY]
GO

INSERT INTO FN_BaseWHATS
SELECT [CPF/CNPJ],
[DDD],
[Telefone],
[DATA_BMG],
[M�S],
[ONDE]
FROM TR_BaseWHATS