import json
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
import os

# Rutas del Nodo-Escuela
DB_PATH = "memory/gemini/analysis_log.json"
SECURE_VAULT = "memory/vault_soberano.json"

def activar_protocolo_centinela():
    print("🚨 [ALERTA] Intrusión detectada. Activando Protocolo Centinela...")
    
    if not os.path.exists(DB_PATH):
        print("❌ Error: Memoria no encontrada.")
        return

    with open(DB_PATH, 'r') as f:
        memoria = json.load(f)

    # Filtrar solo lo ETERNAL (Hito Fundacional) para resguardo
    eternos = [d for d in memoria if d.get("state") == "ETERNAL"]
    
    # Resguardo en bóveda soberana
    with open(SECURE_VAULT, 'w') as f:
        json.dump(eternos, f, indent=4)
    
    # Purga total de la memoria operativa activa
    with open(DB_PATH, 'w') as f:
        json.dump([], f)

    print("🛡️  PROTOCOLO LBH: Memoria operativa purgada.")
    print(f"💎 {len(eternos)} Hitos Críticos resguardados en Bóveda.")
    print("🔒 Nodo bloqueado. Soberanía asegurada.")

if __name__ == "__main__":
    activar_protocolo_centinela()
