#!/bin/bash
# =========================================================
# 🛡️ LBH | Soberano Unlock
# Termux-ready, restaura permisos completos a archivos críticos
# =========================================================

LOCKED_FILES=(
    "LBH_PROTOCOL/GOVERNANCE/LBH_DESACOPLE_SOBERANO.md"
    "LBH_PROTOCOL/GOVERNANCE/.LBH_GOVERNANCE_LOCK"
    "LBH_PROTOCOL/SCRIPTS/lbh_advanced_check_soberano.sh"
)

echo "🛡️ LBH | Acción: unlock"
echo "------------------------------------------------------------"

for file in "${LOCKED_FILES[@]}"; do
    if [ -f "$file" ]; then
        chmod u=rwX,g=rX,o=rX "$file"
        echo "🔓 $file permisos restaurados (edición y ejecución para propietario)"
    else
        echo "⚠️ Archivo no encontrado: $file"
    fi
done

echo "------------------------------------------------------------"
echo "📡 LBH | Unlock completado. Archivos listos para edición segura."
