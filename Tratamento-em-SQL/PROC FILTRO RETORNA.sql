USE [BI_STAGE]
GO
/****** Object:  StoredProcedure [dbo].[ArrumaBaseRetornoMaster]    Script Date: 27/01/2023 18:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[ArrumaBaseRetornoMaster] AS


--> INSERE DADOS NA TABELA FINAL

INSERT INTO  [dbo].[FN_RetornoLadeiraMaster]

SELECT
	   [cpf]
      ,[NumeroMatricula]
      ,[Correspondente]
      ,[Status]
      ,CONVERT(DATE, REPLACE([DataNascimento],'NULL','1900-01-01'))
      ,[NomeBeneficiario]
      ,[SituacaoBeneficio]
      ,[EspecieBeneficio]
      ,[ConcessaoJudicial]
	  ,CONVERT(DATE, REPLACE([DataCessacaoBeneficio],'NULL','1900-01-01'))
      ,[UfPagamento]
      ,[TipoCredito]
      ,[CbcIfPagadora]
      ,[AgenciaPagadora]
      ,0 -- [ContaCorrente]
      ,[PensaoAlimenticia]
      ,[PossuiRepresentanteLegal]
      ,[PossuiProcurador]
      ,[PossuiEntidadeRepresentacao]
      ,[BloqueadoParaEmprestimo]
	  ,CONVERT(DATE, REPLACE([DataUltimaPericia],'NULL','1900-01-01'))
	  ,CONVERT(DATE, REPLACE([DataDespachoBeneficio],'NULL','1900-01-01'))
      ,[MargemDisponivel]
      ,[MargemDisponivelCartao]
      ,CAST((ValorLimiteCartao) AS decimal(15,2))
      ,[QtdEmprestimosAtivosSuspensos]
	  ,CONVERT(DATE, REPLACE([DataConsulta],'NULL','1900-01-01'))
      ,0 --[CpfRepresentanteLegal]
      ,[NomeRepresentanteLegal]
	  ,CONVERT(DATE, REPLACE(DataFimRepresentanteLegal,'NULL','1900-01-01'))
      ,[ElegivelEmprestimo]
      ,[Observacao]
      ,[MargemDisponivelRcc]
      ,[ValorLimiteRcc]
	  ,GETDATE()
	  ,1
  FROM [BI_STAGE].[dbo].[TR_RetornoLadeiraMaster]



--> RETIRA DO FILTRO UF SANTA CATARINA 

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [UfPagamento] = 'SC'


--> RETIRA ESPÉCIE BENEFÍCIO 30

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [EspecieBeneficio] = 30


--> RETIRA VALORES MENORES QUE 0 DA MARGEM DISPONIVEL

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [MargemDisponivel] < 0

----------------------------------------------------------------------------------

--> RETIRA VALORES MENORES QUE 0 DA MARGEM DISPONIVELCARTAO

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [MargemDisponivelCartao] < 0


--> RETIRA VALORES MENORES QUE 0 DA MARGEM DISPONIVELRCC

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [MargemDisponivelRcc] < 0


--> RETIRA OS VALORES DIFERENTES DE 0 DO ELEGIVEL PARA EMPRESTIMO

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [ElegivelEmprestimo] = 0


--> RETIRA ESPECIE BENEFICIO 21 QUANDO FOR MENOR OU IGUAL A 45 ANOS

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [EspecieBeneficio] = 21 AND DATEDIFF(YEAR,DataNascimento,getdate()) <= 45


--> RETIRA ESPECIE BENEFICIO 32, 88 E 92 QUANDO FOR MENOR OU IGUAL A 60 ANOS

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [EspecieBeneficio] IN (32, 88, 92) AND DATEDIFF(YEAR,DataNascimento,getdate()) <= 60


--> SITUAÇÃO BENEFICIO REMOVER MAIOR QUE 0

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [SituacaoBeneficio] > 0


--> CONCESSÃO JUDICIAL REMOVER MAIOR QUE 0

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [ConcessaoJudicial] > 0


--> PENSÃO ALIMENTICIA REMOVER MAIOR OU IGUAL A 2

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [PensaoAlimenticia] >= 2


--> REPRESENTANTE LEGAL REMOVER MAIOR QUE 0

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [PossuiRepresentanteLegal] > 0


--> POSSUI PROCURADOR REMOVER MAIOR QUE 0

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [PossuiProcurador] > 0


--> CRIA E CALCULA SALARIO

ALTER TABLE [dbo].[FN_RetornoLadeiraMaster]
ADD SALARIO float;

UPDATE [dbo].[FN_RetornoLadeiraMaster]
SET [SALARIO] = (ValorLimiteRcc / 1.6)

---------------------------------------------------------------------------------------------
------ # BMG CARD # ----------

--> RETIRA DO FILTRO UF RIO GRANDE DO SUL

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [UfPagamento] = 'RS'


--> RETIRA OS VALORES MENORES QUE 65,1 DA MARGEMDISPONIVELCARTAO

UPDATE [dbo].[FN_RetornoLadeiraMaster] SET FILTRO = 0
WHERE [MargemDisponivelCartao] < 65.1


--> CRIA E CALCULA VALOR DO SAQUE

ALTER TABLE [dbo].[FN_RetornoLadeiraMaster]
ADD VALOR_SAQUE float;

UPDATE [dbo].[FN_RetornoLadeiraMaster]
SET [VALOR_SAQUE] =  (ValorLimiteCartao * 0.7)

-- ALTER TABLE [dbo].[FN_RetornoLadeiraMaster] ALTER COLUMN [MargemDisponivel] float

