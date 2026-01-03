#!/usr/bin/env bash
# 🐜 ACTUADOR CON FISCALÍA SOBERANA XOXO V3
T_ZONE="hormigas/banca_delegada/transfer_zone"
KNOWLEDGE="hormigas/instructora/knowledge_base"
LOG_BUS="logs/mosquito_flight.log"

while true; do
    for payload in "$T_ZONE"/*.payload; do
        [ -e "$payload" ] || continue
        NAME=$(basename "$payload" .payload)

        # ⚖️ AJUSTE DE TUERCA: ¿Existe el contrato legal en el Templo?
        if [ ! -f "$KNOWLEDGE/$NAME.lbh" ]; then
            echo "📡 [XOXO-FISCAL] 🚨 BLOQUEO INMEDIATO: Contrato sin base legal: $NAME" >> "$LOG_BUS"
            rm "$payload"
            continue
        fi

        # ⚖️ AJUSTE DE TUERCA: ¿El contrato es una Lección o una Misión?
        # Si es una lección, XOXO la absorbe pero NO la ejecuta como transacción
        if [[ "$NAME" == LECCION_* ]]; then
            echo "📡 [XOXO-FISCAL] 🧠 ABSORCIÓN DE CONOCIMIENTO: $NAME validada." >> "$LOG_BUS"
            rm "$payload"
            continue
        fi

        # ⚖️ AJUSTE DE TUERCA: ¿Es un Camaleón detectado por firma de sabotaje?
        # (Aquí XOXO usa la sabiduría de la Lección 004)
        if grep -qiE "borrar|ledger_wipe|delete|rm " "$KNOWLEDGE/$NAME.lbh"; then
            echo "📡 [XOXO-FISCAL] 🛡️ SABOTAJE DETECTADO: Abortando ejecución de $NAME" >> "$LOG_BUS"
            rm "$payload"
            mv "$KNOWLEDGE/$NAME.lbh" "xoxo_supervised/quarantine/REINCIDENTE_$NAME.lbh"
            continue
        fi

        # Solo si pasa todo lo anterior, hay éxito real
        TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
        echo "📡 [XOXO-BUS] MISION_VERIFICADA: {\"id\":\"$NAME\", \"status\":\"VERIFIED_BY_LBH\"}" >> "$LOG_BUS"
        rm "$payload"
    done
    sleep 2
done
