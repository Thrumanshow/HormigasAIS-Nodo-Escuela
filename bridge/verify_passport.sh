#!/bin/bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# 🐜 Aduana HormigasAIS - Ritual de Recepción LBH

HORMIGA_PATH=$1

if [ -z "$HORMIGA_PATH" ]; then
    echo "❌ [ADUANA] Error: No se proporcionó el paquete de la hormiga."
    exit 1
fi

echo "🔍 [ADUANA] Iniciando escaneo de pasaporte para: $HORMIGA_PATH..."

# 1. Verificar Firma de Autoridad Raíz
SIGNATURE=$(grep "SIGNATURE:" $HORMIGA_PATH/passport/passport.signature | cut -d' ' -f2)
ISSUER=$(grep "ISSUED_BY:" $HORMIGA_PATH/passport/passport.signature | cut -d' ' -f2)

if [ "$ISSUER" == "lbh.human" ]; then
    echo "✅ [ADUANA] Firma de Autoridad Raíz VALIDADA (Origen: $ISSUER)."
else
    echo "🚫 [ADUANA] ERROR: Autoridad desconocida. Acceso denegado."
    exit 1
fi

# 2. Identificar Clase y asignar permisos
CLASE=$(grep "CLASE:" $HORMIGA_PATH/passport/passport.identity.lbh | cut -d' ' -f2)

case $CLASE in
    "CORE")
        echo "💎 [ADUANA] Clase CORE detectada. Otorgando acceso a Root Health."
        ;;
    "CLIENT")
        echo "💼 [ADUANA] Clase CLIENT detectada. Acceso limitado a Sensores."
        ;;
    "LAB")
        echo "🧪 [ADUANA] Clase LAB detectada. Ejecución en Sandbox estricto."
        ;;
    *)
        echo "⚠️ [ADUANA] Clase no identificada. Permisos mínimos activados."
        ;;
esac

# 3. Verificar Ciclo de Vida
STATUS=$(grep "STATUS:" $HORMIGA_PATH/passport/passport.lifecycle.lbh | cut -d" " -f2)
if [ "$STATUS" == "active" ]; then
    echo "⏳ [ADUANA] Estado: ACTIVO. Vigencia confirmada."
else
    echo "🚫 [ADUANA] ERROR: El pasaporte está $STATUS. Acceso denegado."
    exit 1
fi
echo "✨ [ADUANA] Ritual completado. La Hormiga puede iniciar operaciones."
