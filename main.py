import streamlit as st
import pandas as pd
import numpy as np
from datetime import date
import oracledb
import os

from dotenv import load_dotenv
load_dotenv()



def conectar():
    return oracledb.connect(
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        dsn=os.getenv("DB_DSN"),
        config_dir=os.getenv("WALLET_DIR"),
        wallet_location=os.getenv("WALLET_DIR"),
        wallet_password=os.getenv("WALLET_PASSWORD")
    )


def consultar(sql):
    conn = conectar()
    df = pd.read_sql(sql, conn)
    conn.close()
    return df


def ejecutar(sql):
    conn = conectar()
    cur = conn.cursor()
    cur.execute(sql)
    conn.commit()
    conn.close()

#----------------TÍTULOS Y DESCRIPCIÓN------------
st.set_page_config(page_title= "Core Studio Pilates 🧘‍♀️", layout = "wide")
st.title("Core Studio Pilates 🧘‍♀️")
st.subheader("Sistema de reservas y control de clases")
st.write("""
Bienvenido a Core Studio Pilates.

Esta plataforma permite gestionar:
- Clases disponibles por horario
- Reservas personalizadas 1:1
- Pagos y control de asistencia
""")

#-----------------MENÚ LATERAL--------------------
st.sidebar.header("Menú")

pagina = st.sidebar.radio("Seleccione una opción", ["Entrenadores 👩🏻‍💼",
                                                    "Clases 🤸‍♂️",
                                                    "Reservas 📅",
                                                    "Pagos 💳",
                                                    "Cancelación 📝"])

# Creamos dos columnas en la pantalla principal
col_1, col_2 = st.columns(2)

with col_1:
    st.write()

with col_2:
    st.write(f"Sección activa: **{pagina}**")

st.divider()

#-------------------------ENTRENADORES---------------------
if pagina == "Entrenadores 👩🏻‍💼":
    st.subheader("Nuestro equipo de entrenadores 💪🏻")

    entrenadores = consultar("""
        SELECT entrenador_id, nombre_entrenador
        FROM cs_entrenadores
        ORDER BY entrenador_id
        """)
    fotos = {
        1: "https://img.magnific.com/vector-gratis/mujer-sonriente-cabello-trenzado_1308-174961.jpg",
        2: "https://img.freepik.com/vector-gratis/mujer-sonriente-cabello-rojo_1308-175663.jpg?semt=ais_hybrid&w=740&q=80",
        3: "https://img.freepik.com/vector-gratis/mujer-pelo-rojo-largo_1308-181382.jpg?semt=ais_hybrid&w=740&q=80",
        4: "https://img.magnific.com/vector-gratis/mujer-sonriente-cabello-largo_1308-174705.jpg?semt=ais_hybrid&w=740&q=80",
        5: "https://img.magnific.com/vector-gratis/mujer-sonriente-vestido-flores_1308-173616.jpg?semt=ais_hybrid&w=740&q=80"
    }
    #Cada fila es un entrenador

    entrenadores = consultar("""
        SELECT entrenador_id,
               nombre_entrenador,
               especialidad,
               experiencia_anios,
               formacion
        FROM cs_entrenadores
    """)
    #Cada fila es un entrenador
    for _, row in entrenadores.iterrows():
        col1, col2 = st.columns([1, 3])

        with col1:
            st.image(fotos.get(row["ENTRENADOR_ID"], ""), width=120)

        with col2:
            st.markdown(f"""
            ### {row['NOMBRE_ENTRENADOR']}

            🧘 Especialidad: {row['ESPECIALIDAD']}  
            📚 Formación: {row['FORMACION']}  
            ⏳ Experiencia: {row['EXPERIENCIA_ANIOS']} años  

            Entrenador del estudio Core Studio 💜
            """)
#--------------------------CONSULTAR CLASES------------------------------
elif pagina == "Clases 🤸‍♂️":
    st.subheader("Clases disponibles 🌟")
    estado = st.selectbox(
        "Filtrar por estado",
        ["DISPONIBLE", "RESERVADA"]
    )
    clases = consultar(f"""
        SELECT c.nombre_clase,
               c.dia_semana,
               c.hora_clase,
               c.precio,
               c.estado,
               e.nombre_entrenador,
               cl.nombre AS cliente,
               r.fecha_reserva
        FROM cs_clases c
        JOIN cs_entrenadores e
        ON c.entrenador_id = e.entrenador_id
        LEFT JOIN cs_reservas r
        ON c.clase_id = r.clase_id
        LEFT JOIN cs_clientes cl
        ON r.cliente_id = cl.cliente_id
        WHERE c.estado = '{estado}'
            AND (r.fecha_reserva IS NULL OR r.fecha_reserva >= TRUNC(SYSDATE))
            AND (r.estado IS NULL OR r.estado NOT IN ('CANCELADA', 'NO LLEGÓ'))
        ORDER BY c.dia_semana, c.hora_clase
    """)
    st.write(f"Clases encontradas: {len(clases)}")

    for _, row in clases.iterrows():

        st.markdown(f"""
        ---
        ### 🧘 {row['NOMBRE_CLASE']}

        📅 Día: {row['DIA_SEMANA']}  
        ⏰ Hora: {row['HORA_CLASE']}  
        👩‍🏫 Entrenador: {row['NOMBRE_ENTRENADOR']}  
        💲 Precio: ${row['PRECIO']:,.0f}  

        🔴🟢 Estado: {row['ESTADO']}
        
        📅 Reserva: {row['FECHA_RESERVA']}  
        👤 Cliente: {row['CLIENTE']}
        """)

