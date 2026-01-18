#!/bin/bash
# -------------------------------------------------------------------
# HormigasAIS - PROTOCOLO DE VALIDACIÓN SUPERIOR (NODO-ESCUELA)
# AUTORIDAD: Nodo-Escuela (Validador Maestro)
# SUJETO: hola_ant (Aprendiz en NodoEscuela_Gemini)
# -------------------------------------------------------------------

ID_VIAJE=$(date +%s)
# La hormiga está en el archivo de aprendizaje, pero el pasaporte se sella en la raíz
ROOT_DIR="."
LEARNING_DIR="./NodoEscuela_Gemini/hola_ant"

echo "[🐜 NODO-ESCUELA] Validando aprendizaje de hola_ant en Gemini..."

# Verificar que la hormiga haya completado su formación en el archivo Gemini
if [ ! -d "$LEARNING_DIR" ]; then
    echo "[❌ ERROR] No se detecta rastro de aprendizaje en Gemini. Abortando."
    exit 1
fi

# El Nodo-Escuela genera el Pasaporte en su propia jurisdicción (Raíz)
cat << EOT > "$ROOT_DIR/PASAPORTE_HOLA_ANT_VALIDADO.json"
{
  "status": "PASAPORTE_SOBERANO_VALIDADO",
  "validator": "HormigasAIS-Nodo-Escuela",
  "learning_node": "NodoEscuela_Gemini",
  "agent": "hola_ant",
  "timestamp": "$ID_VIAJE",
  "signature_authority": "CLHQ-SOBERANO-2026",
  "protocol": "LBH"
}
EOT

echo "[📡 XOXO-BUS] Sello LBH aplicado. Registrando en auditoria_final.log..."
echo "[$ID_VIAJE] 📜 PASAPORTE_HOLA_ANT emitido por NODO-ESCUELA" >> auditoria_final.log

# Sincronización del repositorio con el nuevo pasaporte validado
git add PASAPORTE_HOLA_ANT_VALIDADO.json auditoria_final.log
git commit -m "🐜 HORMIGA_VIAJERA: Pasaporte validado por NODO-ESCUELA ID_$ID_VIAJE [PUSH_OK]" --quiet

echo "------------------------------------------------------------"
echo "🛂 PASAPORTE EMITIDO POR LA AUTORIDAD SUPERIOR (RAÍZ)"
echo "------------------------------------------------------------"
