#!/bin/bash
# 📡 HORMIGASAIS - VINCULACIÓN DE NODO Y RED (Híbrido)
# Autor: CLHQ | Sello de Soberanía LBH

echo "🔍 Detectando identidad de red para el nodo..."

# Intentar obtener IP pública desde internet
IP_PUBLICA=$(curl -s --max-time 5 https://api.ipify.org)

# Si falla, usar IP local (Resiliencia LBH)
if [ -z "$IP_PUBLICA" ]; then
    echo "⚠️ No se detectó internet. Usando IP local..."
    IP_PUBLICA=$(hostname -I | awk '{print $1}')
fi

if [ -z "$IP_PUBLICA" ]; then
    IP_PUBLICA="127.0.0.1"
    echo "❗ Usando Loopback por falta de interfaces activas."
fi

# Guardar IP en el manifiesto maestro
IP_FILE="$HOME/HormigasAIS-Nodo-Escuela/backend/docs/IP_SOBERANA_CLHQ.md"
mkdir -p "$(dirname "$IP_FILE")"
echo "📌 IP AUTORIZADA: $IP_PUBLICA" > "$IP_FILE"
echo "Arquitecto: CLHQ" >> "$IP_FILE"
echo "Fecha de Registro: $(date)" >> "$IP_FILE"

# Directorios críticos para propagación
TARGET_DIRS=(
    "$HOME/HormigasAIS-video-intelligence-checker"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS-LBH"
    "$HOME/HormigasAIS-video-intelligence-checker/HormigasAIS.com"
    "$HOME/xoxo-lbh-adapter"
)

# Propagar IP a los directorios del enjambre
echo "📡 [H10_SOBERANA] PROPAGANDO IP AUTORIZADA..."
for DIR in "${TARGET_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        cp "$IP_FILE" "$DIR/IP_SOBERANA.md"
        echo "  ✅ IP establecida en: $DIR"
    else
        echo "  ⚠️ Directorio omitido: $DIR"
    fi
done

# Sellar la configuración y auditar (Cierre de Seguridad)
echo "🔒 Generando sello de infraestructura y auditando..."
bash ~/HormigasAIS-Nodo-Escuela/scripts/generar_sello_auditoria.sh
bash ~/HormigasAIS-Nodo-Escuela/scripts/auditor_externo_hashes.sh

echo -e "\n💎 [SISTEMA] Nodo vinculado con IP: $IP_PUBLICA"
echo "LBH: [NODE_BIND:SUCCESS] [IP_SOVEREIGNTY:ACTIVE]"
