import json
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
import os

# Configuración de Rutas
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEMORY_FILE = os.path.join(BASE_DIR, "memory", "gemini", "analysis_log.json")

def generar_dashboard():
    if not os.path.exists(MEMORY_FILE):
        print("⚠️ No hay memoria registrada aún.")
        return

    with open(MEMORY_FILE, "r", encoding="utf-8") as f:
        logs = json.load(f)

    print("="*50)
    print("🐜 HORMIGASAIS - DASHBOARD DE SOBERANÍA 🇸🇻")
    print(f"Nodo: Nodo-Escuela | Eventos: {len(logs)}")
    print("="*50)

    for i, entry in enumerate(logs, 1):
        print(f"\n[EVENTO #{i}] - {entry['timestamp']}")
        print(f"Protocolo: {entry['protocol']} | Hash: {entry['input_hash']}")
        
        # Extraer solo las primeras líneas del análisis para el resumen
        lineas = entry['analysis'].split('\n')
        print("-" * 20)
        print("RESUMEN ESTRATÉGICO:")
        # Mostrar las primeras 5 líneas relevantes
        count = 0
        for line in lineas:
            if "**" in line or "*" in line:
                print(f"  {line}")
                count += 1
            if count > 6: break
    
    print("\n" + "="*50)
    print("ESTADO: NODO SOBERANO Y OPERATIVO")
    print("="*50)

if __name__ == "__main__":
    generar_dashboard()

