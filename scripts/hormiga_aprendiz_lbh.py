import os
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
import json
import time
from datetime import datetime
import hashlib
import shutil  # Nueva librería para mover archivos

# ────────────── Configuración ──────────────
BASE_PATH = "./NodoEscuela_Gemini"
PULSOS_PATH = os.path.join(BASE_PATH, "pulsos")
BACKUP_PATH = os.path.join(BASE_PATH, "historico_pulsos") # Carpeta de limpieza
HORMIGA_DATA = os.path.join(BASE_PATH, "hormiga_dataset.json")
AUDIT_LOG = os.path.join(BASE_PATH, "audit_log.json")
CICLO_SEGUNDOS = 5 

# Asegurar que existan las rutas
os.makedirs(PULSOS_PATH, exist_ok=True)
os.makedirs(BACKUP_PATH, exist_ok=True)

if not os.path.exists(HORMIGA_DATA):
    with open(HORMIGA_DATA, "w") as f:
        json.dump([], f)

if not os.path.exists(AUDIT_LOG):
    with open(AUDIT_LOG, "w") as f:
        json.dump([], f)

# ────────────── Funciones ──────────────

def generar_hash(pulso):
    pulso_str = json.dumps(pulso, sort_keys=True)
    return hashlib.sha256(pulso_str.encode()).hexdigest()

def leer_pulsos_con_rutas():
    """
    Retorna una lista de tuplas (datos_json, nombre_archivo)
    """
    pulsos_detectados = []
    for archivo in os.listdir(PULSOS_PATH):
        if archivo.endswith(".json"):
            ruta_completa = os.path.join(PULSOS_PATH, archivo)
            try:
                with open(ruta_completa, "r") as f:
                    pulsos_detectados.append((json.load(f), archivo))
            except Exception as e:
                print(f"⚠️ Error leyendo {archivo}: {e}")
    return pulsos_detectados

def validar_con_xoxo(pulso):
    required_keys = ["origin", "instruction", "hash", "type", "execution"]
    return all(key in pulso for key in required_keys)

def clasificar_pulso(pulso):
    text = pulso.get("instruction", "").lower()
    if any(word in text for word in ["banco", "financ"]): return "Seguridad Bancaria"
    if any(word in text for word in ["automatización", "workflow"]): return "Automatización"
    if any(word in text for word in ["regul", "compliance"]): return "IA Regulatoria"
    return "General"

def limpiar_archivo(nombre_archivo):
    """
    Mueve el archivo procesado a la carpeta histórico
    """
    origen = os.path.join(PULSOS_PATH, nombre_archivo)
    destino = os.path.join(BACKUP_PATH, nombre_archivo)
    try:
        shutil.move(origen, destino)
        return True
    except Exception as e:
        print(f"🚨 Fallo al limpiar {nombre_archivo}: {e}")
        return False

def actualizar_dataset(pulsos_tuplas):
    with open(HORMIGA_DATA, "r") as f:
        dataset = json.load(f)
    with open(AUDIT_LOG, "r") as f:
        audit_log = json.load(f)

    nuevos = 0
    for pulso, archivo in pulsos_tuplas:
        if validar_con_xoxo(pulso):
            pulso_hash = pulso.get("hash") or generar_hash(pulso)
            
            # Verificar si ya existe en el dataset para evitar duplicados
            if pulso_hash not in [d.get("pulso_hash") for d in dataset]:
                registro = {
                    "timestamp": datetime.utcnow().isoformat(),
                    "pulso_hash": pulso_hash,
                    "pulso": pulso,
                    "categoria": clasificar_pulso(pulso)
                }
                dataset.append(registro)
                audit_log.append({
                    "timestamp": registro["timestamp"],
                    "evento": "Pulso registrado y limpiado",
                    "hash": pulso_hash,
                    "archivo_original": archivo
                })
                nuevos += 1
            
            # Limpiar: Mover a histórico sea nuevo o duplicado (para vaciar entrada)
            limpiar_archivo(archivo)

    with open(HORMIGA_DATA, "w") as f:
        json.dump(dataset, f, indent=2)
    with open(AUDIT_LOG, "w") as f:
        json.dump(audit_log, f, indent=2)

    if nuevos > 0:
        print(f"✅ {nuevos} pulsos procesados, registrados y movidos a histórico.")
    else:
        # Si había archivos pero todos eran duplicados, también se limpian
        if len(pulsos_tuplas) > 0:
            print(f"🧹 Carpeta de pulsos despejada (archivos duplicados movidos).")

# ────────────── Ciclo Principal ──────────────
if __name__ == "__main__":
    print(f"📡 Ciclo Hormiga Inteligente con Limpieza Automática iniciado en {BASE_PATH}...")
    while True:
        pulsos_data = leer_pulsos_con_rutas()
        if pulsos_data:
            actualizar_dataset(pulsos_data)
        time.sleep(CICLO_SEGUNDOS)

