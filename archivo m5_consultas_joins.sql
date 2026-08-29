-----------------------
  /* Pre_Entrega 5 */
-----------------------
--- CONSULTA 1 --- VISTA BASE DEL PROYECTO (INNER JOIN)

SELECT 
	v.id_venta,
	v.fecha_venta,

--- Informacion del cliente ---
	v.id_cliente,
    c.nombre_cliente,
    c.ciudad AS ciudad_cliente,

--- Informacion de producto/categoria ---
	v.id_producto,
	p.nombre_producto,
	cat.nombre_categoria,

--- Métricas de ventas --- 
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta

FROM ventas AS v
INNER JOIN productos AS p		
	ON v.id_producto = p.id_producto
INNER JOIN clientes AS c
	ON v.id_cliente = c.id_cliente
INNER JOIN categorias AS cat
	ON p.id_categoria = cat.id_categoria;



--- CONSULTA 2 --- Clientes sin ventas (LEFT JOIN)

/* En los 50 registros de la tabla ventas, todos los clientes tienen al menos una compra (venta) realizada. Para que la consulta devuelva
resultados visinles, procedo a insertar un par de clientes nuevos que no hayan realizado compras */

INSERT INTO clientes VALUES (6, 'Lucía Fernández', 'lucia@mail.com', 'Rosario', '2024-04-01');
INSERT INTO clientes VALUES (7, 'Gonzalo Ramírez', 'gonzalo@mail.com', 'Cordoba', '2024-04-10');

SELECT
	c.nombre_cliente,
	c.email,
	c.fecha_registro,
	v.id_venta
FROM clientes AS c
LEFT JOIN ventas AS v
	ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

--- CONSULTA 3 --- Productos sin ventas (LEFT JOIN)

/* En los 50 registros de la tabla ventas, todos los productis tienen al menos una venta realizada. Para que la consulta devuelva
resultados visinles, procedo a insertar nuevos productos que no hayan tenido ventas */

INSERT INTO productos VALUES (7, 'Webcam Full HD 1080p', 2, 75.00, 25, 1);
INSERT INTO productos VALUES (8, 'Parlante Bluetooth Mini', 3, 45.00, 30, 1);

SELECT
p.nombre_producto,
cat.nombre_categoria,
p.precio,
v.id_venta
FROM productos AS p
LEFT JOIN ventas AS v
	ON p.id_producto = v.id_producto
INNER JOIN categorias AS cat
	ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;

--- Consulta 4 — Consolidado por canal (UNION ALL) ---

/* Se dividen los 50 registros de ventas en dos canales.
Online: Ventas realizadas a los clientes con id_cliente impar (1, 3, 5, 7).
Presencial: Ventas realizadas a los clientes con id_cliente par (2, 4, 6). */

SELECT
canal,
COUNT(id_venta) AS cantidad_pedidos,
SUM(total_venta) AS total_facturado
FROM
	(
	-- Ventas del canal Online ---
	SELECT 
		id_venta,
		(cantidad * precio_unitario) AS total_venta,
		'Online' AS canal
	FROM ventas
	WHERE id_cliente % 2 <> 0

	UNION ALL

	-- Ventas del canal Presencial ---
	SELECT 
		id_venta,
		(cantidad * precio_unitario) AS total_venta,
		'Presencial' AS canal
	FROM ventas
	WHERE id_cliente % 2 = 0
	) AS ventas_canal
GROUP BY canal
ORDER BY total_facturado DESC;
