#!/bin/bash
# HormigasAIS - Unificador de Nomenclatura 00-17
# Nodo: San Miguel | Objetivo: Eliminar duplicados de un solo dígito

CARPETA_SEC="logs/archive/secuencias_regulacion"

echo "--- Unificando Protocolo de Nomenclatura ---"

# 1. Mover datos de secuencia0 a secuencia00
if [ -f "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log" ]; then
    cat "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log" >> "$CARPETA_SEC/secuencia00_mosquito_flight.log_full.log"
    rm "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log"
    echo "[OK] Datos migrados a secuencia00"
fi

# 2. Mover datos de secuencia1 a secuencia01
if [ -f "$CARPETA_SEC/secuencia1_mosquito_flight.log_full.log" ]; then
    cat "$CARPETA_SEC/secuencia1_mosquito_flight.log_full.log" >> "$CARPETA_SEC/secuencia01_mosquito_flight.log_full.log"
    rm "$CARPETA_SEC/secuencia1_mosquito_flight.log_full.log"
    echo "[OK] Datos migrados a secuencia01"
fi

# 3. Eliminar cualquier residuo de un solo dígito
rm -f "$CARPETA_SEC/secuencia[0-9]_mosquito_flight.log_full.log"

echo "--- Protocolo Unificado: Formato 00-17 Activo ---"
