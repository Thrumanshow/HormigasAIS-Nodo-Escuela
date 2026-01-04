#!/bin/bash
# robust_xoxo_h10_e0f.sh - V2: Fiscal, Destilador y Banca

mkdir -p logs/xoxo logs/hormiga10 logs/banca archive/contracts_rejected

prepare_contract() {
  cat << 'E0F' > xoxo_supervised/inbox/MISION_CUMPLIDA_LBH.ref.lbh
ORIGEN=HORMIGA_RAIZ
FECHA=2025-12-31
ESTADO=POST-GENESIS_VERIFIED
[CONTENT]
Nodo-Escuela El Salvador: Activo, Soberano y Capitalizado.
E0F
  echo "Contrato E0F inyectado"
}

start_if_not_running() {
  local cmd=$1; local name=$2; local log_path=$3
  if pgrep -f "$cmd" > /dev/null; then
    echo "$name ya activo."
  else
    nohup "$cmd" > "$log_path" 2>&1 &
    echo "$name iniciado. PID: $!"
  fi
}

# Ejecución
prepare_contract
start_if_not_running "./scripts/xoxo_fiscalizacion_soberana.sh" "XOXO" "logs/xoxo/xoxo_background.log"
start_if_not_running "./scripts/lbh_flux_advanced_hormiga10_bg.sh" "ANT-10" "logs/hormiga10/h10_background.log"
start_if_not_running "./scripts/hormiga_banca_contable.sh" "BANCA" "logs/banca/banca_background.log"

echo "📍 Colonia Operativa: Fiscalización -> Destilación -> Capitalización"
