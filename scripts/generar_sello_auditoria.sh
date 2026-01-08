#!/bin/bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🔐 SELLO MAESTRO DE SOBERANÍA - LIMPIEZA TOTAL
BASE_DIR="/data/data/com.termux/files/home/HormigasAIS-Nodo-Escuela"
BACKEND_DIR="$BASE_DIR/backend/lbh"
AUDIT_LOG="$BACKEND_DIR/audit_log.json"
SEQ_FILE="$BACKEND_DIR/sequence_tracker.txt"

# 1. Limpiar el Audit Log: Quitar sellos previos, líneas vacías y espacios al final
grep -v "audit_hash" "$AUDIT_LOG" | sed '/^\s*$/d' | sed 's/[[:space:]]*$//' > "$AUDIT_LOG.tmp"

# 2. Calcular hashes sobre contenido limpio
CURRENT_LOG_HASH=$(sha256sum "$AUDIT_LOG.tmp" | awk '{print $1}')
SEQ_HASH=$(sha256sum "$SEQ_FILE" | awk '{print $1}')

# 3. Reconstruir Audit Log con formato estándar (sin líneas vacías al final)
cat "$AUDIT_LOG.tmp" > "$AUDIT_LOG"
echo "{\"timestamp\": $(date +%s), \"type\": \"checkpoint_master\", \"status\": \"sovereign_secured\", \"seq_hash\": \"$SEQ_HASH\", \"audit_hash\": \"$CURRENT_LOG_HASH\"}" >> "$AUDIT_LOG"

rm "$AUDIT_LOG.tmp"
echo "✅ INFRAESTRUCTURA SELLADA: $CURRENT_LOG_HASH"
