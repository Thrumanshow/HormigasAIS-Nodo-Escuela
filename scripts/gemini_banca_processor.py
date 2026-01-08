# -*- coding: utf-8 -*-
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🐜 Cerebro Gemini - Procesador Bancario 24h
import json
import os
from datetime import datetime, timedelta

DATASET_PATH = "NodoEscuela_Gemini/hormiga_dataset.json"
BRAIN_DRAFT = "NodoEscuela_Gemini/brain_drafts/analisis_bancario_24h.json"

def filtrar_pulsos_bancarios_24h():
    if not os.path.exists(DATASET_PATH): return []
    
    with open(DATASET_PATH, "r") as f:
        dataset = json.load(f)
    
    # Filtramos solo lo de categoría "Seguridad Bancaria"
    hace_24h = datetime.utcnow() - timedelta(days=1)
    lecciones = [d for d in dataset if d["categoria"] == "Seguridad Bancaria"]
    
    return lecciones

def preparar_para_gemini(lecciones):
    # Aquí es donde el prompt se construye para Gemini
    print(f"🧠 Preparando {len(lecciones)} lecciones bancarias para Gemini...")
    reporte = {
        "timestamp": datetime.utcnow().isoformat(),
        "total_eventos": len(lecciones),
        "data_payload": lecciones,
        "status": "WAITING_FOR_GEMINI_ANALYSIS"
    }
    
    with open(BRAIN_DRAFT, "w") as f:
        json.dump(reporte, f, indent=2)
    print(f"✅ Borrador listo en {BRAIN_DRAFT}. XOXO puede proceder a validar.")

if __name__ == "__main__":
    preparar_para_gemini(filtrar_pulsos_bancarios_24h())
