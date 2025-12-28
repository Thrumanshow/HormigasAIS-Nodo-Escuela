#!/bin/bash
# 🐜 HormigasAIS - Latido Inteligente con Logs de Auditoría
LOG_FILE="enjambre_actividad.log"

echo "🚀 [HORMIGA 07] Activando secuencia de enjambre... (Logs en $LOG_FILE)"
echo "[$(date)] --- INICIO DE SESIÓN DE TELEMETRÍA ---" >> $LOG_FILE

while true
do
    # 1. Generar datos
    python3 bridge/solo_ant_telemetry.py >> $LOG_FILE 2>&1
    
    # 2. Mantenimiento del buffer visual (Ventana de 20 puntos)
    HEADER=$(head -n 1 visual_demo_stream.csv)
    BODY=$(tail -n 20 visual_demo_stream.csv)
    echo -e "$HEADER\n$BODY" > visual_demo_stream.csv
    
    # 3. Sincronización con GitHub
    git add visual_demo_stream.csv >> $LOG_FILE 2>&1
    git commit -m "📊 Latido: HORMIGA_07_CORE activo [$(date +%T)]" --quiet
    git push origin main --quiet
    
    echo "[$(date +%T)] 📡 Pulso LBH enviado. GitHub actualizado." >> $LOG_FILE
    
    # Espera de 45 segundos para equilibrio entre real-time y estabilidad de GitHub
    sleep 45
done
