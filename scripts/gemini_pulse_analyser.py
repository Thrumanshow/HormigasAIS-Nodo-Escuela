import os
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
import json
import requests
from datetime import datetime, timezone

API_KEY = os.environ.get("GEMINI_API_KEY")
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DRAFT_PATH = os.path.join(BASE_DIR, "drafts", "security_pulse.json")
MEMORY_FILE = os.path.join(BASE_DIR, "memory", "gemini", "analysis_log.json")

def procesar_pulso():
    if not os.path.exists(DRAFT_PATH): return

    with open(DRAFT_PATH, "r", encoding="utf-8") as f:
        draft = json.load(f)

    url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={API_KEY}"
    payload = {"contents": [{"parts": [{"text": f"Analiza este evento LBH: {json.dumps(draft)}"}]}]}
    
    response = requests.post(url, json=payload)
    analysis_text = response.json()["candidates"][0]["content"]["parts"][0]["text"]

    memory_entry = {
        "timestamp_utc": draft.get("timestamp"),
        "type": draft.get("type", "ANALISIS_ESTRATEGICO"),
        "protocol": "LBH",
        "analysis": analysis_text,
        "input_hash": draft.get("hash", "N/A"),
        "state": "ACTIVE"
    }

    if os.path.exists(MEMORY_FILE):
        with open(MEMORY_FILE, "r") as f: logs = json.load(f)
    else: logs = []

    logs.append(memory_entry)
    with open(MEMORY_FILE, "w") as f: json.dump(logs, f, indent=2)
    print("🧠 Memoria interna actualizada correctamente en San Miguel.")

if __name__ == "__main__":
    procesar_pulso()
