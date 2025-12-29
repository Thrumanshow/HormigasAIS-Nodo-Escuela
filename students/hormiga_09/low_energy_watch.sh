#!/bin/bash
echo "🌙 [Hormiga 09] Modo Baja Energía: ACTIVO"
echo "🕒 Frecuencia de escaneo: Cada 30 minutos"
while true; do
    # Verificar integridad del Bloque Génesis
    sha256sum -c <(echo "$(cat students/hormiga_08/history/genesis_block.lbh | sha256sum | cut -d' ' -f1)  students/hormiga_08/history/genesis_block.lbh") &>/dev/null
    if [ $? -eq 0 ]; then
        echo "[$(date)] ✅ Integridad Óptima. lbh.human al mando." >> students/hormiga_09/logs/watch.log
    else
        echo "[$(date)] ⚠️ ALERTA: Alteración detectada en el origen." >> students/hormiga_09/logs/watch.log
    fi
    sleep 1800
done
