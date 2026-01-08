#!/bin/bash
# 🎓 AUDITORÍA CRUZADA DE SOBERANÍA IP - HORMIGA STANFORD
# Objetivo: Identificar archivos críticos sin el sello legal de CLHQ.

DIRS=(
    "$HOME/HormigasAIS-video-intelligence-checker"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS-LBH"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS.com"
    "$HOME/xoxo-lbh-adapter"
    "$HOME/HormigasAIS-Nodo-Escuela"
)

echo "🎓 [STANFORD] INICIANDO AUDITORÍA CRUZADA DE IP..."
echo "------------------------------------------------"
ARCHIVOS_SIN_SELLO=0

for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "🔍 Escaneando integridad en: $DIR"
        # Buscamos archivos de código que NO contengan la firma CLHQ
        find "$DIR" -maxdepth 2 -type f \( -name "*.sh" -o -name "*.py" -o -name "*.js" -o -name "*.lbh" \) | while read -r file; do
            if ! grep -q "CLHQ" "$file"; then
                echo "  🚨 ALERTA: Archivo sin soberanía detectado -> $(basename "$file")"
                ((ARCHIVOS_SIN_SELLO++))
            fi
        done
    fi
done

echo "------------------------------------------------"
if [ $ARCHIVOS_SIN_SELLO -eq 0 ]; then
    echo "💎 [STANFORD]: Auditoría completada. El 100% de los archivos críticos poseen el sello de CLHQ."
    echo "LBH: [IP_AUDIT:SUCCESS] [SOVEREIGNTY:MAXIMAL]"
else
    echo "⚠️ [STANFORD]: Se encontraron $ARCHIVOS_SIN_SELLO archivos vulnerables."
    echo "Sugerencia: Re-ejecutar 'marcar_territorio_ip_global.sh' para sellar brechas."
fi
