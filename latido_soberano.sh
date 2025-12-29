#!/bin/bash
# 🐜 HormigasAIS - Latido con Firma de Soberanía CLHQ
# Desarrollador: Cristhiam Leonardo Hernández Quiñonez

echo "---------------------------------------------------"
echo "🛡️ SISTEMA DE COMANDO SOBERANO LBH"
read -p "🔑 Ingrese Firma del Fundador (Prefijo CLH): " FIRMA

# Validación mediante Python del Módulo de Soberanía
VALIDACION=$(python3 -c "import sys; sys.path.append('bridge'); from soberania_clhq import validar_firma_fundador; print(validar_firma_fundador('$FIRMA'))")

if [ "$VALIDACION" == "True" ]; then
    echo "🚀 LATIDO SOBERANO INICIADO - Identidad Validada."
    while true; do
        echo "⏱️  $(date '+%Y-%m-%d %H:%M:%S') - Disparando ciclo..."
        ./ejecutar_ciclo_soberano.sh
        echo "💤 Esperando 60 segundos..."
        sleep 60
    done
else
    echo "❌ ERROR: Firma no reconocida. Acceso denegado a la colonia."
    exit 1
fi
