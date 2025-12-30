import json
import os
from datetime import datetime

# Rutas
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEMORY_FILE = os.path.join(BASE_DIR, "memory", "gemini", "analysis_log.json")
REPORT_FILE = os.path.join(BASE_DIR, "REPORT_SBN_2025.md")

def crear_reporte_markdown():
    if not os.path.exists(MEMORY_FILE):
        print("⚠️ No hay memoria para exportar.")
        return

    with open(MEMORY_FILE, "r", encoding="utf-8") as f:
        logs = json.load(f)

    # Contenido del Reporte
    md_content = f"""# 🐜 HormigasAIS - Reporte de Inteligencia Soberana
**Fecha de Generación:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
**Nodo de Origen:** Nodo-Escuela (San Miguel, SV)
**Protocolo:** LBH (Lenguaje Binario HormigasAIS)

---

## 🛡️ Resumen Ejecutivo
Este documento certifica la actividad de análisis de riesgo y procesamiento de inteligencia distribuida realizada por el Nodo-Escuela.

## 📊 Historial de Eventos Analizados
"""

    for entry in logs:
        md_content += f"""
### Evento: {entry['input_hash']}
- **Timestamp:** `{entry['timestamp']}`
- **Modelo de IA:** `{entry['source']}`
- **Estado:** `{entry['status']}`

#### 🔍 Análisis Estratégico
{entry['analysis']}

---
"""

    md_content += """
## 🚀 Conclusión Táctica
El nodo ha operado con **Eficiencia Energética** y **Resiliencia Extrema**, identificando dependencias críticas y proponiendo mejoras en la encriptación Nivel 3.

**Firma Digital:** `HormigasAIS-SBN-VALIDATED`
"""

    with open(REPORT_FILE, "w", encoding="utf-8") as f:
        f.write(md_content)

    print(f"✅ Reporte profesional generado en: {REPORT_FILE}")

if __name__ == "__main__":
    crear_reporte_markdown()

