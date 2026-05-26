
/*
--RETO 1

--Inserciones válidas

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, segmento, estado)
VALUES ('CC', '1000000001', 'Laura Gómez', 'PERSONA', 'ACTIVO');

INSERT INTO ar_clientes VALUES (DEFAULT, 'CC', '1000000002', 'Carlos Pérez', 'PERSONA', 'ACTIVO');
INSERT INTO ar_clientes VALUES (DEFAULT, 'CC', '1000000003', 'Ana Torres', 'EMPRESA', 'ACTIVO');
INSERT INTO ar_clientes VALUES (DEFAULT, 'CC', '1000000004', 'Juan Medina', 'PERSONA', 'ACTIVO');
INSERT INTO ar_clientes VALUES (DEFAULT, 'CC', '1000000005', 'Sofía Ramírez', 'EMPRESA', 'ACTIVO');

--DEFAULT SEGMENTO
INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('NIT', '900000001-1', 'Alimentos El Buen Sabor', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('NIT', '900000002-1', 'Distribuciones La Central', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000006', 'María López', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000007', 'Diego Hernández', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000008', 'Natalia Ríos', 'ACTIVO');
--INACTIVO SIN SEGMENTO
INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000009', 'Pedro Salazar', 'INACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000010', 'Valentina Muñoz', 'INACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('NIT', '900000003-1', 'Comercializadora Norte', 'INACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('NIT', '900000004-1', 'Servicios Integrales SAS', 'INACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000011', 'Jorge Castillo', 'INACTIVO');

--DEFAULT ESTADO
INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
VALUES ('CC', '1000000012', 'Lucía Fernández');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
VALUES ('CC', '1000000013', 'Camilo Vargas');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
VALUES ('NIT', '900000005-1', 'Logística Andina');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
VALUES ('NIT', '900000006-1', 'Tecnología Global');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
VALUES ('CC', '1000000014', 'Paula Cárdenas');

--MÁS ACTIVOS
INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000015', 'Ricardo Molina', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000016', 'Daniela Ortiz', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('NIT', '900000007-1', 'Soluciones Empresariales', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000017', 'Andrés Quintero', 'ACTIVO');

INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000018', 'Juliana Pineda', 'ACTIVO');

--INSERCIONES INVÁLIDAS

--CASO A: DUPLICADO
--INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
--VALUES ('CC', '1000000001', 'Cliente Duplicado');
--ORA-00001: restricción única (G03_E01.UQ_AR_CLIENTES_DOC) violada
--CORRECIÓN:
INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
VALUES ('CC', '1999999999', 'Cliente Corregido');

--CASO B: ESTADO INVÁLIDO
--INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
--VALUES ('CC', '1000000200', 'Estado Malo', 'SUSPENDIDO');
--ORA-02290: restricción de control (G03_E01.CK_AR_CLIENTES_ESTADO) violada
--CORRECIÓN:
INSERT INTO ar_clientes (tipo_documento, num_documento, nombre, estado)
VALUES ('CC', '1000000200', 'Estado Bueno', 'ACTIVO');

--CASO C: FALTA UN NOT NULL
--INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
--VALUES ('NIT', '900000888-1', NULL);
--Error SQL: ORA-01400: no se puede realizar una inserción NULL en ("G03_E01"."AR_CLIENTES"."NOMBRE")
--CORRECIÓN
INSERT INTO ar_clientes (tipo_documento, num_documento, nombre)
VALUES ('NIT', '900000888-1', 'Empresa Corregida SAS');

--ROLLBACK
SELECT COUNT(*) FROM ar_clientes;
ROLLBACK;
SELECT COUNT(*) FROM ar_clientes;
--Al ejecutar ROLLBACK se deshicieron todas las inserciones realizadas desde 
--el último COMMIT (no habíamos realizado ningún COMMIT), por lo que la 
--tabla volvió a su estado original.

--COMMIT
COMMIT;

--VERIFICACIÓN FINAL
SELECT COUNT(*) FROM ar_clientes;

SELECT * FROM ar_clientes
*/

