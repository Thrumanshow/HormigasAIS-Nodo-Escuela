	mport os
import json
import requests
from datetime import datetime, timezone

# =============================
# CONFIGURACIÓN SOBERANA LBH
# =============================
API_KEY = os.environ.get("GEMINI_API_KEY")
if not API_KEY:
    raise RuntimeError("❌ GEMINI_API_KEY no encontrada. Nodo protegido.")

MODEL = "models/gemini-2.5-flash"
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Rutas de Archivos
DRAFT_PATH = os.path.join(BASE_DIR, "drafts", "security_pulse.json")
MEMORY_DIR = os.path.join(BASE_DIR, "memory", "gemini")
MEMORY_FILE = os.path.join(MEMORY_DIR, "analysis_log.json")

# Asegurar que el directorio de memoria exista
os.makedirs(MEMORY_DIR, exist_ok=True)

# =============================
# CARGAR DRAFT (INPUT SOBERANO)
# =============================
if not os.path.exists(DRAFT_PATH):
    print(f"⚠️ Error: No se encontró el pulso en {DRAFT_PATH}")
    exit(1)

with open(DRAFT_PATH, "r", encoding="utf-8") as f:
    draft = json.load(f)

# Payload estructurado bajo Protocolo LBH
payload = {
    "contents": [{
        "parts": [{
            "text": f"""
Eres un analista bajo Protocolo LBH.
No inventes datos.
No reveles identidades.
Extrae patrones, riesgos y oportunidades.

Datos del Nodo Escuela:
{json.dumps(draft, indent=2)}
"""
        }]
    }]
}

url = f"https://generativelanguage.googleapis.com/v1beta/{MODEL}:generateContent?key={API_KEY}"

# =============================
# COMUNICACIÓN Y ANÁLISIS
# =============================
print("📡 Conectando con Gemini (Pulso LBH)...")

try:
    response = requests.post(url, json=payload, timeout=30)
    print("📨 Código HTTP:", response.status_code)
    
    if response.status_code != 200:
        print(f"🚨 Error de API: {response.text}")
        exit(1)

    data = response.json()
    analysis_text = data["candidates"][0]["content"]["parts"][0]["text"]

    print("\n🔍 ANÁLISIS ESTRATÉGICO RECIBIDO:\n")
    print(analysis_text)

    # ========================================================
    # CONVERTIR A MEMORIA INTERNA (Línea 76 Corregida)
    # ========================================================
    memory_entry = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "source": "gemini-2.5-flash",
        "protocol": "LBH",
        "node": "Nodo-Escuela",
        "analysis": analysis_text,
        "input_hash": draft.get("hash", "N/A"),
        "status": "MEMORIZED"
    }

    # Persistencia de Memoria
    if os.path.exists(MEMORY_FILE):
        with open(MEMORY_FILE, "r", encoding="utf-8") as f:
            memory_log = json.load(f)
    else:
        memory_log = []

    memory_log.append(memory_entry)

    with open(MEMORY_FILE, "w", encoding="utf-8") as f:
        json.dump(memory_log, f, indent=2, ensure_ascii=False)

    print("\n🧠 Memoria interna actualizada correctamente en San Miguel.")

except Exception as e:
    print(f"🚨 Fallo crítico en el sistema: {e}")

