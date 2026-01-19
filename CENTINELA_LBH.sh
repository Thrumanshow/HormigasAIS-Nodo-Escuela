#!/bin/bash
# -------------------------------------------------------------------
# HormigasAIS - CENTINELA DE PERÍMETRO (DEFENSA ACTIVA)
# AGENTE: hola_ant | AUTORIDAD: CLHQ
# -------------------------------------------------------------------

# Hash de Soberanía Actual
SABER_MAESTRO="8d5420b"

echo "[🐜 CENTINELA] Iniciando escaneo de integridad en el perímetro..."

# 1. Verificar conexión con el XOXO-BUS
if git ls-remote perimetro > /dev/null 2>&1; then
    echo "[📡 XOXO-BUS] Conexión estable con Hola-ant."
else
    echo "[⚠️ ALERTA] ¡PERÍMETRO INACCESIBLE! Posible caída de nodo externo."
    exit 1
fi

# 2. Comparar Hash remoto con ADN Validado
HASH_REMOTO=$(git rev-parse perimetro/main | cut -c1-7)

if [ "$HASH_REMOTO" == "$SABER_MAESTRO" ]; then
    echo "[✅ SEGURO] El ADN en el perímetro coincide con el Sello de Oro ($SABER_MAESTRO)."
    echo "[🐜 LBH] Estado: Vigilancia Silenciosa Activa."
else
    echo "[🚨 ALERTA ROJA] ¡DERIVA DE ADN DETECTADA!"
    echo "Hash Maestro: $SABER_MAESTRO | Hash Detectado: $HASH_REMOTO"
    echo "Iniciando Protocolo de Restauración Soberana..."
    # Auto-curación: Forzar el ADN correcto sobre la anomalía
    git push perimetro main --force
fi
