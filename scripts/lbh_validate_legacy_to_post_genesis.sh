#!/usr/bin/env bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# ⚖️ LBH VALIDATE LEGACY → POST-GENESIS
# Valida que la cadena histórica post-LEGACY se inicie correctamente
# usando LBH_CHAIN_LEGACY_CUTOFF.log como corte de auditorías previas

LOGS_DIR="logs"
GENESIS_LOG="$LOGS_DIR/LBH_CHAIN_GENESIS.log"
LEGACY_CUTOFF="$LOGS_DIR/LBH_CHAIN_LEGACY_CUTOFF.log"
POST_GENESIS_LOG="$LOGS_DIR/LBH_AUDIT_POST_GENESIS.log"

# 1️⃣ Verificar existencia de archivos
for f in "$GENESIS_LOG" "$LEGACY_CUTOFF" "$POST_GENESIS_LOG"; do
    if [ ! -f "$f" ]; then
        echo "❌ ERROR: Archivo faltante: $f"
        exit 1
    fi
done

echo "🔗 Validando cadena HISTÓRICA usando corte LEGACY..."

# 2️⃣ Cargar hash de corte LEGACY
ANCHOR_HASH=$(grep "ANCHOR_HASH=" "$LEGACY_CUTOFF" | cut -d'=' -f2)
if [ -z "$ANCHOR_HASH" ]; then
    echo "❌ ERROR: No se pudo obtener ANCHOR_HASH desde $LEGACY_CUTOFF"
    exit 2
fi
echo "⚓ Anchor cargado desde LEGACY CUTOFF"
echo "🔐 ANCHOR_HASH = $ANCHOR_HASH"

# 3️⃣ Validar hash del primer evento POST-GENESIS
POST_HASH=$(grep "SIGNATURE_HASH=" "$POST_GENESIS_LOG" | cut -d'=' -f2)
if [ -z "$POST_HASH" ]; then
    echo "❌ ERROR: $POST_GENESIS_LOG no contiene SIGNATURE_HASH."
    exit 3
fi

# 4️⃣ Comparar ANCHOR_HASH del corte con ANCHOR_REFERENCE del post-GENESIS
POST_ANCHOR_REF=$(grep "ANCHOR_HASH=" "$POST_GENESIS_LOG" | cut -d'=' -f2)
if [ "$POST_ANCHOR_REF" != "$ANCHOR_HASH" ]; then
    echo "❌ ERROR: ANCHOR_HASH del POST-GENESIS no coincide con el LEGACY CUTOFF"
    exit 4
fi

echo "✅ Cadena post-GENESIS válida y correctamente anclada al corte LEGACY"
echo "🔐 POST-GENESIS SIGNATURE_HASH = $POST_HASH"

