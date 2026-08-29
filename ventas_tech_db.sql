-----------------------
  /* Pre_Entrega 3 */
-----------------------


/* DDL - CREACION DE BASE DE DATOS Y PUESTA EN USO */

CREATE DATABASE Ventas_Tech_DB;
USE Ventas_Tech_DB;

/* DDL - ELIMINACION DE TABLAS PREEXISTENTES EN CASO DE EXISTIR */

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

/* DML - CREACION DE TABLAS CON TIPOS DE CARACTERES Y RESTRICCIONES */

CREATE TABLE categorias(
id_categoria INT NOT NULL PRIMARY KEY,
nombre_categoria VARCHAR(50) NOT NULL,
descripcion VARCHAR(200)
);

CREATE TABLE clientes(
id_cliente INT NOT NULL PRIMARY KEY,
nombre_cliente VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
ciudad VARCHAR(50),
fecha_registro DATE NOT NULL
);

CREATE TABLE productos(
id_producto INT NOT NULL PRIMARY KEY,
nombre_producto VARCHAR(100) NOT NULL,
id_categoria INT FOREIGN KEY REFERENCES categorias(id_categoria),
precio DECIMAL(10,2) NOT NULL,
stock INT DEFAULT 0,
activo BIT DEFAULT 1
);

CREATE TABLE ventas(
id_venta INT NOT NULL PRIMARY KEY,
id_cliente INT FOREIGN KEY REFERENCES clientes(id_cliente),
id_producto INT FOREIGN KEY REFERENCES productos(id_producto),
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
fecha_venta DATE NOT NULL
);

/* DML - CARGA DE DATOS EN TABLAS */


--- TABLA CATEGORIAS ---

INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento','Discos y memorias');

--- TABLA CLIENTES ---

INSERT INTO clientes VALUES (1, 'María López', 'maria@mail.com','Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez', 'ana@mail.com', 'Rosario', '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01');

--- TABLA PRODUCTOS ---

INSERT INTO productos VALUES (1, 'Laptop Pro 15', 1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico', 2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"', 1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro', 3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB', 4, 130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico', 2, 95.00, 40, 1);


--- TABLA VENTAS ---

INSERT INTO ventas VALUES (1, 1, 1, 2, 1200, '2024-03-05');
INSERT INTO ventas VALUES (2, 2, 2, 5, 28, '2024-03-06');
INSERT INTO ventas VALUES (3, 3, 3, 1, 450, '2024-03-07');
INSERT INTO ventas VALUES (4, 1, 4, 2, 120, '2024-03-08');
INSERT INTO ventas VALUES (5, 4, 5, 3, 130, '2024-03-10');
INSERT INTO ventas VALUES (6, 2, 6, 4, 95, '2024-03-11');
INSERT INTO ventas VALUES (7, 5, 1, 1, 1200, '2024-03-12');
INSERT INTO ventas VALUES (8, 3, 2, 8, 28, '2024-03-13');
INSERT INTO ventas VALUES (9, 4, 4, 1, 120, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2, 450, '2024-03-15');


/* DQL - VISUALIZACION DE TABLAS Y DATOS CREADOS */

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;







