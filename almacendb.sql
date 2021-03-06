
-- Database: Almacen

-- DROP DATABASE "Almacen";

CREATE DATABASE "Almacen"
WITH 
OWNER = postgres
ENCODING = 'UTF8'
LC_COLLATE = 'English_United States.1252'
LC_CTYPE = 'English_United States.1252'
TABLESPACE = pg_default
CONNECTION LIMIT = -1;
	
	
CREATE TABLE Cajeros(  
cajero_id INT GENERATED ALWAYS AS IDENTITY,  
nompeido VARCHAR(50) NOT NULL,  
PRIMARY KEY(cajero_id)  
); 

CREATE TABLE Maquinas_Registradoras(  
maquina_id INT GENERATED ALWAYS AS IDENTITY,  
piso INT NOT NULL,
PRIMARY KEY(maquina_id)  
); 

CREATE TABLE Productos(  
producto_id INT GENERATED ALWAYS AS IDENTITY,  
nombre VARCHAR(50) NOT NULL,
precio money NOT NULL,
PRIMARY KEY(producto_id)  
);

CREATE TABLE Venta (
venta_id INT GENERATED ALWAYS AS IDENTITY, 
cajero_id INT,
maquina_id INT,
producto_id INT,
PRIMARY KEY(venta_id),
CONSTRAINT fk_cajero  
FOREIGN KEY(cajero_id)   
REFERENCES cajeros(cajero_id),
CONSTRAINT fk_maquina  
FOREIGN KEY(maquina_id)   
REFERENCES maquinas_registradoras(maquina_id),
CONSTRAINT fk_producto  
FOREIGN KEY(producto_id)   
REFERENCES productos(producto_id)
);

INSERT INTO Cajeros (nompeido) VALUES ('Daniel Rivas Angulo'),('Ali Manaen'),('Carlos Hurtado Placencia');
INSERT INTO productos (nombre,precio) VALUES ('Cinta Adhesiva',178),('Pantalla Plasma 72" SONY',987),('Chocolates Ferrero Roche 18Pzas',354);
INSERT INTO maquinas_registradoras (piso) VALUES (2),(3),(5);
INSERT INTO venta (cajero_id, maquina_id,producto_id) VALUES (2,1,3),(1,2,2),(1,2,3);


SELECT * from venta ORDER BY venta_id DESC

SELECT venta.venta_id,cajeros.nompeido,productos.nombre,productos.precio,maquinas_registradoras.piso
FROM venta,cajeros,productos, maquinas_registradoras WHERE venta.cajero_id = cajeros.cajero_id AND venta.maquina_id = maquinas_registradoras.maquina_id
AND venta.producto_id = productos.producto_id


SELECT venta.venta_id, SUM(productos.precio) AS totalVentas, cajeros.cajero_id , cajeros.nompeido FROM venta, productos, cajeros
WHERE venta.producto_id = productos.producto_id AND venta.cajero_id = cajeros.cajero_id GROUP BY
totalVentas, venta.venta_id

SELECT venta.venta_id, productos.precio AS totalVentas, cajeros.cajero_id , cajeros.nompeido FROM venta, productos, cajeros
WHERE venta.producto_id = productos.producto_id AND venta.cajero_id = cajeros.cajero_id AND productos.precio < '5000'
