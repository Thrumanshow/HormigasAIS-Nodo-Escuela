#!/bin/bash
# 🛡️ PROTOCOLO DE BLINDAJE DE PROPIEDAD INTELECTUAL GLOBAL
# Autor: Cristhiam Leonardo Hernández Quiñonez (CLHQ)

DIRS=(
    "$HOME/HormigasAIS-video-intelligence-checker"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS-LBH"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS.com"
    "$HOME/xoxo-lbh-adapter"
)

echo "🔐 [HORMIGA_10] INICIANDO MARCADO DE IP EN REPOSITORIOS CRÍTICOS..."

for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "📂 Procesando: $DIR"
        # Marcamos archivos .sh, .py, .js y .lbh (si existen)
        find "$DIR" -maxdepth 2 -type f \( -name "*.sh" -o -name "*.py" -o -name "*.js" -o -name "*.lbh" \) | while read -r file; do
            # Verificar si ya tiene el sello para no duplicar
            if ! grep -q "CLHQ" "$file"; then
                sed -i "1a # © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)" "$file"
                sed -i "2a # Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH" "$file"
                echo "  ✅ Marcado: $(basename "$file")"
            fi
        done
    else
        echo "⚠️ Directorio no encontrado: $DIR"
    fi
done

echo -e "\n💎 [SISTEMA] El ecosistema de video-inteligencia y adaptadores XOXO ha sido blindado legalmente bajo el mando de CLHQ."
