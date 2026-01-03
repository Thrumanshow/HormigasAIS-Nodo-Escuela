#!/usr/bin/env bash
# 🔐 LBH — Sellado determinístico de referencias externas

REF_PATH="contracts/external_refs/GEMINI_HANDSHAKE.ref.lbh"

if [ ! -f "$REF_PATH" ]; then
  echo "❌ ERROR: Referencia externa no encontrada."
  exit 1
fi

TMP_FILE="$(mktemp)"

# Excluir SIGNATURE_HASH antes de calcular el hash
grep -v '^SIGNATURE_HASH=' "$REF_PATH" > "$TMP_FILE"

HASH=$(sha256sum "$TMP_FILE" | awk '{print $1}')
rm "$TMP_FILE"

# Insertar el hash sellado
sed -i "s/^SIGNATURE_HASH=.*/SIGNATURE_HASH=$HASH/" "$REF_PATH"

echo "✅ Referencia externa sellada correctamente"
echo "🔐 SIGNATURE_HASH=$HASH"
