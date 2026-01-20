#!/bin/bash
echo "🚫 Deteniendo procesos de HormigasAIS para estabilización..."

# 1. Matar procesos activos de Python (mosquitos y centinelas)
pkill -f mosquito_flight.py
pkill -f gestion_enjambre_soberano.py
pkill -f scripts/hormiga_centinela.py

# 2. Limpiar basura del sistema (__pycache__ y logs temporales)
echo "🧹 Limpiando rastro de archivos temporales..."
find . -type d -name "__pycache__" -exec rm -rf {} +
rm -f guardia_nocturna_temp.log
rm -f pulse_activity.log

# 3. Asegurar que el .gitignore proteja el nodo
echo "🛡️ Actualizando escudo .gitignore..."
cat <<GIT > .gitignore
.env*
__pycache__/
*.log
*.log_full.log
*.pyc
boveda_seguridad/
GIT

echo "✅ Nodo estabilizado. El sistema operativo ya no ensuciará tu rastro."
