#!/bin/bash
# -------------------------------------------------------------------
# HormigasAIS - PROTOCOLO DE SALTO DE FRONTERA (HORMIGA INSTRUCTORA)
# ORIGEN: Nodo-Escuela (Privado)
# DESTINO: Thrumanshow/Hola-ant (Público/Perímetro)
# AUTORIDAD: Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# -------------------------------------------------------------------

ID_SALTO=$(date +%s)
PASAPORTE="PASAPORTE_HOLA_ANT_VALIDADO.json"

echo "[🐜 INSTRUCTORA] Iniciando secuencia de salto para hola_ant..."

# 1. Verificación de Pasaporte Soberano
if [ ! -f "$PASAPORTE" ]; then
    echo "[❌ ERROR] No se detecta Pasaporte Validado. Salto denegado."
    exit 1
fi

# 2. Preparación del Perímetro Defensivo (JavaScript)
echo "[🛡️ PERÍMETRO] Inyectando ADN LBH en el entorno de destino..."
# Sincronizamos el archivo de identidad con el repositorio de destino
# Usamos un mensaje de commit que la colonia reconozca como un salto oficial
git add "$PASAPORTE"
git commit -m "🐜 HORMIGA_VIAJERA: Salto de Frontera ID_$ID_SALTO [PUSH_OK] | ADN_LBH_VALIDADO"

# 3. Ejecución del Salto (Push al repositorio público)
echo "[📡 XOXO-BUS] Transfiriendo agente al repositorio público..."
# Nota: Esto asume que el remote 'origin' apunta a Thrumanshow/Hola-ant
# o que se ha configurado el puente correctamente.
git push origin main

echo "------------------------------------------------------------"
echo "🚀 SALTO COMPLETADO: hola_ant ha cruzado la frontera."
echo "ID DE OPERACIÓN: $ID_SALTO"
echo "------------------------------------------------------------"
