ALTER PROCEDURE Insertar_Articulo
(
	@InNombre VARCHAR(128)
	, @InPrecio MONEY
	, @InClaseArticulo VARCHAR(64)
)
AS
BEGIN
	SET NOCOUNT ON;
		
		DECLARE @OutResultado INT;
		DECLARE @ArticuloRevisar VARCHAR (60);
		print @InNombre
		IF(@InNombre IS NULL ) -- SE EVITA QUE SEA NULO
		BEGIN
			PRINT 'Nombre no valido';
			SET @OutResultado = 1;
			RETURN 1
		END;

		IF (@InPrecio IS NULL OR 
			@InPrecio <= 0
			)
		BEGIN
			PRINT 'El precio no es valido'
			SET @OutResultado = 2;
			RETURN @OutResultado;
		END;

		IF (@InClaseArticulo IS NULL OR 
			(SELECT Nombre FROM dbo.ClaseArticulos WHERE Nombre = @InClaseArticulo) IS NULL)
		
		BEGIN 
			PRINT 'Clase de Articulo no valido';
			SET @OutResultado = 3;
			RETURN @OutResultado;
		END;

		--Aqui se revisa si hay un articulo con el mismo nombre.
		SET @ArticuloRevisar = (SELECT Nombre FROM dbo.Articulo WHERE Nombre = @InNombre)
		IF (@ArticuloRevisar IS NOT NULL)
		BEGIN

			PRINT 'Articulo con nombre duplicado';
			SET @OutResultado = 4;
			RETURN @OutResultado;
		END

	INSERT INTO dbo.Articulo(Nombre, Precio, IdClaseArticulo)
	VALUES (@InNombre, @InPrecio, (SELECT id FROM dbo.ClaseArticulos WHERE Nombre = @InClaseArticulo));
	PRINT 'Articulo Agregado Exitosamente';
	SET @OutResultado = 5;
	RETURN @OutResultado; 
	SET NOCOUNT OFF

END;
EXEC Insertar_Articulo 'Botella', 208.80, 'Electricos'
SELECT * FROM dbo.Articulo A Inner join dbo.ClaseArticulos C ON A.IdClaseArticulo = C.id


