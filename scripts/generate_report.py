import json
import os
from datetime import datetime

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEMORY_FILE = os.path.join(BASE_DIR, "memory", "gemini", "analysis_log.json")
REPORT_FILE = os.path.join(BASE_DIR, "REPORT_SBN_2025.md")

def crear_reporte_markdown():
    if not os.path.exists(MEMORY_FILE):
        print("⚠️ No hay memoria para exportar.")
        return

    with open(MEMORY_FILE, "r", encoding="utf-8") as f:
        logs = json.load(f)

    md_content = f"""# 🐜 HormigasAIS - Reporte de Inteligencia Soberana
**Fecha de Generación:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} (CST)
**Nodo de Origen:** Nodo-Escuela (San Miguel, SV)
**Protocolo:** LBH (Lenguaje Binario HormigasAIS)

---
## 🛡️ Resumen Ejecutivo
Este documento certifica la actividad de inteligencia distribuida y la salud de la memoria del nodo.
"""
    for entry in logs:
        # Mostramos el estado (ACTIVE, EXPIRED o ETERNAL)
        emoji = "💎" if entry.get("state") == "ETERNAL" else "🟢"
        md_content += f"\n### {emoji} Evento: {entry.get('input_hash')}\n"
        md_content += f"- **Tipo:** `{entry.get('type')}`\n"
        md_content += f"- **Análisis:** {entry.get('analysis')}\n\n---"

    with open(REPORT_FILE, "w", encoding="utf-8") as f:
        f.write(md_content)
    print(f"✅ Reporte generado: {REPORT_FILE}")

if __name__ == "__main__":
    crear_reporte_markdown()

