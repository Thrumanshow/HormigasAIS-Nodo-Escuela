#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "🛡️ LBH | Blindaje Permanente iniciado"

authorized_origin="github.com"

for remote in $(git remote); do
  url=$(git remote get-url "$remote")
  if ! echo "$url" | grep -q "$authorized_origin"; then
    echo "❌ Remoto no autorizado detectado: $remote -> $url"
    echo "🧹 Eliminando remoto $remote"
    git remote remove "$remote"
  fi
done

# Compactación final
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo "✅ Blindaje aplicado"
git remote -v

echo "[XOXO-BUS] 📡 ESTADO: BLINDAJE_PERMANENTE_ACTIVO"
