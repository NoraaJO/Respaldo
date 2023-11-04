ALTER PROCEDURE ObtenerArticulos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT A.id_Articulo, 
	A.nombre, 
	A.precio, 
	A.cantidad, 
	T.nombre as TipoArticulo
    FROM Articulo A
    INNER JOIN TipoArticulo T
    ON A.id_TipoArticulo = T.id_TipoArticulo
    FOR JSON PATH, ROOT('Articulos');
	
	SET NOCOUNT OFF;
END;

CREATE PROCEDURE ActualizarArticuloPorNombre
    @id_Articulo INT,
    @nombre_TipoArticulo NVARCHAR(128),
    @nuevoPrecio FLOAT,
    @nuevaCantidad INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_TipoArticulo INT;

    -- Buscar el id correspondiente al nombre_TipoArticulo en la tabla TipoArticulo
    SELECT @id_TipoArticulo = id_TipoArticulo FROM TipoArticulo WHERE nombre = @nombre_TipoArticulo;

    -- Si se encuentra el tipo de artículo, realizar la actualización
    IF @id_TipoArticulo IS NOT NULL
    BEGIN
        UPDATE Articulo
        SET precio = @nuevoPrecio,
            cantidad = @nuevaCantidad,
            id_TipoArticulo = @id_TipoArticulo
        WHERE id_Articulo = @id_Articulo;
    END
    ELSE
    BEGIN
        -- Manejar la situación donde no se encuentra el tipo de artículo con el nombre especificado
        PRINT 'No se encontró ningún tipo de artículo con el nombre especificado.';
    END
END;

CREATE PROCEDURE ConsultarArticuloPorNombre
    @nombre NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT A.nombre, 
	T.nombre as TipoArticulo, 
	A.cantidad
    FROM Articulo A
    INNER JOIN TipoArticulo T ON A.id_TipoArticulo = T.id_TipoArticulo
    WHERE A.nombre = @nombre
    FOR JSON PATH, ROOT('ArticuloxNombre');

	SET NOCOUNT OFF;
END;

CREATE PROCEDURE ConsultarArticuloPorTipo
    @nombreTipArt VARCHAR(32)
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @idTipoArt VARCHAR(32);
	
	SELECT @idTipoArt = T.id_TipoArticulo
	FROM dbo.TipoArticulo T 
	WHERE @nombreTipArt = T.nombre 

	SELECT A.nombre, 
	TA.nombre as TipoArticulo, 
	A.cantidad
    FROM Articulo A
    INNER JOIN TipoArticulo TA ON A.id_TipoArticulo = TA.id_TipoArticulo
    WHERE A.id_TipoArticulo = @idTipoArt
    FOR JSON PATH, ROOT('ArticuloxTipo');

	SET NOCOUNT OFF
END; 


CREATE PROCEDURE ConsultarArticulosPorCantidad
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Articulo
    WHERE cantidad <= 3;
END;

CREATE PROCEDURE AgregarArticulo
    @nombre NVARCHAR(128),
    @precio FLOAT,
    @cantidad INT,
    @nombreTA NVARCHAR(128) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_TipoArticulo INT;

    -- Buscar el id correspondiente a @nombreTA en la tabla TipoArticulo
    SELECT @id_TipoArticulo = T.id_TipoArticulo FROM TipoArticulo T WHERE T.nombre = @nombreTA;

    -- Si se encontró un id válido, realizar la inserción en la tabla Articulo
    IF @id_TipoArticulo IS NOT NULL
    BEGIN
        INSERT INTO dbo.Articulo (nombre, precio, cantidad, id_TipoArticulo)
        VALUES (@nombre, @precio, @cantidad, @id_TipoArticulo);
    END
    ELSE
    BEGIN
        -- Manejar la situación donde no se encontró un id correspondiente en TipoArticulo
        PRINT 'El tipo de artículo especificado no existe.';
    END
END;


----Pedidos Arreglar

CREATE PROCEDURE AgregarPedido
    @descripcion NVARCHAR(128),
    @nombreCliente NVARCHAR(128),
    @nombreEmpleado NVARCHAR(128),
    @fechaPedido DATE,
    @pagoTotal FLOAT,
    @nombreP NVARCHAR(128) 
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_Estado INT;
	DECLARE @id_Pedido INT;
	DECLARE @idEmpleado INT;

    -- Buscar el id correspondiente a @id_Estado en la tabla Estado
    SELECT @id_Estado = id_Estado FROM Estado WHERE nombre = @nombreP;
	SELECT @idEmpleado = id_Usuario FROM Usuario WHERE nombre = @nombreEmpleado

    -- Si se encontró un id válido, realizar la inserción en la tabla Pedido
    IF @id_Estado IS NOT NULL
    BEGIN
        INSERT INTO Pedido (descripcion, nombreCliente, fechaPedido, pagoTotal, id_Estado)
        VALUES (@descripcion, @nombreCliente, @fechaPedido, @pagoTotal, @id_Estado);
		
		SET @id_Pedido = SCOPE_IDENTITY();

		INSERT INTO dbo.PedidoxUsuario (id_Pedido, id_Usuario)
		VALUES(@id_Pedido, @idEmpleado)
	END
    ELSE
    BEGIN
        -- Manejar la situación donde no se encontró un id correspondiente en Estado
        PRINT 'El estado especificado no existe.';
    END
