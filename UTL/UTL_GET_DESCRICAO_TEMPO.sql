USE [CORPORERM]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[UTL_GET_DESCRICAO_TEMPO] 
(
	@DTINI DATETIME2,
	@DTFIM DATETIME2 
)
RETURNS VARCHAR(MAX)
WITH SCHEMABINDING
AS
BEGIN
	
	DECLARE @Result VARCHAR(MAX)
	DECLARE @DIA INT, @MES INT, @ANO INT
	
	SET  @ANO = (YEAR(@DTFIM) - YEAR(@DTINI)) 
	SET  @MES = (MONTH(@DTFIM) - MONTH(@DTINI)) 
	SET  @DIA = (DAY(@DTFIM) - DAY(@DTINI)) 
	
	IF @DIA < 0
	    BEGIN
	        SET @DIA = @DIA + 30
	        SET @MES = @MES - 1
	        IF @MES < 0
	                BEGIN
	                    SET @ANO = @ANO -1
	                    SET @MES = @MES + 12
	                END  
	
	    END
	ELSE IF @MES < 0
	                BEGIN
	                    SET @ANO = @ANO -1
	                    SET @MES = @MES + 12
	                END             
	
	SET @Result = (SELECT  CAST(@ANO AS VARCHAR(MAX)) + ' Ano(s), ' 
	                     + CAST(@MES AS VARCHAR(MAX)) + ' Mês(es) e '
						 + CAST(@DIA AS VARCHAR(MAX)) + ' Dia(s) ' 
						 )

	
	RETURN @Result

END
GO