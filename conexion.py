import oracledb
import os
from dotenv import load_dotenv

load_dotenv()

def get_connection():

    conn = oracledb.connect(
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        dsn=os.getenv("DB_DSN"),
        config_dir=os.getenv("WALLET_DIR"),
        wallet_location=os.getenv("WALLET_DIR"),
        wallet_password=os.getenv("WALLET_PASSWORD")
    )
    return conn


from conexion import get_connection

conn = get_connection()
cursor = conn.cursor()

cursor.execute("SELECT 1 FROM DUAL")
print("Conexion exitosa:", cursor.fetchone())

conn.close()


import pandas as pd
from conexion import get_connection

conn = get_connection()

cs_clientes = pd.read_sql("SELECT * FROM cs_clientes", conn)
cs_entrenadores = pd.read_sql("SELECT * FROM cs_entrenadores", conn)
cs_clases = pd.read_sql("SELECT * FROM cs_clases", conn)
cs_reservas = pd.read_sql("SELECT * FROM cs_reservas", conn)
cs_pagos = pd.read_sql("SELECT * FROM cs_pagos", conn)
cs_notas = pd.read_sql("SELECT * FROM cs_notas_cancelacion", conn)

print(cs_clientes.head())

conn.close()