/*
--10 REGISTROS PARA LA TABLA ar_facturas
INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (32, 'F-1000', SYSDATE, SYSDATE + 30, 2500.00)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (36, 'F-1001', SYSDATE, SYSDATE + 10, 320.00)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (40, 'F-1002', SYSDATE-4, SYSDATE + 15, 75.49)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (48, 'F-1003', SYSDATE-15, SYSDATE + 20, 585.03)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (44, 'F-1004', SYSDATE-15, SYSDATE + 15, 1000.00)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (33, 'F-1005', SYSDATE-10, SYSDATE, 49.99)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (50, 'F-1006', SYSDATE, SYSDATE + 60, 4000.00)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (55, 'F-1007', SYSDATE-5, SYSDATE + 10, 67.70)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (37, 'F-1008', SYSDATE-30, SYSDATE, 438.00)


INSERT INTO ar_facturas (cliente_id, num_factura, fecha_emision, fecha_vencimiento, monto_total)
VALUES (56, 'F-1009', SYSDATE, SYSDATE + 90, 5500.00)


COMMIT;
*/

/*
--INSERTAMOS 10 PAGOS EN LA TABLA ar_pagos
INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (1, 1500);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (4, 270.80);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (7, 1500);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (7,2500 );

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (2, 100);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (9, 50);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (8, 27.7);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (3, 40);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (5, 500);

INSERT INTO ar_pagos (factura_id, monto_pago)
VALUES (10, 3000);

COMMIT;
*/

--INSERTAMOS 10 PAGOS EN LA TABLA ar_notas_credito
INSERT INTO ar_notas_credito (factura_id, motivo)
VALUES (1, 'ABONO 1 DE 2');

INSERT INTO ar_notas_credito (factura_id, motivo)
VALUES (4, 'ABONO 1 DE 2');

INSERT INTO ar_notas_credito (factura_id, motivo)
VALUES (7, 'ABONO 1 DE 2');

INSERT INTO ar_notas_credito (factura_id, motivo)
VALUES (7, 'ABONO 2 DE 2');

INSERT INTO ar_notas_credito (factura_id)
VALUES (2)

INSERT INTO ar_notas_credito (factura_id, motivo)
VALUES (9, 'ABONO 1 DE 3');

INSERT INTO ar_notas_credito (factura_id)
VALUES (8)

INSERT INTO ar_notas_credito (factura_id)
VALUES (3)

INSERT INTO ar_notas_credito (factura_id, motivo)
VALUES (5, 'ABONO 1 DE 2');

INSERT INTO ar_notas_credito (factura_id, motivo)
VALUES (10, 'PAGA  EL SIGUIENTE MES EL FALTANTE');

COMMIT;

*/

--SALDO EXACTO POR NUMERO DE CLIENTE
--CALCULAR EL SALDO POR NOMBRE DE CLIENTE
SELECT c.nombre, NVL(SUM(f.monto_total),0) - NVL(SUM(p.monto_pago),0) - NVL(SUM(nc.devolucion),0) AS saldo
FROM ar_facturas f
LEFT JOIN ar_pagos p ON p.factura_id = f.factura_id
LEFT JOIN ar_notas_credito nc ON nc.factura_id = f.factura_id
LEFT JOIN ar_clientes c on c.cliente_id = f.cliente_id
GROUP BY c.nombre;

--SALDO TOTAL DE UN CLIENTE NEGATIVO
--1. 
SELECT f.factura_id
FROM ar_facturas f
LEFT JOIN ar_clientes c ON c.cliente_id = f.cliente_id
WHERE c. nombre = 'Ricardo Vélez'

--2. Encontramos los pagos asociados con las facturas de la consulta anterior
SELECT f.monto_total as valor_factura, p.pagos_id, p.monto_pago, nc.devolucion
FROM ar_pagos p
LEFT JOIN ar_notas_credito nc ON p.factura_id = nc.factura_id
LEFT JOIN ar_facturas f ON p.factura_id = f.factura_id
WHERE p.factura_id= 50

--3. Cambiar la devolución o el pago
UPDATE ar_pagos
SET monto_pago = 1
WHERE pagos_id = 80
--para cambiar devolución
--UPDATE ar_notas_credito
--SET monto_pago = 1
--WHERE factura_id = 80

COMMIT;

*/

SELECT f.factura_id
FROM ar_facturas f
LEFT JOIN ar_clientes c ON c.cliente_id = f.cliente_id
WHERE c. nombre = 'Distribuciones La Central'

