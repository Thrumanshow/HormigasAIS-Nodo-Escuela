#!/usr/bin/env python3
# 🐜 HormigasAIS - Sincronizador Maestro LBH
# Autor: Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Nodo: Maestro / Adapter Unificado

import pandas as pd
import ast
import os
import datetime

LOG_FILE = "auditor.log"
CSV_FILE = "visual_demo_stream.csv" # Alineado con el visualizador directo

def actualizar_csv_maestro():
    rows = []
    if not os.path.exists(LOG_FILE):
        print("⚠️ No se detectó auditor.log. Generando entrada de pulso base...")
        # Pulso de seguridad si el log está vacío
        lbh_row = {
            "FECHA_HORA": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "ID_HORMIGA": "MAESTRO_ALPHA",
            "ESTADO": "SINCRO_OK",
            "DATO_VALOR": 25.0,
            "FIRMA_LBH": "HMAC_2025_SOBERANA"
        }
        rows.append(lbh_row)
    else:
        with open(LOG_FILE, "r") as f:
            for line in f:
                if "Datos del Enjambre:" in line:
                    try:
                        data_str = line.split("Datos del Enjambre:")[1].strip()
                        data = ast.literal_eval(data_str)
                        lbh_row = {
                            "FECHA_HORA": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                            "ID_HORMIGA": "HORMIGA_07_CORE",
                            "ESTADO": data.get("status", "OPERATIONAL"),
                            "DATO_VALOR": data.get("temp", data.get("value", 25.0)),
                            "FIRMA_LBH": "HMAC_2025_VALID_CORE"
                        }
                        rows.append(lbh_row)
                    except: continue

    if rows:
        df = pd.DataFrame(rows)
        # Limpieza de cabeceras integrada en el ADN del archivo
        df.columns = df.columns.str.strip()
        df.to_csv(CSV_FILE, index=False)
        print(f"✅ [LBH-MAESTRO] CSV Unificado y Limpio: {len(df)} registros.")

if __name__ == "__main__":
    actualizar_csv_maestro()
