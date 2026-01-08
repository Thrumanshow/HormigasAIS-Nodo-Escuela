#!/bin/bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🔍 AUDITOR EXTERNO DE SOBERANÍA - VERSIÓN 2.0
BASE_DIR="/data/data/com.termux/files/home/HormigasAIS-Nodo-Escuela"
DOCS_DIR="$BASE_DIR/backend/docs"
BACKEND_DIR="$BASE_DIR/backend/lbh"
INDEX_FILE="$DOCS_DIR/INDICE_SOBERANO.md"
AUDIT_LOG="$BACKEND_DIR/audit_log.json"
SEQ_FILE="$BACKEND_DIR/sequence_tracker.txt"

echo "🔍 [AUDITOR] INICIANDO INSPECCIÓN DE 3 CAPAS..."
ERRORES=0

# CAPA 1: Documentos (.md)
echo "📑 Revisando Documentos..."
for doc in $DOCS_DIR/*.md; do
    fname=$(basename "$doc")
    if [[ "$fname" == "INDICE_SOBERANO.md" ]]; then continue; fi
    fhash=$(grep "$fname" "$INDEX_FILE" | awk -F'|' '{print $4}' | tr -d '.' | xargs)
    CURRENT_HASH=$(sha256sum "$doc" | awk '{print $1}')
    if [[ "$CURRENT_HASH" == "$fhash"* ]]; then
        echo "✅ $fname: OK"
    else
        echo "❌ $fname: CORRUPTO"; ERRORES=$((ERRORES+1)); fi
done

# CAPA 2: Secuencias (El Directorio de Tiempo)
echo -e "\n⏳ Revisando Directorio de Secuencias..."
LAST_SEQ_HASH=$(tail -n 1 "$AUDIT_LOG" | grep -oP 'seq_hash": "\K[^"]+')
CURRENT_SEQ_HASH=$(sha256sum "$SEQ_FILE" | awk '{print $1}')
if [[ "$CURRENT_SEQ_HASH" == "$LAST_SEQ_HASH" ]]; then
    echo "✅ Secuencia: INTEGRIDAD OK"
else
    echo "❌ Secuencia: DESINCRONIZADA"; ERRORES=$((ERRORES+1)); fi

# CAPA 3: Audit Log (Libro Mayor)
echo -e "\n📝 Revisando Libro Mayor..."
LAST_AUDIT_HASH=$(tail -n 1 "$AUDIT_LOG" | grep -oP 'audit_hash": "\K[^"]+')
ACTUAL_LOG_HASH=$(head -n -1 "$AUDIT_LOG" | sha256sum | awk '{print $1}')
if [[ "$ACTUAL_LOG_HASH" == "$LAST_AUDIT_HASH" ]]; then
    echo "✅ Audit Log: CONSISTENCIA OK"
else
    echo "❌ Audit Log: HASH NO CONCUERDA"; ERRORES=$((ERRORES+1)); fi

# VERDICTO Y FEROMONAS
echo -e "\n------------------------------------------"
if [ $ERRORES -eq 0 ]; then
    echo "💎 VERDICTO: SOBERANÍA INTACTA."
    echo "📡 [XOXO] -> [HORMIGA_10] -> [STANFORD] -> [ENFERMERA] -> [ESTUDIANTES] 📢 SALUD OK"
else
    echo "🚨 ALERTA: FALLO DE SOBERANÍA DETECTADO."
    exit 1
fi
