#!/bin/bash
# ANT-10: Motor de Destilación LBH Sincrónico

INBOX="xoxo_supervised/cleared"
KBASE="hormigas/instructora/knowledge_base"

process_file() {
    local f="$1"
    local base_name=$(basename "$f" .ref.lbh)
    local output_file="$KBASE/${base_name}.lbh"
    
    echo "🐜 [ANT-10] Destilando: $base_name"
    
    # Crear estructura base
    echo "[LBH_FRAME]" > "$output_file"
    echo "ID=$(sha256sum "$f" | awk '{print $1}')" >> "$output_file"
    
    # Extraer DATA de forma segura con xxd
    local hex_data=$(xxd -p "$f" | tr -d '\n')
    echo "DATA=$hex_data" >> "$output_file"
    
    # Limpieza soberana
    rm "$f"
    echo "✅ [ANT-10] Conocimiento consolidado en $output_file"
}

echo "🚀 [ANT-10] Vigilando flujo en $INBOX..."
while true; do
    for file in "$INBOX"/*.ref.lbh; do
        if [ -e "$file" ]; then
            process_file "$file"
        fi
    done
    sleep 1
done
