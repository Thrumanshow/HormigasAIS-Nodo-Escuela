#!/bin/bash
# 🐜 HormigasAIS - Purga de Lienzo Visual
# Este script limpia el buffer de visualización sin tocar el historial de auditoría.

TARGET_PLOT_DATA="visual_demo_stream.csv"

# Reiniciar el archivo con solo la cabecera para el gráfico
echo -e "FECHA_HORA\tID_HORMIGA\tESTADO\tDATO_VALOR\tFIRMA_LBH" > $TARGET_PLOT_DATA

echo "🧹 [Hormiga 05] Lienzo visual purificado. Listo para nueva lectura."
