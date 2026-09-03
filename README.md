Justificaciones del perfilado de datos del archivo Pipeline_ETL_Propedo_Eugenia (Pre Entrega 6)
1)	Registros nulos en Clientes
•	Se decide reemplazar los nulos en email y ciudad por "Sin Email" y "Sin Ciudad".
Justificación: Los clientes 9 y 11 tienen compras registradas. Si se borran, se pierden esas ventas en los reportes y baja la facturación total. Usar etiquetas por defecto permite conservar el 100% del dinero vendido y poder filtrarlos sin problemas.
2)	Registros nulos en Productos
•	Categoría nula: Se decide asignar la categoría "Computación".
Justificación: El producto es una "Laptop Gaming Pro". Por su nombre y subcategoría es evidente que pertenece a la categoría Computación. Asignarle su categoría correcta mejora la calidad de los datos y evita crear grupos vacíos en los reportes.
•	Precio nulo: se decide conservar el producto e imputar el precio en $130.
Justificación: Tras revisar la tabla ventas, se identificó que el id_producto = 109 registra 5 ventas históricas con un precio_unitario constante de $130. Eliminar el producto dejaría 5 transacciones de ventas reales de dicho producto sin registro. Imputar el precio basándose en la evidencia histórica de la tabla de hechos permite mantener el 100% de la facturación y ofrecer la información completa del catálogo en los reportes finales.

