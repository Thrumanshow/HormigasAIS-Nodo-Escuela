#!/bin/bash
# HormigasAIS - Alineador Maestro de Cronología LBH
# Nodo: San Miguel, El Salvador | Fecha Ref: 7 de Enero 2026

LOG_MAESTRO="logs/mosquito_flight.log_full.log"
CARPETA_SEC="logs/archive/secuencias_regulacion"

echo "--- Iniciando Operación de Limpieza Técnica LBH ---"

# 1. Función para mover líneas por patrón de fecha
ordenar_por_fecha() {
    PATRON=$1
    DESTINO=$2
    if [ -f "$LOG_MAESTRO" ]; then
        # Extraemos las líneas que coinciden y las movemos al destino
        grep "$PATRON" "$LOG_MAESTRO" >> "$DESTINO"
        # Limpiamos el archivo destino de duplicados por si acaso
        sort -u "$DESTINO" -o "$DESTINO"
        echo "  [OK] Datos de $PATRON movidos a $(basename $DESTINO)"
    fi
}

# 2. Re-alineación según tu lógica de 5 días (Margen de 3 meses)

# EXCEPCIÓN: Datos de Diciembre (como los que enviaste) van al log de transición
ordenar_por_fecha "2025-12-" "logs/archive/REGULACION_31DIC_04ENE.log"

# SECUENCIA 0: 1 al 5 de Enero
ordenar_por_fecha "2026-01-01" "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log"
ordenar_por_fecha "2026-01-02" "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log"
ordenar_por_fecha "2026-01-03" "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log"
ordenar_por_fecha "2026-01-04" "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log"
ordenar_por_fecha "2026-01-05" "$CARPETA_SEC/secuencia0_mosquito_flight.log_full.log"

# SECUENCIA 1: 6 al 10 de Enero (Donde estamos hoy)
ordenar_por_fecha "2026-01-06" "$CARPETA_SEC/secuencia1_mosquito_flight.log_full.log"
ordenar_por_fecha "2026-01-07" "$CARPETA_SEC/secuencia1_mosquito_flight.log_full.log"

# 3. Limpieza de Archivos Vacíos
echo "Limpiando contenedores futuros vacíos..."
find "$CARPETA_SEC" -name "*.log" -size 0 -delete

echo "--- Alineación LBH Completada en San Miguel ---"
