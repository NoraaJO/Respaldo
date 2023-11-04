CREATE DATABASE Inventarios

CREATE TABLE Articulo(
    id_Articulo INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(128),
    precio FLOAT, 
    cantidad INT,
    id_TipoArticulo INT   
);
CREATE TABLE Usuario(
    id_Usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(128),
    apellidos NVARCHAR(128), 
    username NVARCHAR(128),
    contraseña NVARCHAR(128)  
);
CREATE TABLE TipoArticulo(
    id_TipoArticulo INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(128) 
);
CREATE TABLE Estado(
    id_Estado INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(128) 
);

CREATE TABLE Pedido(
    id_Pedido INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(128),
    nombreCliente NVARCHAR(128), 
    fechaPedido DATE,
    pagoTotal FLOAT,
    id_Estado INT
);

CREATE TABLE PedidoxUsuario(
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_Pedido INT,
    id_Usuario INT
);