#!/bin/bash
# 📜 PROPAGACIÓN DE LICENCIA SOBERANA HORMIGASAIS
# Cobertura: Video Intelligence, LBH Core, Web & Adapters

SOURCE_LICENSE="$HOME/HormigasAIS-Nodo-Escuela/backend/docs/LICENCIA_SOBERANA_CLHQ.md"
TARGET_DIRS=(
    "$HOME/HormigasAIS-video-intelligence-checker"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS-LBH"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS.com"
    "$HOME/xoxo-lbh-adapter"
)

echo "📜 [H10_SOBERANA] PROPAGANDO TÉRMINOS LEGALES..."

for DIR in "${TARGET_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        cp "$SOURCE_LICENSE" "$DIR/LICENCIA_SOBERANA.md"
        echo "  ✅ Licencia establecida en: $DIR"
    else
        echo "  ⚠️ Directorio omitido (no encontrado): $DIR"
    fi
done

echo -e "\n💎 [SISTEMA] Manifiesto Global de Licencia Soberana desplegado bajo el mando de CLHQ."