elif pagina == "Reservas 📅":
    st.subheader("Reservar clase 🎟️")

    clases_disponibles = consultar("""
        SELECT clase_id,
               nombre_clase,
               dia_semana,
               hora_clase,
               precio
        FROM cs_clases
        WHERE estado = 'DISPONIBLE'
        ORDER BY dia_semana, hora_clase
    """)
    if clases_disponibles.empty:
        st.warning("No hay clases disponibles para este día")
    else:
        opciones = (
                clases_disponibles["NOMBRE_CLASE"]
                + " - "
                + clases_disponibles["DIA_SEMANA"]
                + " "
                + clases_disponibles["HORA_CLASE"]
        ).tolist()
        clase_seleccionada = st.selectbox(
            "Selecciona tu clase",
            opciones
        )

        fecha = st.date_input(
            "Selecciona la fecha de tu clase"
        )

        st.success(f"Clase seleccionada: {clase_seleccionada}, {fecha}")


        fila_clase = clases_disponibles[
            (
                    clases_disponibles["NOMBRE_CLASE"]
                    + " - "
                    + clases_disponibles["DIA_SEMANA"]
                    + " "
                    + clases_disponibles["HORA_CLASE"]
            ) == clase_seleccionada
            ].iloc[0]

        clase_id = int(fila_clase["CLASE_ID"])


        validacion = consultar(f"""
            SELECT *
            FROM cs_reservas
            WHERE clase_id = {clase_id}
            AND fecha_reserva = TO_DATE('{fecha}', 'YYYY-MM-DD')
        """)

        if not validacion.empty:
            st.error("Esta clase ya está reservada para esa fecha")
    st.markdown("### Datos del cliente 👤")

    col1, col2 = st.columns(2)

    with col1:
        tipo_doc = st.selectbox(
            "Tipo de documento",
            ["CC", "CE", "PA"]
        )

        num_doc = st.text_input(
            "Número de documento"
        )

        telefono = st.text_input(
            "Teléfono"
        )

    with col2:
        nombre = st.text_input(
            "Nombre completo"
        )

        email = st.text_input(
            "Correo electrónico"
        )
        if st.button("Reservar clase", type="primary"):
            if not num_doc or not nombre or not telefono or not email:
                st.warning("Completa todos los campos")
            else:
                # Verificar que la clase no esté ya reservada para esa fecha
                validacion = consultar(f"""
                    SELECT * FROM cs_reservas
                    WHERE clase_id = {clase_id}
                    AND fecha_reserva = TO_DATE('{fecha}', 'YYYY-MM-DD')
                """)

                if not validacion.empty:
                    st.error("Esta clase ya está reservada para esa fecha")
                else:
                    cliente_existente = consultar(f"""
                        SELECT cliente_id FROM cs_clientes
                        WHERE tipo_doc = '{tipo_doc}'
                        AND num_doc = '{num_doc}'
                    """)

                    if cliente_existente.empty:
                        ejecutar(f"""
                            INSERT INTO cs_clientes
                            VALUES (DEFAULT, '{tipo_doc}', '{num_doc}',
                                    '{nombre}', '{email}', '{telefono}')
                        """)
                        cliente_id = consultar(f"""
                            SELECT cliente_id FROM cs_clientes
                            WHERE tipo_doc = '{tipo_doc}'
                            AND num_doc = '{num_doc}'
                        """).iloc[0]["CLIENTE_ID"]
                    else:
                        cliente_id = int(cliente_existente.iloc[0]["CLIENTE_ID"])

                    ejecutar(f"""
                        INSERT INTO cs_reservas
                            (cliente_id, clase_id, fecha_reserva, monto_total, estado)
                        VALUES ({cliente_id}, {clase_id},
                                TO_DATE('{fecha}', 'YYYY-MM-DD'),
                                {float(fila_clase['PRECIO'])}, 'ACTIVA')
                    """)
                    ejecutar(f"""
                        UPDATE cs_clases SET estado = 'RESERVADA'
                        WHERE clase_id = {clase_id}
                    """)

                    st.success(f"✅ Reserva confirmada para {nombre} el {fecha}")
                    st.balloons()
