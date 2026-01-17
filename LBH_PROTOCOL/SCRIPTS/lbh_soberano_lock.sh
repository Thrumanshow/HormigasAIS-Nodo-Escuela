#!/bin/bash
# =========================================================
# 🛡️ LBH | Soberano Lock Quirúrgico Mejorado
# Termux-ready, protege archivos críticos y mantiene ejecutables
# =========================================================

LOCKED_FILES=(
    "LBH_PROTOCOL/GOVERNANCE/LBH_DESACOPLE_SOBERANO.md"
    "LBH_PROTOCOL/GOVERNANCE/.LBH_GOVERNANCE_LOCK"
    "LBH_PROTOCOL/SCRIPTS/lbh_advanced_check_soberano.sh"
)

BACKUP_DIR="LBH_PROTOCOL/GOVERNANCE/.backup_LBH"

echo "🛡️ LBH | Acción: lock"
echo "------------------------------------------------------------"

mkdir -p "$BACKUP_DIR"

for file in "${LOCKED_FILES[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "$BACKUP_DIR"
        chmod u=rwX,g=rX,o=rX "$file"
        echo "🔒 $file protegido, ejecución permitida"
    else
        echo "⚠️ Archivo no encontrado: $file"
    fi
done

echo "------------------------------------------------------------"
echo "📡 LBH | Lock quirúrgico completado. Archivos críticos protegidos."
