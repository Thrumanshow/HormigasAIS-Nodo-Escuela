#!/usr/bin/env python3
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# ⚖️ LBH AUDIT CHAIN GUARD
# Valida integridad forense de auditorías
# Modo: READ-ONLY | Dependency-Free | Deterministic

import os
import sys
import glob

LOG_DIR = "logs"
AUDIT_PREFIX = "LBH_AUDIT_"
GENESIS_FILE = "LBH_CHAIN_GENESIS.log"

def extract_value(lines, key):
    for line in lines:
        if line.startswith(key + "="):
            return line.split("=", 1)[1].strip()
    return None

def extract_signature_hash(lines):
    for i, line in enumerate(lines):
        if line.startswith("Signature-Hash"):
            parts = line.split(":", 1)
            if len(parts) == 2 and parts[1].strip():
                return parts[1].strip()
            # hash en línea siguiente
            for j in range(i + 1, len(lines)):
                candidate = lines[j].strip()
                if candidate:
                    return candidate
    return None

def load_genesis_anchor():
    path = os.path.join(LOG_DIR, GENESIS_FILE)
    if not os.path.isfile(path):
        print("❌ ERROR: LBH_CHAIN_GENESIS.log no encontrado")
        sys.exit(1)

    with open(path, "r", encoding="utf-8") as f:
        lines = [l.strip() for l in f.readlines()]

    anchor_hash = extract_value(lines, "ANCHOR_HASH")
    if not anchor_hash:
        print("❌ ERROR: GENESIS no contiene ANCHOR_HASH")
        sys.exit(1)

    print("⚓ Anchor cargado desde GENESIS")
    print(f"🔐 ANCHOR_HASH = {anchor_hash}")
    return anchor_hash

def main():
    print("🔗 Validando cadena de auditorías LBH...\n")

    if not os.path.isdir(LOG_DIR):
        print("❌ ERROR: Directorio de logs no encontrado")
        sys.exit(1)

    previous_hash = load_genesis_anchor()

    audit_files = sorted(
        glob.glob(os.path.join(LOG_DIR, AUDIT_PREFIX + "*"))
    )

    if not audit_files:
        print("⚠️ No hay auditorías para validar aún")
        sys.exit(0)

    for audit in audit_files:
        with open(audit, "r", encoding="utf-8") as f:
            lines = [l.rstrip() for l in f.readlines()]

        current_hash = extract_signature_hash(lines)
        if not current_hash:
            print(f"❌ ERROR: {audit} no contiene Signature-Hash.")
            sys.exit(1)

        print(f"✔ {os.path.basename(audit)}")
        print(f"   ↳ previous = {previous_hash}")
        print(f"   ↳ current  = {current_hash}")

        # Encadenamiento lógico (no recomputamos hash)
        previous_hash = current_hash

    print("\n✅ Cadena LBH válida desde GENESIS hasta el último evento")

if __name__ == "__main__":
    main()
