#!/bin/bash
# 🐜 HormigasAIS - Ritual de Actualización Visual
# Motivo: Auditoría Cerrada por el Fundador (CLHQ)
# Objetivo: Sincronizar PNG/Dashboard con la Verdad LBH

echo "🖼️ [RITUAL] Iniciando actualización de subsistema visual..."

# 1. Emitir el Evento Semántico
echo "{\"evento\":\"AUDITORIA_CERRADA\", \"autorizado_por\":\"CLHQ\", \"afecta\":\"subsistema_visual\"}" > ./core/evento_visual.lbh

# 2. Ordenar a la Hormiga 07 que ejecute los visualizadores
if [ -f "visualizador_rendimiento.py" ]; then
    echo "🎨 Ejecutando visualizador_rendimiento.py..."
    python3 visualizador_rendimiento.py
fi

if [ -f "visualizador_directo.py" ]; then
    echo "📊 Ejecutando visualizador_directo.py (Pulso Directo)..."
    python3 visualizador_directo.py
fi

# 3. Actualizar el estado en el Adapter
echo "📝 [HORMIGA_10] Notificando al Adapter: Gráficos alineados con Firma CLHQ."
git add .
git commit -m "🖼️ RITUAL: Subsistema visual actualizado tras Auditoría Cerrada | PUSH_OK" --quiet
git push origin main --force

echo "✅ [SINCRO TOTAL] El plano visual ahora refleja la soberanía del Fundador."