SELECT f.monto_total as valor_factura, p.pagos_id, p.monto_pago, nc.devolucion
FROM ar_pagos p
LEFT JOIN ar_notas_credito nc ON p.factura_id = nc.factura_id
LEFT JOIN ar_facturas f ON p.factura_id = f.factura_id
WHERE p.factura_id= 26

UPDATE ar_pagos
SET monto_pago = 30
WHERE pagos_id = 68

COMMIT;

*/

SELECT f.factura_id
FROM ar_facturas f
LEFT JOIN ar_clientes c ON c.cliente_id = f.cliente_id
WHERE c. nombre = 'Paula Cárdenas'

SELECT f.monto_total as valor_factura, p.pagos_id, p.monto_pago, nc.devolucion
FROM ar_pagos p
LEFT JOIN ar_notas_credito nc ON p.factura_id = nc.factura_id
LEFT JOIN ar_facturas f ON p.factura_id = f.factura_id
WHERE p.factura_id= 35

UPDATE ar_pagos
SET monto_pago = 150
WHERE pagos_id = 69


COMMIT;

*/

--2.ACTUALIZAMOS LA INFORMACIÓN DE LA TABLA DE FACTURAS PARA LA NUEVA COLUMNA ESTADO_PAGO
UPDATE ar_facturas f
SET estado_pago =
    CASE
        WHEN(
            f.monto_total
            - NVL ((SELECT SUM(p.monto_pago) FROM ar_pagos p
              WHERE p.factura_id = f.factura_id), 0)
            - NVL ((SELECT SUM (nc.devolucion)FROM ar_notas_credito nc
              WHERE nc.factura_id = f.factura_id),0)
        ) <= 0 THEN 'PAGADA'
        ELSE 'NO PAGADA'
    END;
COMMIT;


--MODIFICAR LOS DATOS YA EXISTENTES EN PAGOS Y NOTAS CRÉDITO PARA AGREGARLE LAS FECHAS
UPDATE ar_pagos p
SET fecha_pago = (
    SELECT f.fecha_emision + 10
    FROM ar_facturas f
    WHERE f.factura_id = p.factura_id
    )
WHERE fecha_pago IS NULL;

--SE UTILIZA ON CUANDO SIEMPRE SE CUMPLE, WHERE PARA CASOS ESPECÍFICOS
----
UPDATE ar_notas_credito nc
SET fecha_nota = (
    SELECT f.fecha_emision + 15
    FROM ar_facturas f
    WHERE f.factura_id = nc.factura_id
    )
WHERE fecha_nota IS NULL;

COMMIT;


/***********************************************************
                    EJERCICIO HOTEL/AIRBNB
************************************************************/

--HUESPEDES
INSERT INTO ht_huespedes (tipo_doc, num_doc, nombre, email, estado)
    VALUES ('CC', '1020304050', 'Ana Torres', 'ana@email.com', 'ACTIVO');
    
INSERT INTO ht_huespedes (tipo_doc, num_doc, nombre, email, estado)
    VALUES ('CE', '987654321', 'Carlos Ruiz', 'cruiz@email.com', 'ACTIVO');
    
INSERT INTO ht_huespedes (tipo_doc, num_doc, nombre, email, estado)
    VALUES ('CC', '5566778899', 'Laura Mesa', 'lmesa@email.com', 'ACTIVO');
    
--HABITACIONES
INSERT INTO ht_habitaciones (num_habitacion, tipo, precio_noche, estado)
    VALUES ('101', 'ESTANDAR', '150000', 'DISPONIBLE');

INSERT INTO ht_habitaciones (num_habitacion, tipo, precio_noche, estado)
    VALUES ('205', 'SUITE', '350000', 'DISPONIBLE');
    
INSERT INTO ht_habitaciones (num_habitacion, tipo, precio_noche, estado)
    VALUES ('310', 'EJECUTIVA', '220000', 'DISPONIBLE');
    
--RESERVAS
--Reserva 1: Ana, Hab 101, 3 noches, vencida hace 10 días
INSERT INTO ht_reservas (huesped_id, habitacion_id, fecha_ingreso, fecha_salida, monto_total, estado)
    VALUES (1, 1, TRUNC(SYSDATE)-13, TRUNC(SYSDATE)-10, 450000, 'TERMINADA');

