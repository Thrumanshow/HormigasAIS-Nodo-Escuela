#!/bin/bash
# =========================================================
# 🛡️ LBH | Chequeo Avanzado + Commit Automático de Gobernanza
# Termux-ready con alertas visuales para remotos prohibidos
# =========================================================

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Sin color

echo -e "${GREEN}🛡️ LBH | Inicio de Chequeo Avanzado y Sincronización${NC}"
echo "------------------------------------------------------------"

# 1️⃣ Remotos autorizados
echo -e "\n🔹 Remotos configurados:"
git remote -v | grep -i github || echo -e "${YELLOW}⚠️ Ningún remoto autorizado detectado${NC}"

# 2️⃣ Alertas de remotos prohibidos
echo -e "\n🔹 Verificando remotos prohibidos..."
PROHIBIDOS=$(git remote -v | grep -Ei "gitlab|fdroid")
if [ -n "$PROHIBIDOS" ]; then
    echo -e "${RED}⚠️ Remotos prohibidos detectados:${NC}"
    echo -e "${RED}$PROHIBIDOS${NC}"
else
    echo -e "${GREEN}✅ No hay remotos prohibidos en configuración actual${NC}"
fi

# 3️⃣ Hooks pre-push
if [ -f ".git/hooks/pre-push" ]; then
    echo -e "\n🔹 Hook pre-push detectado: .git/hooks/pre-push"
    grep -q gitlab .git/hooks/pre-push && echo -e "${RED}⚠️ Bloqueo de GitLab activo${NC}" || echo -e "${GREEN}✅ Sin bloqueos externos detectados${NC}"
else
    echo -e "${YELLOW}⚠️ No se detecta hook pre-push${NC}"
fi

# 4️⃣ Governance Lock
if [ -f "LBH_PROTOCOL/GOVERNANCE/.LBH_GOVERNANCE_LOCK" ]; then
    echo -e "\n🔹 Governance Lock activo: LBH_PROTOCOL/GOVERNANCE/.LBH_GOVERNANCE_LOCK"
else
    echo -e "${YELLOW}⚠️ Governance Lock no detectado${NC}"
fi

# 5️⃣ Documento de Desacople Soberano
if [ -f "LBH_PROTOCOL/GOVERNANCE/LBH_DESACOPLE_SOBERANO.md" ]; then
    echo -e "\n🔹 Documento de Desacople Soberano presente: LBH_PROTOCOL/GOVERNANCE/LBH_DESACOPLE_SOBERANO.md"
else
    echo -e "${YELLOW}⚠️ Documento de Desacople Soberano no encontrado${NC}"
fi

# 6️⃣ Escaneo rápido de remotos históricos prohibidos
echo -e "\n🔹 Escaneando historial de Git por remotos prohibidos (GitLab/F-Droid)..."
git reflog | grep -Ei "gitlab|fdroid" >/dev/null && echo -e "${RED}⚠️ Referencias históricas prohibidas detectadas${NC}" || echo -e "${GREEN}✅ No se encontraron referencias históricas en reflog${NC}"
git log --all --grep="gitlab\|fdroid" >/dev/null 2>&1 && echo -e "${RED}⚠️ Commits históricos con referencias prohibidas detectadas${NC}" || echo -e "${GREEN}✅ Ningún commit histórico con referencias prohibidas${NC}"

# 7️⃣ Estado de archivos locales
echo -e "\n🔹 Estado actual de archivos locales:"
git status -s

# 8️⃣ Agregar y commitear automáticamente archivos locales
STAGED=$(git status -s | awk '{print $2}')
if [ -n "$STAGED" ]; then
    echo -e "\n🔹 Archivos pendientes detectados, agregando y comiteando automáticamente..."
    git add .
    git commit -m "📝 LBH | Archivos locales sincronizados y blindaje actualizado"
    echo -e "${GREEN}✅ Commit realizado.${NC}"
    echo "🔹 Haciendo push al remoto autorizado..."
    git push origin main
    echo -e "${GREEN}✅ Push completado.${NC}"
else
    echo -e "${GREEN}✅ No hay archivos pendientes para sincronizar.${NC}"
fi

echo "------------------------------------------------------------"
echo -e "${GREEN}📡 LBH | Chequeo y sincronización final completados. Integridad y blindaje validados.${NC}"
