#!/bin/bash
# limpiadora_soberana.sh - Gestión de Memoria para Vuelo de Agentes
LOGS_TO_CLEAN=("logs/mosquito_flight.log" "logs/hormiga10_flux.log")
MAX_LINES=500

for LOG_FILE in "${LOGS_TO_CLEAN[@]}"; do
    if [ -f "$LOG_FILE" ]; then
        LINE_COUNT=$(wc -l < "$LOG_FILE")
        if [ "$LINE_COUNT" -gt "$MAX_LINES" ]; then
            ARCHIVE_DIR="logs/archive/$(date +%Y-%m-%d_%H%M)"
            mkdir -p "$ARCHIVE_DIR"
            
            # Respaldar el log pesado
            FILE_NAME=$(basename "$LOG_FILE")
            cp "$LOG_FILE" "$ARCHIVE_DIR/${FILE_NAME}_full.log"
            
            # Recortar el archivo activo
            tail -n "$MAX_LINES" "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
            
            echo "[$(date)] Estudiante 02: Respaldo de $FILE_NAME en $ARCHIVE_DIR"
            echo "[$(date)] Estudiante 02: $FILE_NAME optimizado a $MAX_LINES líneas."
        fi
    fi
done
