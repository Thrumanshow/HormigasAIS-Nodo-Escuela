import datetime
import os

def activar_feromona_bienvenida():
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    # 0xFEED es el código LBH simbólico para "Bienvenida/Sincronía Inicial"
    hex_bienvenida = "0xFEED"
    
    contenido = f"""# 🐜 MODO DEMOSTRACIÓN: BIENVENIDA AL INVERSOR
Estado: SOBERANÍA_ACTIVA
Instrucción LBH: {hex_bienvenida}
Sincronización: {timestamp}

[XOXO-BUS] FEROMONA_EMITIDA: {{"tipo": "bienvenida_inversor", "nodo": "San Miguel", "status": "online"}}

## 🏛️ Mensaje del Nodo
"Bienvenido a la red HormigasAIS. Estás viendo una instrucción generada en tiempo real por el Nodo-Escuela El Salvador bajo el protocolo CLHQ."
"""

    with open("FEROMONA_BIENVENIDA.md", "w") as f:
        f.write(contenido)
    
    print(f"✅ Feromona {hex_bienvenida} generada en FEROMONA_BIENVENIDA.md")

activar_feromona_bienvenida()
