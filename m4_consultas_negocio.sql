/* En la Pre-Entrega 3 teníamos lo siguiente:

CREATE TABLE ventas(
id_venta INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
id_cliente INT FOREIGN KEY REFERENCES clientes(id_cliente),
id_producto INT FOREIGN KEY REFERENCES productos(id_producto),
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
fecha_venta DATE NOT NULL
);

INSERT INTO ventas VALUES (1, 1, 1, 2, 1200, '2024-03-05');
INSERT INTO ventas VALUES (2, 2, 2, 5, 28, '2024-03-06');
INSERT INTO ventas VALUES (3, 3, 3, 1, 450, '2024-03-07');
INSERT INTO ventas VALUES (4, 1, 4, 2, 120, '2024-03-08');
INSERT INTO ventas VALUES (5, 4, 5, 3, 130, '2024-03-10');
INSERT INTO ventas VALUES (6, 2, 6, 4, 95, '2024-03-11');
INSERT INTO ventas VALUES (7, 5, 1, 1, 1200, '2024-03-12');
INSERT INTO ventas VALUES (8, 3, 2, 8, 28, '2024-03-13');
INSERT INTO ventas VALUES (9, 4, 4, 1, 120, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2, 450, '2024-03-15'); */

-----------------------
  /* Pre_Entrega 4 */
-----------------------

/* Agrego filas de datos a la tabla ventas para que el análisis sea más rico, 
dado que los 10 datos que están, todos tienen el mismo mes de venta */

INSERT INTO ventas VALUES (11, 5, 5, 5, 130, '2024-01-03');
INSERT INTO ventas VALUES (12, 2, 3, 4, 450, '2024-01-12');
INSERT INTO ventas VALUES (13, 1, 6, 4, 95, '2024-01-23');
INSERT INTO ventas VALUES (14, 3, 1, 4, 1200, '2024-01-26');
INSERT INTO ventas VALUES (15, 5, 1, 2, 1200, '2024-02-10');
INSERT INTO ventas VALUES (16, 4, 2, 5, 28, '2024-02-15');
INSERT INTO ventas VALUES (17, 3, 5, 5, 130, '2024-02-20');
INSERT INTO ventas VALUES (18, 2, 4, 2, 120, '2024-02-23');
INSERT INTO ventas VALUES (19, 1, 2, 2, 130, '2024-04-04');
INSERT INTO ventas VALUES (20, 2, 5, 1, 130, '2024-04-13');
INSERT INTO ventas VALUES (21, 3, 1, 1, 1200, '2024-04-24');
INSERT INTO ventas VALUES (22, 5, 4, 1, 120, '2024-04-27');
INSERT INTO ventas VALUES (23, 3, 1, 2, 1200, '2024-05-05');
INSERT INTO ventas VALUES (24, 4, 4, 2, 120, '2024-05-07');
INSERT INTO ventas VALUES (25, 1, 2, 2, 28, '2024-05-17');
INSERT INTO ventas VALUES (26, 5, 4, 3, 120, '2024-06-03');
INSERT INTO ventas VALUES (27, 4, 6, 6, 95, '2024-06-08');
INSERT INTO ventas VALUES (28, 2, 3, 1, 450, '2024-06-15');
INSERT INTO ventas VALUES (29, 3, 3, 2, 450, '2024-07-11');
INSERT INTO ventas VALUES (30, 4, 1, 1, 1200, '2024-07-12');
INSERT INTO ventas VALUES (31, 1, 3, 1, 450, '2024-07-22');
INSERT INTO ventas VALUES (32, 2, 2, 5, 28, '2024-08-06');
INSERT INTO ventas VALUES (33, 5, 4, 3, 120, '2024-08-15');
INSERT INTO ventas VALUES (34, 4, 3, 1, 450, '2024-08-21');
INSERT INTO ventas VALUES (35, 2, 6, 10, 95, '2024-09-12');
INSERT INTO ventas VALUES (36, 3, 4, 2, 120, '2024-09-15');
INSERT INTO ventas VALUES (37, 5, 2, 10, 28, '2024-09-29');
INSERT INTO ventas VALUES (38, 1, 1, 2, 1200, '2024-09-29');
INSERT INTO ventas VALUES (39, 2, 4, 2, 120, '2024-10-05');
INSERT INTO ventas VALUES (40, 3, 3, 2, 450, '2024-10-14');
INSERT INTO ventas VALUES (41, 5, 2, 2, 28, '2024-10-25');
INSERT INTO ventas VALUES (42, 3, 2, 1, 1200, '2024-10-28');
INSERT INTO ventas VALUES (43, 2, 3, 8, 450, '2024-11-06');
INSERT INTO ventas VALUES (44, 3, 5, 8, 130, '2024-11-11');
INSERT INTO ventas VALUES (45, 2, 1, 1, 1200, '2024-11-13');
INSERT INTO ventas VALUES (46, 5, 3, 1, 450, '2024-11-21');
INSERT INTO ventas VALUES (47, 1, 4, 5, 120, '2024-12-05');
INSERT INTO ventas VALUES (48, 3, 5, 4, 130, '2024-12-15');
INSERT INTO ventas VALUES (49, 5, 3, 2, 450, '2024-12-20');
INSERT INTO ventas VALUES (50, 1, 1, 2, 1200, '2024-12-24');



