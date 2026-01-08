#!/bin/bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🐜 REGULACIÓN DE MEMORIA SOBERANA - RUTA ABSOLUTA

# Definir la base de Termux
BASE_DIR="/data/data/com.termux/files/home/HormigasAIS-Nodo-Escuela"
LOG_PATH="$BASE_DIR/logs/mosquito_flight.log_full.log"
ARCHIVE_PATH="$BASE_DIR/logs/archive/REGULACION_31DIC_04ENE.log"

echo "📡 [XOXO] INICIANDO REGULACIÓN DE FEROMONAS..."

# Verificar si el log existe antes de procesar
if [ ! -f "$LOG_PATH" ]; then
    echo "⚠️ Error: El log original no existe. Creando uno vacío para continuidad..."
    touch "$LOG_PATH"
fi

# 1. Hormiga 10 extrae el hito de fin de año y año nuevo
grep -E "2025-12-31|2026-01-0[1-4]" "$LOG_PATH" > "$ARCHIVE_PATH"

# 2. Limpieza de rastro (Continuidad)
sed -i '/2025-12-31/d; /2026-01-0[1-4]/d' "$LOG_PATH"

echo "🧠 [HORMIGA_10] REGULACIÓN COMPLETADA."
echo "✅ ARCHIVO: $ARCHIVE_PATH"
echo "✅ LOG LIMPIO: $LOG_PATH"

# 3. Sello en el Audit Log
TIMESTAMP=$(date +%s)
echo "{\"timestamp\": $TIMESTAMP, \"type\": \"memory_regulation\", \"status\": \"success\"}" >> "$BASE_DIR/backend/lbh/audit_log.json"