elif pagina == "Pagos 💳":
    st.subheader("Registrar pago 🧾")

    reservas_pendientes = consultar("""
        SELECT r.reserva_id,
               cl.nombre,
               c.nombre_clase,
               c.dia_semana,
               c.hora_clase,
               r.monto_total,
               r.fecha_reserva
        FROM cs_reservas r
        JOIN cs_clientes cl ON cl.cliente_id = r.cliente_id
        JOIN cs_clases c ON c.clase_id = r.clase_id
        LEFT JOIN cs_pagos p ON r.reserva_id = p.reserva_id
        WHERE r.estado = 'ACTIVA'
        AND p.reserva_id IS NULL
    """)

    if reservas_pendientes.empty:
        st.info("No hay reservas pendientes de pago")
    else:
        etiquetas = (
            reservas_pendientes["NOMBRE"]
            + " — "
            + reservas_pendientes["NOMBRE_CLASE"]
            + " "
            + reservas_pendientes["DIA_SEMANA"]
            + " "
            + reservas_pendientes["HORA_CLASE"]
        )

        reserva_sel = st.selectbox("Reserva", etiquetas.tolist())
        fila = reservas_pendientes[etiquetas == reserva_sel].iloc[0]

        st.write(f"📅 Fecha: **{fila['FECHA_RESERVA']}**")
        st.write(f"💰 Monto a pagar: **${float(fila['MONTO_TOTAL']):,.0f}**")

        canal_pago = st.selectbox(
            "Canal de pago",
            ["TARJETA DE CRÉDITO", "TRANSFERENCIA", "EFECTIVO"]
        )

        if st.button("Registrar pago", type="primary"):
            ejecutar(f"""
                INSERT INTO cs_pagos
                    (reserva_id, fecha_pago, monto_pago, canal_pago, estado)
                VALUES (
                    {int(fila['RESERVA_ID'])}, SYSDATE,
                    {float(fila['MONTO_TOTAL'])},
                    '{canal_pago}', 'PAGADO'
                )
            """)
            st.success(f"✅ Pago de ${float(fila['MONTO_TOTAL']):,.0f} registrado correctamente")
            st.balloons()

elif pagina == "Cancelación 📝":
    st.subheader("Cancelar reserva ❌")

    reservas_activas = consultar("""
        SELECT r.reserva_id,
               cl.nombre,
               c.nombre_clase,
               c.dia_semana,
               c.hora_clase,
               r.monto_total,
               r.fecha_reserva
        FROM cs_reservas r
        JOIN cs_clientes cl ON cl.cliente_id = r.cliente_id
        JOIN cs_clases c ON c.clase_id = r.clase_id
        WHERE r.estado = 'ACTIVA'
    """)

    if reservas_activas.empty:
        st.info("No hay reservas activas para cancelar")
    else:
        etiquetas = (
            reservas_activas["NOMBRE"]
            + " — "
            + reservas_activas["NOMBRE_CLASE"]
            + " "
            + reservas_activas["DIA_SEMANA"]
            + " "
            + reservas_activas["HORA_CLASE"]
        )

        reserva_sel = st.selectbox("Selecciona la reserva", etiquetas.tolist())
        fila = reservas_activas[etiquetas == reserva_sel].iloc[0]

        st.write(f"📅 Fecha: **{fila['FECHA_RESERVA']}**")
        st.write(f"💰 Monto a devolver: **${float(fila['MONTO_TOTAL']):,.0f}**")

        motivo = st.text_input("Motivo de cancelación", value="CANCELACION")

        if st.button("Cancelar reserva", type="primary"):
            reserva_id = int(fila["RESERVA_ID"])
            monto      = float(fila["MONTO_TOTAL"])

            # 1 — Cambiar estado de la reserva a CANCELADA
            ejecutar(f"""
                UPDATE cs_reservas SET estado = 'CANCELADA'
                WHERE reserva_id = {reserva_id}
            """)

            # 2 — Generar nota de cancelación
            ejecutar(f"""
                INSERT INTO cs_notas_cancelacion
                    (reserva_id, fecha_nota, monto_devolucion, motivo)
                VALUES (
                    {reserva_id}, SYSDATE,
                    {monto}, '{motivo}'
                )
            """)

            # 3 — Volver la clase a DISPONIBLE
            ejecutar(f"""
                UPDATE cs_clases SET estado = 'DISPONIBLE'
                WHERE clase_id = (
                    SELECT clase_id FROM cs_reservas
                    WHERE reserva_id = {reserva_id}
                )
            """)

            st.success(f"✅ Reserva cancelada y nota de cancelación generada")
            st.balloons()


















