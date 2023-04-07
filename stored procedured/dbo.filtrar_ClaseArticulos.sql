CREATE PROCEDURE Filtrar_ClaseArticulo
(
	@InClaseArticulo VARCHAR(128) --NOMBRE DE LA CLASE DE ARTICULO A FILTRAR
	,@InIp VARCHAR(64) --IP DEL USUARIO
	,@InUsuarios VARCHAR(16) --USERNAME DEL QUE EJECUTO EL PROCEDURE
)
AS
BEGIN
	SET NOCOUNT ON; --ACTIVAR, PARA QUE NO ENVIE EL MENSAJE FILAS AFECTADAS
	
		SELECT A.Nombre AS [Nombre] -- MUESTRA EL NOMBRE DEL ARTICULOS
			, C.Nombre AS [Clase Articulo] --MUESTRA EL NOMBRE DE CLASE DE ARTICULO
			, A.Precio AS [Precio] --MUESTRA EL PRECIO DEL ARTICULO
		
		FROM dbo.Articulo A --DE LA TABLA ARTICULOS
		INNER JOIN dbo.ClaseArticulo C ON A.IdClaseArticulo = C.id -- JUNTA LAS TABLAS Y REMPLAZA ID POR EL NOMBRE RELACIONADO DE LA CLASE ARTICULO
		WHERE C.Nombre =@InClaseArticulo --SOLO MUESTRA LOS ARTICULOS CON LA MISMA CLASE DE ARTICULOS
		ORDER BY A.Nombre ASC; --MUESTRA LA TABLA EN ORDEN ALFABETICO ASCENDENTE DEL NOMBRE

		EXEC dbo.Insertar_EventLog 'Consulta por clase de articulo', @InClaseArticulo, @InUsuarios, @InIp; --REGISTRA LA ACCI�N REALIZADA CON LOS VALORES Y DATOS DE QUIEN LO HIZO EN EVENTLOG

	SET NOCOUNT OFF; --SE DESACTIVA SIEMPRE ANTES DE FINALIZAR.

END