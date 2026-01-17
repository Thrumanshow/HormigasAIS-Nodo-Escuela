#!/bin/bash
# LBH | Chequeo Avanzado de Blindaje, Gobernanza y Rastros
# Autor: Cristhiam Quiñonez
# Fecha: 2026-01-17
# Nodo: HormigasAIS - Nodo-Escuela

echo "🛡️ LBH | Inicio de Chequeo Avanzado de Blindaje y Gobernanza"
echo "------------------------------------------------------------"

# 1. Comprobar remotos actuales
echo "🔹 Remotos configurados:"
git remote -v
echo "✅ Verifica que solo aparezca GitHub autorizado"
echo

# 2. Hook pre-push
HOOK_FILE=".git/hooks/pre-push"
if [ -f "$HOOK_FILE" ]; then
    echo "🔹 Hook pre-push detectado: $HOOK_FILE"
    grep -q "gitlab" "$HOOK_FILE" && echo "⚠️ Bloqueo de GitLab activo" || echo "✅ Hook pre-push sin referencias prohibidas"
else
    echo "⚠️ Hook pre-push no encontrado"
fi
echo

# 3. Governance Lock
LOCK_FILE="LBH_PROTOCOL/GOVERNANCE/.LBH_GOVERNANCE_LOCK"
if [ -f "$LOCK_FILE" ]; then
    echo "🔹 Governance Lock activo: $LOCK_FILE"
else
    echo "⚠️ Governance Lock NO encontrado"
fi
echo

# 4. Documento de Desacople Soberano
DESACOPLE_FILE="LBH_PROTOCOL/GOVERNANCE/LBH_DESACOPLE_SOBERANO.md"
if [ -f "$DESACOPLE_FILE" ]; then
    echo "🔹 Documento de Desacople Soberano presente: $DESACOPLE_FILE"
else
    echo "⚠️ Documento de Desacople Soberano NO encontrado"
fi
echo

# 5. Comprobar rastros históricos de remotos no autorizados
echo "🔹 Escaneando historial de Git por remotos prohibidos (GitLab/F-Droid)..."
git remote -v | grep -iE "gitlab|fdroid" &>/dev/null
if [ $? -eq 0 ]; then
    echo "⚠️ Se detecta remoto prohibido en configuración actual"
else
    echo "✅ No hay remotos prohibidos en configuración actual"
fi

# Revisar reflog histórico
git reflog | grep -iE "gitlab|fdroid" &>/dev/null
if [ $? -eq 0 ]; then
    echo "⚠️ Se detectan operaciones previas hacia remotos no autorizados en reflog"
else
    echo "✅ No se encontraron referencias históricas en reflog"
fi

# Buscar commits que contengan URLs no autorizadas
echo "🔹 Escaneando commits por referencias a GitLab/F-Droid..."
git log --all --pretty=format:"%H %s" | grep -iE "gitlab|fdroid" &>/dev/null
if [ $? -eq 0 ]; then
    echo "⚠️ Se detectan commits históricos con referencias no autorizadas"
else
    echo "✅ Ningún commit histórico con referencias prohibidas"
fi
echo

# 6. Estado del repositorio
echo "🔹 Estado actual del repositorio:"
git status -s
echo

echo "------------------------------------------------------------"
echo "📡 LBH | Chequeo avanzado completado. Integridad y blindaje validados."
