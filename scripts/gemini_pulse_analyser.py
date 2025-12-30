import os
import json
import requests
from datetime import datetime, timezone

# CONFIGURACIÓN SOBERANA LBH
API_KEY = os.environ.get("GEMINI_API_KEY")
if not API_KEY:
    raise RuntimeError("❌ GEMINI_API_KEY no encontrada.")

MODEL = "models/gemini-2.5-flash"
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DRAFT_PATH = os.path.join(BASE_DIR, "drafts", "security_pulse.json")
MEMORY_FILE = os.path.join(BASE_DIR, "memory", "gemini", "analysis_log.json")

os.makedirs(os.path.dirname(MEMORY_FILE), exist_ok=True)

if not os.path.exists(DRAFT_PATH):
    print(f"⚠️ Error: No se encontró el pulso en {DRAFT_PATH}")
    exit(1)

with open(DRAFT_PATH, "r", encoding="utf-8") as f:
    draft = json.load(f)

payload = {
    "contents": [{"parts": [{"text": f"Analiza bajo Protocolo LBH: {json.dumps(draft)}"}]}]
}

url = f"https://generativelanguage.googleapis.com/v1beta/{MODEL}:generateContent?key={API_KEY}"

try:
    response = requests.post(url, json=payload, timeout=30)
    analysis_text = response.json()["candidates"][0]["content"]["parts"][0]["text"]

    # CORRECCIÓN DE REFERENCIA TEMPORAL
    memory_entry = {
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "timestamp_local": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        "source": "gemini-2.5-flash",
        "protocol": "LBH",
        "node": "Nodo-Escuela",
        "analysis": analysis_text,
        "input_hash": draft.get("hash", "N/A"),
        "status": "MEMORIZED"
    }

    if os.path.exists(MEMORY_FILE):
        with open(MEMORY_FILE, "r") as f: logs = json.load(f)
    else: logs = []

    logs.append(memory_entry)
    with open(MEMORY_FILE, "w") as f: json.dump(logs, f, indent=2)
    print("🧠 Memoria interna actualizada correctamente en San Miguel.")

except Exception as e:
    print(f"🚨 Fallo: {e}")

