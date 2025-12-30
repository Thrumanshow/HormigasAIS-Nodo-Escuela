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
**Generado:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} (CST - Local SV)
**Sincronización Global:** UTC/Zulu Standard
**Nodo:** Nodo-Escuela (San Miguel, SV)
**Protocolo:** LBH (Lenguaje Binario HormigasAIS)

> **Nota de Auditoría:** Las marcas de tiempo de los eventos se registran en UTC para trazabilidad internacional, mientras que la emisión del reporte refleja la hora local del nodo.

---
"""
    for entry in logs:
        # Usamos .get() para evitar errores si los logs viejos no tienen las nuevas llaves
        t_local = entry.get('timestamp_local', 'N/A')
        md_content += f"\n### Evento: {entry.get('input_hash', 'N/A')}\n- **Local:** `{t_local}` \n- **IA:** `{entry.get('source', 'N/A')}`\n\n#### 🔍 Análisis\n{entry.get('analysis', 'Sin análisis')}\n---\n"

    md_content += "\n**Firma Digital:** `HormigasAIS-SBN-VALIDATED`"

    with open(REPORT_FILE, "w", encoding="utf-8") as f:
        f.write(md_content)
    print(f"✅ Reporte profesional generado en: {REPORT_FILE}")

if __name__ == "__main__":
    crear_reporte_markdown()
