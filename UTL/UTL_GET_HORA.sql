USE [CORPORERM]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UTL_GET_HORA]
(
	@MINUTOS INT
)
RETURNS VARCHAR(100)
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @RETORNO AS VARCHAR(MAX);
	DECLARE @NEG INT = 0;

	IF @MINUTOS < 0
	BEGIN
		SET @MINUTOS = ABS(@MINUTOS);
		SET @NEG = 1;
	END


	IF @MINUTOS < 6000
		BEGIN 
				SET @RETORNO = (REPLICATE('0', 2 - LEN(cast((SUM(@MINUTOS) /60) as varchar))) 
				                + cast((SUM(@MINUTOS) /60) as varchar)+ ':' +
								REPLICATE('0', 2 - LEN(cast((SUM(@MINUTOS) %60) as varchar))) 
								+ cast((SUM(@MINUTOS) %60) as varchar))
		END 
	ELSE 
		BEGIN
				SET @RETORNO = (REPLICATE('0', 3 - LEN(cast((SUM(@MINUTOS) /60) as varchar))) 
				                + cast((SUM(@MINUTOS) /60) as varchar)+ ':' +
								REPLICATE('0', 2 - LEN(cast((SUM(@MINUTOS) %60) as varchar))) 
								+ cast((SUM(@MINUTOS) %60) as varchar))
		END 
	
	
	IF @NEG = 1 
		SET @RETORNO = CONCAT('-',@RETORNO);
	
	RETURN @RETORNO
END