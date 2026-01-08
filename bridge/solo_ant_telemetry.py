import random
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
from datetime import datetime
import os

def generar_pulso():
    csv_file = 'visual_demo_stream.csv'
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    id_hormiga = "HORMIGA_07_CORE"
    estado = "OPERATIONAL"
    # Simulación de carga/temperatura eficiente (24°C - 26°C)
    valor_temp = round(random.uniform(24.5, 25.9), 2)
    firma = "HMAC_2025_VALID_CORE"

    # Crear encabezado si el archivo no existe
    if not os.path.exists(csv_file):
        with open(csv_file, 'w') as f:
            f.write("FECHA_HORA,ID_HORMIGA,ESTADO,DATO_VALOR,FIRMA_LBH\n")

    # Escribir la nueva línea soberana
    nueva_linea = f"{timestamp},{id_hormiga},{estado},{valor_temp},{firma}\n"
    
    with open(csv_file, 'a') as f:
        f.write(nueva_linea)
    
    print(f"📡 [{id_hormiga}] Telemetría enviada: {valor_temp} | {timestamp}")

if __name__ == "__main__":
    # Generar 5 pulsos por ciclo para dar volumen al gráfico
    for _ in range(5):
        generar_pulso()
