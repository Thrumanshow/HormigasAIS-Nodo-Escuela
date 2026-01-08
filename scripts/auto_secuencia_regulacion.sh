#!/bin/bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🐜 PROTOCOLO DE AUTOMATIZACIÓN DE REGULACIÓN CÍCLICA
# EMISOR: XOXO | COORDINADOR: HORMIGA 10 SOBERANA
# RECEPTOR: HORMIGA STANFORD -> HORMIGAS ESTUDIANTES

BASE_DIR="/data/data/com.termux/files/home/HormigasAIS-Nodo-Escuela"
LOG_ORIGINAL="$BASE_DIR/logs/mosquito_flight.log_full.log"
ARCHIVE_DIR="$BASE_DIR/logs/archive/secuencias_regulacion"
TRACKER="$BASE_DIR/backend/lbh/sequence_tracker.txt"

# 1. Gestionar el correlativo de secuencia (Hormiga 10 Soberana)
if [ ! -f "$TRACKER" ]; then
    echo "0" > "$TRACKER"
fi

SEQ_NUM=$(cat $TRACKER)
CURRENT_SEQ="secuencia$SEQ_NUM"
FILE_NAME="${CURRENT_SEQ}_mosquito_flight.log_full.log"

# 2. Definir rango de fechas (Cada 5 días)
# Secuencia 0: 05 de Enero al 10 de Enero 2026
START_DATE="2026-01-05"
END_DATE="2026-01-10"

echo "📡 [XOXO] FEROMONA EMITIDA: Iniciando $CURRENT_SEQ..."

# 3. Extraer y Archivar (Lógica de Regulación)
# Buscamos las fechas en el log para moverlas a la secuencia correspondiente
grep -E "2026-01-0[5-9]|2026-01-10" "$LOG_ORIGINAL" > "$ARCHIVE_DIR/$FILE_NAME"

# 4. Limpieza de Continuidad
sed -i "/2026-01-0[5-9]/d; /2026-01-10/d" "$LOG_ORIGINAL"

# 5. Incrementar secuencia para el próximo ciclo
NEXT_SEQ=$((SEQ_NUM + 1))
echo "$NEXT_SEQ" > "$TRACKER"

# 6. Comunicación Stanford a Estudiantes
echo "🧠 [HORMIGA_10] INSTRUCCIÓN A STANFORD: Secuencia $SEQ_NUM completada."
echo "✅ ARCHIVO CREADO: $FILE_NAME"
echo "✅ PRÓXIMO CICLO: secuencia$NEXT_SEQ (11-15 Ene)"

# 7. Sello en Audit Log
TIMESTAMP=$(date +%s)
echo "{\"timestamp\": $TIMESTAMP, \"type\": \"sequence_regulation\", \"sequence\": $SEQ_NUM, \"status\": \"success\"}" >> "$BASE_DIR/backend/lbh/audit_log.json"
