#!/usr/bin/env bash
# 🐜 LBH FLUX ADVANCED: Gemini → XOXO → Manager Alpha → Hormiga 10
# Flujo completamente automatizado para absorción inmediata
# Ejecución en segundo plano con nohup incorporado

INBOX="xoxo_supervised/inbox"
VALIDATED_DIR="xoxo_supervised/validated"
HORMIGA_10_KNOWLEDGE="hormigas/hormiga_10/knowledge"
LOG_FILE="mosquito_flight.log"

mkdir -p "$VALIDATED_DIR"
mkdir -p "$HORMIGA_10_KNOWLEDGE"

echo "🔄 Iniciando monitor de inbox de Gemini para Hormiga 10..."

# Función para procesar un archivo individual
process_file() {
    FILE="$1"
    [ -e "$FILE" ] || return

    echo "🐜 Manager Alpha detectando rastro: $FILE"

    # 1️⃣ Calcular hash determinístico
    CONTENT_HASH=$(grep -v "SIGNATURE_HASH" "$FILE" | sha256sum | cut -d' ' -f1)

    # 2️⃣ Crear archivo firmado
    SIGNED_FILE="$VALIDATED_DIR/$(basename "$FILE" .ref.lbh).signed.lbh"
    sed "s/SIGNATURE_HASH=PENDING/SIGNATURE_HASH=$CONTENT_HASH/" "$FILE" > "$SIGNED_FILE"
    echo "VALIDATED_BY=MANAGER_ALPHA" >> "$SIGNED_FILE"
    echo "STATUS=ACTIVE" >> "$SIGNED_FILE"

    # 3️⃣ Traducir a Lenguaje-Binario-HormigasAIS
    BIN_FILE="$HORMIGA_10_KNOWLEDGE/$(basename "$FILE" .ref.lbh).lbhbin"
    awk '{for(i=1;i<=length;i++)printf "%08d ",and(255,ord(substr($0,i,1))); print ""}' "$SIGNED_FILE" > "$BIN_FILE"

    # 4️⃣ Registrar feromona en log
    TIMESTAMP=$(date +%s.%N)
    echo "📡 [XOXO-BUS] FEROMONA_EMITIDA: {\"timestamp\": $TIMESTAMP, \"type\": \"contract_signed\", \"origin\": \"manager_alpha\", \"hash\": \"$CONTENT_HASH\", \"recipient\": \"hormiga_10\", \"status\": \"active\"}" >> "$LOG_FILE"

    # 5️⃣ Absorción inmediata por Hormiga 10
    echo "🤖 Hormiga 10 absorbiendo conocimiento de $BIN_FILE..."
    cat "$BIN_FILE" >> "$HORMIGA_10_KNOWLEDGE/internal_knowledge_db.lbhbin"

    # 6️⃣ Limpiar inbox
    rm "$FILE"
    echo "✅ Contrato procesado y absorbido por Hormiga 10: $BIN_FILE"
}

# 7️⃣ Función para iniciar el flujo en segundo plano con nohup
run_background() {
    nohup bash -c '
    while true; do
        for FILE in "$INBOX"/*.ref.lbh; do
            process_file "$FILE"
        done
        sleep 2
    done
    ' > logs/hormiga10_flux.log 2>&1 &
    echo "🚀 Script ejecutándose en segundo plano. Salida: logs/hormiga10_flux.log"
}

# Iniciar flujo en segundo plano
run_background