END;

CREATE PROCEDURE CoslPediNombrEmplea
    @nombreEmpleado NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @idEmpleado INT;
	
	SELECT @idEmpleado FROM dbo.Usuario p WHERE p.nombre = @nombreEmpleado
    
	
	SELECT P.id_Pedido, 
	P.descripcion, 
	P.nombreCliente, 
	D.nombre, 
	P.fechaPedido, 
	P.pagoTotal, 
	T.nombre as TipoPedido
    FROM Pedido P
    INNER JOIN Estado T ON P.id_Estado = T.id_Estado
	JOIN dbo.PedidoxUsuario N ON P.id_Pedido = N.id_Pedido
	INNER JOIN Usuario D ON D.id_Usuario = N.id_Usuario
    WHERE N.id_Usuario = @idEmpleado
    FOR JSON PATH, ROOT('PedidoxEmpleado');
	SET NOCOUNT OFF;
END;

CREATE PROCEDURE ConsltPedidosPorEstado
    @nombre_Estado INT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @id_Estado INT

	SELECT @id_Estado = P.id_Estado FROM dbo.Estado P WHERE P.nombre = @nombre_Estado
    
	SELECT P.id_Pedido, 
	P.descripcion, 
	P.nombreCliente, 
	P.fechaPedido,
	U.nombre,
	P.pagoTotal, 
	T.nombre as Estado
    FROM Pedido P
    INNER JOIN Estado T ON P.id_Estado = T.id_Estado
	INNER JOIN PedidoxUsuario D ON P.id_Pedido = D.id_Pedido
	INNER JOIN Usuario U ON D.id_Usuario = U.id_Usuario
    WHERE P.id_Estado = @id_Estado
    FOR JSON PATH, ROOT('PedidoxEmpleado');

	SET NOCOUNT OFF;
END;

CREATE PROCEDURE ConsultarPedidosPorCliente
    @nombreCliente NVARCHAR(128)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT P.id_Pedido, 
	P.descripcion, 
	P.nombreCliente, 
	U.nombre, 
	P.fechaPedido, 
	P.pagoTotal, 
	T.nombre as Estado
    FROM Pedido P
    INNER JOIN Estado T ON P.id_Estado = T.id_Estado
	INNER JOIN PedidoxUsuario D ON P.id_Pedido = D.id_Pedido
	INNER JOIN Usuario U ON D.id_Usuario = U.id_Usuario
    WHERE P.nombreCliente = @nombreCliente
    FOR JSON PATH, ROOT('PedidoxCliente');
	SET NOCOUNT OFF;
END;

CREATE PROCEDURE ActualizarPedidoPorNombre
    @id_Pedido INT,
    @nombre_Estado NVARCHAR(128),
    @descripcion NVARCHAR(128),
    @nombreCliente NVARCHAR(128),
    @pagoTotal FLOAT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_Estado INT;

    -- Buscar el id correspondiente al nombre_Estado en la tabla Estado
    SELECT @id_Estado = id_Estado FROM Estado WHERE nombre = @nombre_Estado;


    -- Si se encuentra el estado, realizar la actualización
    IF @id_Estado IS NOT NULL
    BEGIN
        UPDATE Pedido
        SET descripcion = @descripcion,
            nombreCliente = @nombreCliente,
            pagoTotal = @pagoTotal,
            id_Estado = @id_Estado
        WHERE id_Pedido = @id_Pedido;
    END
    ELSE
    BEGIN
        -- Manejar la situación donde no se encuentra el estado con el nombre especificado
        PRINT 'No se encontró ningún estado con el nombre especificado.';
    END
END;

---Iniciar Sesion
CREATE PROCEDURE IniciarSesion
    @NombreUsuario NVARCHAR(50),
    @Contraseña NVARCHAR(50),
	@Resultado INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UsuarioID INT;

    -- Verificar si el usuario y la contraseña coinciden
    SELECT @UsuarioID = @NombreUsuario
    FROM Usuario
    WHERE nombre = @NombreUsuario AND contraseña = @Contraseña;

    -- Si el usuario y contraseña son válidos, se devuelve el ID del usuario
    IF @UsuarioID IS NOT NULL
    BEGIN
        SET @Resultado = @UsuarioID;
    END
    ELSE
    BEGIN
        -- Si no coinciden, se devuelve un mensaje de error
        SET @Resultado = -1;
    END
END;

CREATE PROCEDURE ObtenerPedidos
AS
BEGIN
    SET NOCOUNT ON;

    SELECT P.id_Pedido, 
	P.descripcion, 
	P.nombreCliente, 
	U.nombre, 
	P.fechaPedido, 
	P.pagoTotal, 
	T.nombre as Estado
    FROM Pedido P
    INNER JOIN Estado T ON P.id_Estado = T.id_Estado
	INNER JOIN PedidoxUsuario D ON P.id_Pedido = D.id_Pedido
	INNER JOIN Usuario U ON D.id_Usuario = U.id_Usuario

	SET NOCOUNT OFF
END
