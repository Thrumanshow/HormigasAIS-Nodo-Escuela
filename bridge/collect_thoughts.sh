#!/bin/bash
for i in {01..10}; do
    echo "[$(date)] Ciclo de pensamiento iniciado para Hormiga_$i" >> students/hormiga_$i/logs/activity.log
done
echo "🧠 [SISTEMA] Pensamientos individuales registrados."
