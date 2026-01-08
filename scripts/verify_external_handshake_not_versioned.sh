#!/usr/bin/env bash
# © 2025-2026 HormigasAIS - Proyectado por Cristhiam Leonardo Hernández Quiñonez (CLHQ)
# Propiedad Intelectual Protegida bajo el Protocolo de Soberanía LBH
# ⚖️ LBH VERIFY — External Handshake Non-Versioning Guard
# Verifica que los contratos de IA externa NO estén versionados en el repo

HANDSHAKE_PATH="contracts/external/GEMINI_HANDSHAKE.lbh"

echo "🔍 Verificando soberanía de handshakes externos..."

# 1. Verificar que el archivo existe localmente
if [ ! -f "$HANDSHAKE_PATH" ]; then
  echo "❌ ERROR: Handshake externo NO existe localmente."
  exit 1
fi

# 2. Verificar si Git lo está rastreando
if git ls-files --error-unmatch "$HANDSHAKE_PATH" >/dev/null 2>&1; then
  echo "🚨 VIOLACIÓN DE SOBERANÍA DETECTADA"
  echo "El archivo $HANDSHAKE_PATH está versionado en Git."
  echo "Esto NO está permitido para contratos de IA externa."
  exit 2
else
  echo "✅ OK: Handshake externo NO está versionado."
  echo "🔐 Soberanía del Nodo preservada."
fi

exit 0