--Reserva 2: Carlos, hab 205, 2 noches, activa
INSERT INTO ht_reservas (huesped_id, habitacion_id, fecha_ingreso, fecha_salida, monto_total, estado)
    VALUES (2, 2, TRUNC(SYSDATE)+2, TRUNC(SYSDATE)+4, 700000, 'ACTIVA');

--Reserva 3: Laura, hab 310, cancelada
INSERT INTO ht_reservas (huesped_id, habitacion_id, fecha_ingreso, fecha_salida, monto_total, estado)
    VALUES (3, 3, TRUNC(SYSDATE)+5, TRUNC(SYSDATE)+7, 440000, 'CANCELADA');
    
--PAGOS
INSERT INTO ht_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, referencia)
    VALUES (1, TRUNC(SYSDATE)-12, 200000, 'TRANSFERENCIA', 'TRF-001');
    
INSERT INTO ht_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, referencia)
    VALUES (1, TRUNC(SYSDATE)-10, 150000, 'PSE', 'PSE-002');

INSERT INTO ht_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, referencia)
    VALUES (2, TRUNC(SYSDATE)+1, 350000, 'TARJETA', 'TC-001');

--NOTA DE CANCELACIÓN para reserva 3
INSERT INTO ht_notas_cancelacion (reserva_id, fecha_nota, monto_devolucion, motivo)
    VALUES (3, TRUNC(SYSDATE), 440000, 'CANCELACIÓN_HUESPED');

COMMIT;


/***********************************************************
                    EJERCICIO CORE STUDIO 
************************************************************/

--Entrenadores
INSERT INTO cs_entrenadores (nombre_entrenador) VALUES ('Nicole Peláez');
INSERT INTO cs_entrenadores (nombre_entrenador) VALUES ('Valeria Marin');
INSERT INTO cs_entrenadores (nombre_entrenador) VALUES ('Sara Vásquez');
INSERT INTO cs_entrenadores (nombre_entrenador) VALUES ('Camila Herrera');
INSERT INTO cs_entrenadores (nombre_entrenador) VALUES ('Daniela Ospina');

--Clientes
INSERT INTO cs_clientes (tipo_doc, num_doc, nombre, email, telefono) 
VALUES ('CC', '1023456789', 'Mariana Gómez', 'mariana.g@gmail.com', '3101234567');

INSERT INTO cs_clientes (tipo_doc, num_doc, nombre, email, telefono) 
VALUES ('CC', '1098765432', 'Juliana Pérez', 'juliana.p@gmail.com', '3209876543');

INSERT INTO cs_clientes (tipo_doc, num_doc, nombre, email, telefono) 
VALUES ('CE', '987654321', 'Andrés Ospina', 'andres.o@gmail.com', '3157654321');

INSERT INTO cs_clientes (tipo_doc, num_doc, nombre, email, telefono) 
VALUES ('CC', '1112223334', 'Gabriela Ríos', 'gabriela.r@gmail.com', '3001112233');

INSERT INTO cs_clientes (tipo_doc, num_doc, nombre, email, telefono) 
VALUES ('PA', 'AB123456', 'Natalia Cruz', 'natalia.c@gmail.com', '3184445566');

