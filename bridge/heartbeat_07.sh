#!/bin/bash
# 🐜 HormigasAIS - Latido con Generación de Imagen
while true
do
    # 1. Generar datos nuevos
    python3 bridge/solo_ant_telemetry.py > /dev/null
    
    # 2. Mantener buffer ligero
    HEADER=$(head -n 1 visual_demo_stream.csv)
    BODY=$(tail -n 15 visual_demo_stream.csv)
    echo -e "$HEADER\n$BODY" > visual_demo_stream.csv
    
    # 3. DIBUJAR LA NUEVA IMAGEN (Esto es lo que cambia el gráfico en GitHub)
    python3 visualizador_directo.py
    
    # 4. Sincronizar imagen y datos
    git add visual_demo_stream.csv REPORTE_RENDIMIENTO_HORMIGAS.png
    git commit -m "📈 Gráfico Vivo: HORMIGA_07_CORE pulso [$(date +%T)]" --quiet
    git push origin main --quiet
    
    echo "📡 [$(date +%T)] Imagen y Datos actualizados en GitHub."
    sleep 60
done
