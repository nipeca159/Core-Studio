# Core-Studio
El proyecto final consiste en el desarrollo de una plataforma digital para Core Studio, un estudio de pilates enfocado en el bienestar y el movimiento. La aplicación permite gestionar clases, reservas y asistencia de usuarios de manera organizada y eficiente, mejorando tanto la experiencia de los clientes como la administración del estudio.

## Descripción del sistema
Este proyecto consiste en el desarrollo de una aplicación web para la gestión de un estudio de pilates llamado Core Studio. La plataforma permite administrar entrenadores, visualizar clases disponibles, realizar reservas y cancelar clases de manera sencilla e interactiva. El sistema fue desarrollado utilizando Python, Streamlit y Oracle Database.

## Integrantes del grupo
- Nicole Peláez  
- Valeria Marín

## Dominio elegido y justificación
El dominio elegido fue el de bienestar y actividad física, específicamente un estudio de pilates. Se escogió este tema porque actualmente es un sector en crecimiento. Además, nos gusta mucho el movimeinto y los deportes

## Diagrama ERD
<img width="1151" height="571" alt="CORE STUDIO drawio" src="https://github.com/user-attachments/assets/4b967e4e-ccb8-4129-a949-ef36fcc39ac6" />

## Descripción de las tablas y restricciones
### Tabla Entrenadores (`cs_entrenadores`)
Almacena la información de los entrenadores del estudio.

**Restricciones:**
- `entrenador_id` es llave primaria.
- El nombre del entrenador es obligatorio (`NOT NULL`).

### Tabla Clientes (`cs_clientes`)
Guarda la información de los clientes registrados en la plataforma.

**Restricciones:**
- `cliente_id` es llave primaria.
- El tipo y número de documento son obligatorios.
- No pueden existir dos clientes con el mismo documento (`UNIQUE`).
- El nombre del cliente es obligatorio.

### Tabla Clases (`cs_clases`)
Contiene la información de las clases disponibles en el estudio.

**Restricciones:**
- `clase_id` es llave primaria.
- Cada clase debe estar asociada a un entrenador existente (`FOREIGN KEY`).
- No pueden existir dos clases en el mismo día y hora (`UNIQUE`).
- El estado solo puede ser `DISPONIBLE` o `RESERVADA`.
- El día de la semana solo puede ser:
  - LUNES
  - MARTES
  - MIÉRCOLES
  - JUEVES
  - VIERNES
  - SÁBADO
- El nombre de la clase solo puede ser:
  - PILATES REFORMER
  - HOT PILATES
  - BARRÉ
  - HIPOPRESIVOS
- El precio no puede ser negativo.
- La duración de la clase debe ser de 60 minutos.
- La hora debe tener formato válido (`HH:MM`).

### Tabla Reservas (`cs_reservas`)
Registra las reservas realizadas por los clientes.

**Restricciones:**
- `reserva_id` es llave primaria.
- La reserva debe estar asociada a un cliente y una clase existentes (`FOREIGN KEY`).
- El monto total no puede ser negativo.
- El estado solo puede ser:
  - ACTIVA
  - CANCELADA
  - TERMINADA
  - NO LLEGÓ
- La fecha de reserva es obligatoria.
- No pueden existir reservas duplicadas para la misma clase y fecha (`UNIQUE`).

### Tabla Pagos (`cs_pagos`)
Almacena la información de los pagos realizados por las reservas.

**Restricciones:**
- `pago_id` es llave primaria.
- El pago debe estar asociado a una reserva existente (`FOREIGN KEY`).
- Solo puede existir un pago por reserva (`UNIQUE`).
- El monto del pago no puede ser negativo.
- El estado del pago solo puede ser:
  - PAGADO
  - PENDIENTE
- El canal de pago solo puede ser:
  - TARJETA DE CRÉDITO
  - TRANSFERENCIA
  - EFECTIVO

  ### Tabla Notas de Cancelación (`cs_notas_cancelacion`)
