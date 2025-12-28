import csv
import time
from datetime import datetime
import random
import os

def stream_core_ant():
    # Ruta absoluta para evitar errores de contexto en Termux
    file_path = os.path.expanduser('~/HormigasAIS-Nodo-Escuela/visual_demo_stream.csv')
    ant_id = "HORMIGA_07_CORE"
    
    # Rango de operación estable para la demo
    value = round(random.uniform(24.5, 25.8), 2)
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    signature = "HMAC_2025_VALID_CORE"
    
    # Escribir con tabulaciones para mantener el formato del visualizador
    with open(file_path, mode='a', newline='') as file:
        writer = csv.writer(file, delimiter='\t')
        writer.writerow([timestamp, ant_id, "OPERATIONAL", value, signature])
    
    print(f"📡 [HORMIGA 07] Telemetría enviada: {value} | {timestamp}")

if __name__ == "__main__":
    # Generar ráfaga inicial de 5 puntos
    for _ in range(5):
        stream_core_ant()
        time.sleep(0.5)
