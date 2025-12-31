#!/bin/bash
# robust_xoxo_h10_e0f.sh
# Flujo robusto y aislado: XOXO vs Hormiga 10 soberana

# 1️⃣ Crear carpetas de logs y archivado
mkdir -p logs/xoxo logs/hormiga10 archive/contracts_rejected

# 2️⃣ Función para inyectar contrato E0F
prepare_contract() {
  cat << 'E0F' > xoxo_supervised/inbox/MISION_CUMPLIDA_LBH.ref.lbh
ORIGEN=HORMIGA_RAIZ
FECHA=2025-12-31
ESTADO=POST-GENESIS_VERIFIED
[HUMAN_NEED]
Confirmar destilación LBH con herramientas restauradas.
[SOLUTION_PROPOSAL]
Validación de flujo con xxd (Vim 9.1).
[CONTENT]
Nodo-Escuela El Salvador: Activo y Soberano.
E0F
  echo "Contrato E0F inyectado en inbox de XOXO"
}

# 3️⃣ Función para iniciar procesos solo si no están activos
start_if_not_running() {
  local cmd=$1
  local name=$2
  local log_path=$3
  if pgrep -f "$cmd" > /dev/null; then
    echo "$name ya está corriendo. PID(s): $(pgrep -f "$cmd" | tr '\n' ' ')"
  else
    nohup "$cmd" > "$log_path" 2>&1 &
    local pid=$!
    echo "$name iniciado en segundo plano con PID: $pid"
  fi
}

# 4️⃣ Monitorear contratos neutralizados solo para registro (no mover)
monitor_neutralized() {
  while true; do
    for file in xoxo_supervised/neutralized/*.ref.lbh; do
      [ -e "$file" ] || continue
      echo "Contrato neutralizado detectado (no se mueve): $file"
    done
    sleep 5
  done
}

# 5️⃣ Ejecutar flujo
prepare_contract
start_if_not_running "./scripts/xoxo_fiscalizacion_soberana.sh" "XOXO" "logs/xoxo/xoxo_background.log"
start_if_not_running "./scripts/lbh_flux_advanced_hormiga10_bg.sh" "Hormiga 10 soberana" "logs/hormiga10/h10_background.log"
monitor_neutralized &

echo "Flujos separados y aislados: XOXO vs Hormiga 10"
echo "Pulso estable activo. Logs en logs/xoxo y logs/hormiga10"