--- Consulta 1 — Resumen ejecutivo mensual ---

SELECT
DATEPART(MONTH, fecha_venta) AS mes_venta,
SUM (cantidad * precio_unitario) AS total_facturado,
COUNT (id_venta) AS cantidad_pedidos,
CAST (AVG (cantidad * precio_unitario) AS DECIMAL (10,2)) AS ticket_prom
FROM ventas
GROUP BY DATEPART(MONTH, fecha_venta)
ORDER BY DATEPART(MONTH, fecha_venta) ASC;

		---  VARIANTE 1: Para ver el porcentaje de facturación total que representa cada mes --

		SELECT
		DATEPART(MONTH, fecha_venta) AS mes_venta,
		SUM (cantidad * precio_unitario) AS total_facturado,
		CAST(SUM (cantidad * precio_unitario) * 100 / SUM(SUM (cantidad * precio_unitario)) OVER() AS DECIMAL(10,2)) AS porcentaje_facturacion,
		COUNT (id_venta) AS cantidad_pedidos,
		CAST (AVG (cantidad * precio_unitario) AS DECIMAL (10,2)) AS ticket_prom
		FROM ventas
		GROUP BY DATEPART(MONTH, fecha_venta)
		ORDER BY total_facturado DESC;


--- Consulta 2 — Ranking de productos ---

SELECT TOP 5
id_producto,
SUM (cantidad * precio_unitario) AS total_facturado,
SUM(cantidad) AS total_unidades
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

		--- Aclaración 1: al ser 5 productos solamente, el top 5 muestra todos, para poner en práctica la sintaxis, pondé el top 3 ---
		--- Aclaración 2: no funciona la cláusula LIMIT por eso puse la sentencia SELECT TOP 3 ---


		SELECT TOP 3
		id_producto,
		SUM (cantidad * precio_unitario) AS total_facturado,
		SUM(cantidad) AS total_unidades,
		CAST(SUM (cantidad * precio_unitario) * 100 / SUM(SUM (cantidad * precio_unitario)) OVER() AS DECIMAL(10,2)) AS porcentaje_facturacion
		FROM ventas
		GROUP BY id_producto
		ORDER BY total_facturado DESC;


--- Consulta 3 — Clientes recurrentes ---

SELECT 
id_cliente,
COUNT (*) AS cantidad_pedidos,
SUM (cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1;

		--- Variante 1: ordeno por total facturado de manera descendente mostrando el TOP 3 de clientes ---

		SELECT TOP 3
		id_cliente,
		COUNT (*) AS cantidad_pedidos,
		SUM (cantidad * precio_unitario) AS total_facturado
		FROM ventas
		GROUP BY id_cliente
		HAVING COUNT (*) > 1
		ORDER BY total_facturado DESC;

		--- Variante 2: Para calcular el porcentaje de facturación total que representa cada cliente --- 

		SELECT TOP 3
		id_cliente,
		COUNT (*) AS cantidad_pedidos,
		SUM (cantidad * precio_unitario) AS total_facturado,
		CAST(SUM (cantidad * precio_unitario) * 100 / SUM(SUM (cantidad * precio_unitario)) OVER() AS DECIMAL(10,2)) AS porcentaje_facturacion
		FROM ventas
		GROUP BY id_cliente
		HAVING COUNT (*) > 1
		ORDER BY total_facturado DESC;



--- Consulta 4 — Meses por encima/por debajo del promedio ---

SELECT
DATEPART(month,fecha_venta) AS mes_venta,
SUM(cantidad*precio_unitario) AS total_facturado,
AVG(SUM(cantidad*precio_unitario)) OVER() AS promedio_mensual,
CASE
	WHEN SUM(cantidad*precio_unitario) > AVG(SUM(cantidad*precio_unitario)) OVER() 
		THEN 'Por encima del promedio mensual'
	WHEN SUM(cantidad*precio_unitario) < AVG(SUM(cantidad*precio_unitario)) OVER() 
		THEN 'Por debajo del promedio mensual'
	ELSE 'Igual al promedio mensual'
END AS comparacion_promedio
FROM ventas
GROUP BY DATEPART(month,fecha_venta)
ORDER BY mes_venta;


--- HALLAZGOS ---
--- 1. Enero fue el mes de mayor facturación representando aproximadamente el 17% de la facturacion anual ---
--- 2. El mes de agosto registra la menor facturación del año con $950, representando el 2% de la facturación anual . ---
--- 3. El producto 1 fue el de mayor facturación concentrando aproximadamente el 49% de la facturación total ---
--- 4. La facturación promedio mensual fue de aproximadamente $3.647; Enero, Marzo, Septiembre, Noviembre y Diciembre superaron este promedio. ---


--- 5. El cliente 3 concentra el 33,19% de la facturación total, siendo el cliente de mayor aporte. --- 



