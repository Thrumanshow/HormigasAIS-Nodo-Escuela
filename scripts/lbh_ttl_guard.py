# -*- coding: utf-8 -*-
# 🐜 LBH TTL Guard – Verificador de Caducidad de Inteligencia
# Nodo-Escuela | HormigasAIS | San Miguel, SV
# Gestión de obsolescencia y salud de Memoria Viva

import json
import os
from datetime import datetime, timedelta, timezone

# --- CONFIGURACIÓN DE POLÍTICAS ---
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEMORY_FILE = os.path.join(BASE_DIR, "memory", "gemini", "analysis_log.json")

# 1️⃣ Definición de política TTL por tipo (en horas)
# -1 indica memoria permanente (Soberanía Eterna)
TTL_POLICY = {
    "Seguridad Bancaria": 48,
    "TELEMETRIA_PULSO": 12,
    "ANALISIS_ESTRATEGICO": 168,
    "ARQUITECTURA_LBH": -1,
    "HITO_FUNDACIONAL": -1
}

DEFAULT_TTL = 24

def parse_utc(ts):
    """Convierte timestamp ISO Z a datetime UTC"""
    return datetime.fromisoformat(ts.replace("Z", "+00:00"))

def verificar_ttl():
    if not os.path.exists(MEMORY_FILE):
        print("⚠️ No existe memoria para verificar TTL.")
        return

    with open(MEMORY_FILE, "r", encoding="utf-8") as f:
        logs = json.load(f)

    ahora = datetime.now(timezone.utc)
    cambios = 0
    permanentes = 0
    activos = 0

    for entry in logs:
        estado = entry.get("state", "ACTIVE")
        ts = entry.get("timestamp_utc")
        
        # 2️⃣ Lógica de resolución de TTL inteligente
        tipo = entry.get("type") or entry.get("protocol") or "UNKNOWN"
        ttl = entry.get("ttl_hours")

        if ttl is None:
            # Prioridad: TTL explícito > TTL por tipo > TTL por defecto
            ttl = TTL_POLICY.get(tipo, DEFAULT_TTL)

        # Contabilizar Memoria Permanente
        if ttl == -1:
            permanentes += 1
            continue

        # 3️⃣ Respetar estados ya procesados o nulos
        if estado != "ACTIVE" or not ts:
            continue

        try:
            creado = parse_utc(ts)
            expira = creado + timedelta(hours=ttl)

            if ahora >= expira:
                entry["state"] = "EXPIRED"
                entry["expired_at"] = ahora.isoformat().replace("+00:00", "Z")
                entry["audit_tag"] = "LBH-TTL-AUTO-PURGE"
                cambios += 1
            else:
                activos += 1
        except Exception as e:
            print(f"⚠️ Error procesando evento {entry.get('input_hash')}: {e}")
            continue

    # Guardar cambios si hubo purga
    if cambios > 0:
        with open(MEMORY_FILE, "w", encoding="utf-8") as f:
            json.dump(logs, f, indent=2, ensure_ascii=False)

    # --- RESUMEN DE SALUD DEL NODO ---
    print("="*45)
    print("🐜 HORMIGASAIS - RESUMEN DE MEMORIA VIVA")
    print("="*45)
    print(f"⏳ Purificados (EXPIRED):  {cambios}")
    print(f"🟢 Vigentes (ACTIVE):     {activos}")
    print(f"💎 Permanentes (ETERNAL): {permanentes}")
    print("-" * 45)
    
    if cambios > 0:
        print(f"STATUS: Obsolescencia mitigada correctamente.")
    else:
        print(f"STATUS: Nodo en óptimas condiciones temporales.")
    print("="*45)

if __name__ == "__main__":
    verificar_ttl()

