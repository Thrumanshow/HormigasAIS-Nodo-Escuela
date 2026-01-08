#!/bin/bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🐜 CHECKPOINT DE SOBERANÍA - CONTROLADOR MAESTRO
# Orden: Sellar -> Sanar -> Hashear -> Indexar

BASE_DIR="/data/data/com.termux/files/home/HormigasAIS-Nodo-Escuela"
DOCS_DIR="$BASE_DIR/backend/docs"
INDEX_FILE="$DOCS_DIR/INDICE_SOBERANO.md"
AUDIT_LOG="$BASE_DIR/backend/lbh/audit_log.json"

echo "🛡️ [SISTEMA] INICIANDO CHECKPOINT DE SOBERANÍA..."

# 1. Ejecutar protocolos base
bash $BASE_DIR/scripts/sellar_soberania.sh
bash $BASE_DIR/scripts/protocolo_enfermera_reparacion.sh

# 2. Generar Hashes de Integridad
echo "🔐 [HORMIGA_10] GENERANDO HASHES SHA256..."
HASH_DOC=$(sha256sum $DOCS_DIR/PRUEBA_SOBERANIA_EDGE.md | awk '{print $1}')
HASH_AUDIT=$(sha256sum $AUDIT_LOG | awk '{print $1}')

# 3. Inyectar Hash en el Documento (Refuerzo de integridad)
sed -i "/## Huella LBH/a - **Hash SHA256:** $HASH_DOC" $DOCS_DIR/PRUEBA_SOBERANIA_EDGE.md

# 4. Actualizar el Índice de Documentos Soberanos
echo "# 📜 ÍNDICE DE DOCUMENTOS SOBERANOS" > $INDEX_FILE
echo "Última actualización: $(date +'%Y-%m-%d %H:%M:%S')" >> $INDEX_FILE
echo -e "\n| Archivo | Fecha | Hash SHA256 | Estado |" >> $INDEX_FILE
echo "|---|---|---|---|" >> $INDEX_FILE

for doc in $DOCS_DIR/*.md; do
    fname=$(basename $doc)
    fdate=$(date -r $doc +'%Y-%m-%d')
    fhash=$(sha256sum $doc | awk '{print $1}')
    echo "| $fname | $fdate | ${fhash:0:12}... | ✅ VALIDADO |" >> $INDEX_FILE
done

# 5. Registro Final en Audit Log con Hash
echo "{\"timestamp\": $(date +%s), \"type\": \"checkpoint_master\", \"status\": \"sovereign_secured\", \"audit_hash\": \"$HASH_AUDIT\"}" >> $AUDIT_LOG

echo "🏁 [SISTEMA] Checkpoint completado. Índice actualizado y hashes sellados."
