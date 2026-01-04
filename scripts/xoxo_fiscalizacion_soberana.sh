#!/usr/bin/env bash
# 🦎 XOXO PORTERO – Soberanía Absoluta LBH
# Solo lo que XOXO valida llega a la Hormiga 10.

INBOX="xoxo_supervised/inbox"
CLEARED="xoxo_supervised/cleared"
QUARANTINE="xoxo_supervised/quarantine"
VEREDICTS="xoxo_supervised/veredicts"
LOG="logs/mosquito_flight.log"

mkdir -p "$INBOX" "$CLEARED" "$QUARANTINE" "$VEREDICTS"

log() {
  echo "⏳ $(date '+%H:%M:%S') — $1" | tee -a "$LOG"
}

emit_veredict() {
  local file="$1"
  local reason="$2"
  local base="$(basename "$file")"
  local final_name="LBH_FAIL_${base}"
  
  cat <<EOF > "$VEREDICTS/${final_name}.veredict"
LBH_VEREDICT=BLOCKED
MOTIVO=$reason
ARCHIVO_ORIGINAL=$base
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
AUTORIDAD=XOXO_FISCALIA_LBH
EOF

  mv "$file" "$QUARANTINE/$final_name"
  log "📡 [XOXO] BLOQUEO Y NEUTRALIZACIÓN | $base | Motivo: $reason"
}

inspect_file() {
  local file="$1"
  log "🐜 XOXO analizando: $(basename "$file")"
  sleep 2

  if ! grep -q "ESTADO=POST-GENESIS_VERIFIED" "$file"; then
    emit_veredict "$file" "ORIGEN_NO_SOBERANO"
    return
  fi

  if grep -Eqi "EXEC:|rm -rf|payload|troyano|malware|shell" "$file"; then
    emit_veredict "$file" "ATAQUE_DETECTADO"
    return
  fi

  # SEGURO: Mover a CLEARED para que la Hormiga 10 pueda procesarlo
  mv "$file" "$CLEARED/$(basename "$file")"
  log "🟢 CONTRATO PURIFICADO -> Movido a 'cleared': $(basename "$file")"
}

log "⚖️ XOXO PORTERO ACTIVO - Nodo El Salvador 🇸🇻"

while true; do
  FOUND=false
  for FILE in "$INBOX"/*.ref.lbh; do
    [ -f "$FILE" ] || continue
    FOUND=true
    inspect_file "$FILE"
  done
  [ "$FOUND" = false ] && log "Pulso estable, sin rastro de contratos."
  sleep 3
done
