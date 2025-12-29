#!/bin/bash
set -e

AGENTE="HORMIGA_07_CORE"
REPO_ADAPTER="$HOME/HormigasAIS-video-intelligence-checker/xoxo-lbh-adapter"
FECHA_ACTUAL=$(date '+%Y-%m-%d %H:%M:%S')

echo "🛡️ [SINCRO SOBERANA] Corrigiendo desvío y transportando..."

# 1. Producción
python3 bridge/solo_ant_telemetry.py
python3 bridge/task_visual_manager.py "$AGENTE"

# 2. Nodo Escuela Update
sed -i "s|Última Actualización:.*|Última Actualización: $FECHA_ACTUAL CST (LBH-Validated)|g" README.md
git add REPORTE_RENDIMIENTO_HORMIGAS.png visual_demo_stream.csv README.md
if ! git diff --cached --quiet; then
    git commit -m "📈 Gráfico Vivo: $AGENTE [$FECHA_ACTUAL]" --quiet
    git push origin main --quiet
fi

# 3. EL PASAPORTE (Con alineación forzada)
if [ -d "$REPO_ADAPTER" ]; then
    cp REPORTE_RENDIMIENTO_HORMIGAS.png "$REPO_ADAPTER/"
    cp visual_demo_stream.csv "$REPO_ADAPTER/"
    
    cd "$REPO_ADAPTER"
    git fetch origin main --quiet
    git checkout main --quiet
    # Alineamos local con la nube para evitar el [rejected]
    git reset --hard origin/main --quiet
    
    if ! grep -q "REPORTE_RENDIMIENTO_HORMIGAS.png" README.md; then
        sed -i 's|Rendimiento del Enjambre|Rendimiento del Enjambre\n\n![Soberanía LBH](REPORTE_RENDIMIENTO_HORMIGAS.png)|g' README.md
    fi
    
    git add .
    if ! git diff --cached --quiet; then
        git commit -m "🚀 SINCRONIZACIÓN SOBERANA: Pulso [$FECHA_ACTUAL]" --quiet
        git push origin main --force --quiet
        echo "✅ xoxo-lbh-adapter: Sincronizado y Alineado."
    fi
    cd - > /dev/null
fi
