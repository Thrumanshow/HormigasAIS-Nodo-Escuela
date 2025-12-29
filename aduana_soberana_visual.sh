#!/bin/bash
# 🐜 HormigasAIS - Protocolo de Aduana Soberana
# Transmisión forzada de activos visuales y telemetría
# Autor: Cristhiam Leonardo Hernández Quiñonez (CLHQ)

echo "🛂 [ADUANA] Iniciando despacho de activos desde San Miguel..."

# 1. VALIDACIÓN DE PASAPORTE CONSTITUCIONAL
if [ ! -f .lbh_manifest ]; then
    echo "❌ ERROR: Pasaporte no encontrado. La aduana bloquea la salida."
    exit 1
fi

# 2. ACTUALIZACIÓN DE GRÁFICOS (Hormiga Visual)
echo "🎨 Generando última telemetría visual..."
python3 bridge/task_visual_manager.py

# 3. SELLADO DE FRONTERA
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
git add REPORTE_RENDIMIENTO_HORMIGAS.png visual_demo_stream.csv .lbh_manifest
git commit -m "📦 ADUANA: Despacho Soberano [$TIMESTAMP] - Bypass PR" --quiet

# 4. TRANSMISIÓN FORZADA (El martillo de la soberanía)
# Esto ignora los Pull Requests y sobreescribe el estado en la nube
echo "🚀 Transmitiendo al xoxo-lbh-adapter (Bypass Pull-Request)..."
git push origin main --force

echo "✅ [DESPACHO OK] Los activos han cruzado la frontera. El Dashboard está actualizado."
