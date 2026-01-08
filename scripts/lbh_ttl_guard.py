# -*- coding: utf-8 -*-
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🐜 LBH TTL Guard – Memoria Estratificada
# Nodo-Escuela | HormigasAIS | San Miguel, SV

import json
import os
from datetime import datetime, timedelta, timezone

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEMORY_FILE = os.path.join(BASE_DIR, "memory", "gemini", "analysis_log.json")

# 🧬 POLÍTICA DE PERSISTENCIA
TTL_POLICY = {
    "HITO_FUNDACIONAL": None,   # Eterno
    "TELEMETRIA": 6,            # Efímero
    "ANALISIS_ESTRATEGICO": 72  # Auditoría
}

DEFAULT_TTL = 24

def parse_utc(ts):
    try:
        return datetime.fromisoformat(ts.replace("Z", "+00:00"))
    except:
        return datetime.now(timezone.utc)

def verificar_ttl():
    if not os.path.exists(MEMORY_FILE):
        print("⚠️ No existe memoria para verificar.")
        return

    with open(MEMORY_FILE, "r", encoding="utf-8") as f:
        logs = json.load(f)

    ahora = datetime.now(timezone.utc)
    cambios, permanentes, activos = 0, 0, 0

    for entry in logs:
        # Limpieza de tipo para asegurar coincidencia
        tipo = str(entry.get("type", "DESCONOCIDO")).strip().upper()
        ttl = TTL_POLICY.get(tipo, DEFAULT_TTL)

        if ttl is None or tipo == "HITO_FUNDACIONAL":
            entry["state"] = "ETERNAL"
            permanentes += 1
            continue

        ts = entry.get("timestamp_utc")
        if not ts: continue

        creado = parse_utc(ts)
        expira = creado + timedelta(hours=ttl)

        if ahora >= expira:
            entry["state"] = "EXPIRED"
            cambios += 1
        else:
            entry["state"] = "ACTIVE"
            activos += 1

    with open(MEMORY_FILE, "w", encoding="utf-8") as f:
        json.dump(logs, f, indent=2, ensure_ascii=False)

    print("="*45)
    print(f"⏳ Purificados (EXPIRED):  {cambios}")
    print(f"🟢 Vigentes (ACTIVE):     {activos}")
    print(f"💎 Permanentes (ETERNAL): {permanentes}")
    print("STATUS: Memoria estratificada bajo Protocolo LBH.")
    print("="*45)

if __name__ == "__main__":
    verificar_ttl()
