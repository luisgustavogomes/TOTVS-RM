USE [CORPORERM]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[FOP_GET_HSTFUNCAO]
(
    
     @CODCOLIGADA int
    ,@CHAPA VARCHAR(16)
	,@DATA DATETIME
)
RETURNS TABLE AS RETURN
(
    SELECT 
		 H.CODCOLIGADA
		,H.CODFUNCAO AS 'CODFUNCAO_HIST'
		,F.NOME AS 'NOME_FUNCAO_HIST'
      FROM DBO.PFHSTFCO (NOLOCK) H
	  JOIN DBO.PFUNCAO  (NOLOCK) F ON (H.CODCOLIGADA = F.CODCOLIGADA AND H.CODFUNCAO = F.CODIGO)
     WHERE H.CODCOLIGADA = @CODCOLIGADA
	   AND H.CHAPA=@CHAPA
       AND H.DTMUDANCA = (SELECT MAX(HH.DTMUDANCA)
                            FROM DBO.PFHSTFCO (NOLOCK) HH 
                           WHERE HH.CODCOLIGADA = H.CODCOLIGADA 
						     AND HH.CHAPA = H.CHAPA
                             AND HH.DTMUDANCA <= @DATA)
)