--Clases
INSERT INTO cs_clases (entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES (1, 'PILATES REFORMER', 'LUNES', '07:00', 80000, 'RESERVADA');

INSERT INTO cs_clases (entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES (2, 'HOT PILATES', 'MARTES', '08:00', 75000, 'RESERVADA');

INSERT INTO cs_clases (entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES (3, 'BARRÉ', 'MIÉRCOLES', '09:00', 70000, 'DISPONIBLE');

INSERT INTO cs_clases (entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES (4, 'HIPOPRESIVOS', 'JUEVES', '10:00', 65000, 'RESERVADA');

INSERT INTO cs_clases (entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES (5, 'PILATES REFORMER', 'VIERNES', '11:00', 80000, 'DISPONIBLE');

--Reservas
INSERT INTO cs_reservas (cliente_id, clase_id, fecha_reserva, monto_total, estado)
VALUES (1, 1, DATE '2025-05-01', 80000, 'ACTIVA');

INSERT INTO cs_reservas (cliente_id, clase_id, fecha_reserva, monto_total, estado)
VALUES (2, 2, DATE '2025-05-06', 75000, 'TERMINADA');

INSERT INTO cs_reservas (cliente_id, clase_id, fecha_reserva, monto_total, estado)
VALUES (3, 4, DATE '2025-05-10', 65000, 'CANCELADA');

INSERT INTO cs_reservas (cliente_id, clase_id, fecha_reserva, monto_total, estado)
VALUES (4, 1, DATE '2025-05-12', 80000, 'NO LLEGÓ');

INSERT INTO cs_reservas (cliente_id, clase_id, fecha_reserva, monto_total, estado)
VALUES (5, 2, DATE '2025-05-15', 75000, 'ACTIVA');

--Pagos
INSERT INTO cs_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, estado)
VALUES (1, DATE '2025-05-01', 80000, 'TARJETA DE CRÉDITO', 'PAGADO');

INSERT INTO cs_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, estado)
VALUES (2, DATE '2025-05-06', 75000, 'TRANSFERENCIA', 'PAGADO');

INSERT INTO cs_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, estado)
VALUES (3, DATE '2025-05-10', 65000, 'EFECTIVO', 'PAGADO');

INSERT INTO cs_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, estado)
VALUES (4, DATE '2025-05-12', 80000, 'TARJETA DE CRÉDITO', 'PENDIENTE');

INSERT INTO cs_pagos (reserva_id, fecha_pago, monto_pago, canal_pago, estado)
VALUES (5, DATE '2025-05-15', 75000, 'TRANSFERENCIA', 'PAGADO');

--Notas cancelación
INSERT INTO cs_notas_cancelacion (reserva_id, fecha_nota, monto_devolucion, motivo)
VALUES (3, DATE '2025-05-11', 65000, 'CANCELACION');

--Cambios de datos
UPDATE cs_reservas
SET fecha_reserva = DATE '2026-06-01'
WHERE reserva_id = 1;

UPDATE cs_reservas
SET fecha_reserva = DATE '2026-05-29'
WHERE reserva_id = 5;


UPDATE cs_entrenadores
SET especialidad = 'Pilates Reformer',
    experiencia_anios = 5,
    formacion = 'Profesional en deportes - Politécnico Colombiano Jaime Isaza Cadavid'
WHERE entrenador_id = 1;


UPDATE cs_entrenadores
SET especialidad = 'Yoga y Hot pilates',
    experiencia_anios = 3,
    formacion = 'Entrenamiento Deportivo - UDEA'
WHERE entrenador_id = 2;

UPDATE cs_entrenadores
SET especialidad = 'Barré y tonificación muscular',
    experiencia_anios = 4,
    formacion = 'Fisioterapia - Universidad CES'
WHERE entrenador_id = 3;

UPDATE cs_entrenadores
SET especialidad = 'Pilates terapéutico',
    experiencia_anios = 6,
    formacion = 'Rehabilitación Física - UDEA'
WHERE entrenador_id = 4;

UPDATE cs_entrenadores
SET especialidad = 'Hipopresivos y core avanzado',
    experiencia_anios = 7,
    formacion = 'Entrenamiento Funcional - Instituto Europeo de Fitness'
WHERE entrenador_id = 5;

--MÁS INSERT INTO EN CLASES:
INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(1, 'PILATES REFORMER', 'LUNES', '18:00', 80000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(2, 'HOT PILATES', 'LUNES', '09:00', 75000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(3, 'BARRÉ', 'MARTES', '17:00', 70000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(4, 'HIPOPRESIVOS', 'MARTES', '15:00', 65000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(5, 'PILATES REFORMER', 'MIÉRCOLES', '11:00', 80000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(2, 'HOT PILATES', 'MIÉRCOLES', '16:00', 75000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(3, 'BARRÉ', 'JUEVES', '12:00', 70000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(4, 'HIPOPRESIVOS', 'JUEVES', '18:00', 65000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(1, 'PILATES REFORMER', 'VIERNES', '09:00', 80000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(5, 'HOT PILATES', 'VIERNES', '15:00', 75000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(3, 'BARRÉ', 'SÁBADO', '09:00', 70000, 'DISPONIBLE');

INSERT INTO cs_clases
(entrenador_id, nombre_clase, dia_semana, hora_clase, precio, estado)
VALUES
(4, 'HIPOPRESIVOS', 'SÁBADO', '10:00', 65000, 'DISPONIBLE');


COMMIT;