Guarda la información relacionada con devoluciones o cancelaciones de reservas.

**Restricciones:**
- `nota_id` es llave primaria.
- La nota debe estar asociada a una reserva existente (`FOREIGN KEY`).
- El monto de devolución no puede ser negativo.
- La fecha de la nota es obligatoria.


## Reglas de negocio implementadas

- Un usuario no puede reservar una clase que ya esté llena.
- Un usuario no puede reservar la misma clase más de una vez.
- Las reservas pueden cancelarse antes de la clase.
- Las clases muestran disponibilidad según los cupos restantes.
- Cada clase debe estar asociada a un profesor.
- No se permiten pagos parciales
  
## Capturas de pantalla de la aplicación
<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 20 26 p m" src="https://github.com/user-attachments/assets/8aff881e-4be6-48df-aeff-7f47a0da9cfa" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 20 40 p m" src="https://github.com/user-attachments/assets/b7d4254c-bc52-457e-b077-83fe6f00edfd" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 20 54 p m" src="https://github.com/user-attachments/assets/f0ea1481-bf9a-457a-9b5a-85fe22d35413" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 21 04 p m" src="https://github.com/user-attachments/assets/8c2df3ce-c71d-40ce-8aae-f76a21aea6f9" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 21 13 p m" src="https://github.com/user-attachments/assets/e2085281-d73b-4658-a6a5-50d7aed77bcb" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 21 24 p m" src="https://github.com/user-attachments/assets/1d816c63-f2b1-4269-a6e2-11a0c49fe451" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 21 30 p m" src="https://github.com/user-attachments/assets/2c785dec-521f-4ae0-baef-5300bed7a900" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 21 45 p m" src="https://github.com/user-attachments/assets/2f8f8774-c116-4a89-aaa6-412e9587f09a" />

<img width="1440" height="900" alt="Captura de pantalla 2026-05-26 a la(s) 7 21 53 p m" src="https://github.com/user-attachments/assets/55fa0f74-0242-453c-942f-c22e3cd0892f" />

## Reflexión del equipo

Este proyecto fue una experiencia muy importante porque nos permitió aprender tanto sobre programación como sobre organización y trabajo en equipo. Desarrollamos una página web para un estudio de pilates utilizando herramientas como PyCharm y Oracle Database, donde implementamos funciones como visualización de profesores, consulta de clases, reservas y cancelaciones.

Uno de los aprendizajes más grandes fue entender la importancia de planear bien la base de datos antes de comenzar a programar. Al principio realizamos muchos cambios en las tablas porque, mientras avanzábamos, descubríamos que algunas cosas faltaban y otras no eran necesarias. Esto hizo que la estructura comenzara a desorganizarse y fuera más difícil trabajar.

Por esta razón, decidimos detenernos y reconstruir gran parte del proyecto desde cero, pero esta vez con una mejor planeación y una estructura más clara. Aunque parecía una decisión complicada, terminó ayudándonos mucho porque redujimos errores y logramos trabajar de una manera más ordenada y eficiente. Entendimos que una buena estructura desde el inicio facilita muchísimo el desarrollo de todo el sistema.

También aprendimos a pensar mejor las relaciones entre tablas y a enfocarnos más en la lógica y en la experiencia del usuario. Descubrimos que muchas veces las soluciones más simples son las más efectivas.

Además, disfrutamos mucho la parte visual del proyecto, investigando cómo agregar imágenes, personalizar la interfaz y añadir animaciones para mejorar la experiencia dentro de la aplicación. Esto hizo que el desarrollo fuera más creativo y dinámico.

En conclusión, este proyecto nos ayudó a fortalecer conocimientos en bases de datos, programación y desarrollo web, pero también nos enseñó la importancia de la planeación, la organización y la capacidad de corregir errores y mejorar continuamente durante el proceso.
