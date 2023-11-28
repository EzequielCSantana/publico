if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_APPLOGIN]') 
and OBJECTPROPERTY(id, N'IsProcedure') = 1)
   drop procedure [dbo].[SP_APPLOGIN]
GO
CREATE PROCEDURE SP_APPLOGIN
	@USUARIO VARCHAR(20),
	@SENHA VARCHAR(20)
AS	
	DECLARE @ID INT
	SET @ID=(
	SELECT TOP 1
		ID
	FROM appLogin WITH(NOLOCK)
	WHERE usuario = @USUARIO
	AND SENHA=@SENHA )
	SET @ID=ISNULL(@ID,0)
	IF ( @ID > 0 ) BEGIN
		UPDATE appLogin WITH(ROWLOCK)
			SET ultimoAcesso=GETDATE()
		WHERE ID=@ID
	END
	--
	SELECT
		id,usuario,CONVERT(varchar(10),ultimoAcesso,103)+' '+CONVERT(varchar(10),ultimoAcesso,108) as data
	FROM appLogin WITH(NOLOCK)
	WHERE id=@ID
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_APP_GET_TEXTO]') 
and OBJECTPROPERTY(id, N'IsProcedure') = 1)
   drop procedure [dbo].[SP_APP_GET_TEXTO]
GO
CREATE PROCEDURE SP_APP_GET_TEXTO
	@CONSULTA VARCHAR(100)
AS	
	SELECT
		appTexto.id,
		appTexto.texto,
		CONVERT(varchar(10),appTexto.data,103)+' '+CONVERT(varchar(10),appTexto.data,108) as data,
		appLogin.usuario
	FROM appTexto WITH(NOLOCK)
	INNER JOIN appLogin WITH(NOLOCK)
		ON appTexto.usuario = appLogin.id
	WHERE CONVERT(VARCHAR(8000),texto) LIKE ('%'+@CONSULTA+'%')
	ORDER BY texto
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_APP_SET_TEXTO]') 
and OBJECTPROPERTY(id, N'IsProcedure') = 1)
   drop procedure [dbo].[SP_APP_SET_TEXTO]
GO
CREATE PROCEDURE SP_APP_SET_TEXTO
	@ID INT,
	@USUARIO INT,
	@TEXTO VARCHAR(100)
AS	
	DECLARE @RETORNO VARCHAR(100)
	SET @RETORNO=''
	--
	IF ( @ID = 0 ) BEGIN
		IF EXISTS( SELECT 1 FROM appTexto WITH(NOLOCK) WHERE texto=@TEXTO ) BEGIN
			SET @RETORNO='Texto já digitado'
		END ELSE BEGIN
			INSERT INTO appTexto( usuario,texto,data)
			VALUES( @USUARIO,@TEXTO,GETDATE())
		END
	END ELSE BEGIN
		UPDATE appTexto WITH(ROWLOCK) SET
			texto=@TEXTO,
			usuario=@USUARIO,
			data=GETDATE()
		WHERE ID=@ID
	END
	--
	SELECT @RETORNO AS retornoMsg
GO
