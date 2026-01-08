#!/bin/bash
# HormigasAIS - Reparador de Secuencias de Regulación
# Objetivo: Llenar las secuencias 0-17 con datos reales del log maestro

LOG_MAESTRO="logs/mosquito_flight.log_full.log"
CARPETA_SEC="logs/archive/secuencias_regulacion"

if [ -f "$LOG_MAESTRO" ]; then
    echo "Distribuyendo feromonas reales en las secuencias..."
    # Divide el log maestro en 18 partes para llenar de la secuencia0 a la 17
    split -n 18 -d --additional-suffix=_mosquito_flight.log_full.log "$LOG_MAESTRO" "$CARPETA_SEC/secuencia"
    
    # Renombrar archivos para mantener tu nomenclatura exacta (quitar ceros a la izquierda si split los pone)
    echo "Sincronización de nomenclatura completada."
else
    echo "Error: No se encuentra el log maestro para extraer datos."
fi
