# 🛡️ HormigasAIS: Política de Seguridad y Soberanía

## 🐜 Filosofía de la Colonia
HormigasAIS opera bajo el principio de **"Soberanía en el Borde" (Edge Sovereignty)**. La inteligencia reside en el protocolo LBH, pero la privacidad de los datos es absoluta y local.

## 🛡️ Blindaje de Datos
Este repositorio implementa una política de exclusión estricta para garantizar que la propiedad intelectual y los datos sensibles nunca abandonen el nodo local:

* **Identidad Financiera:** La lista de inversionistas (`investors_list.csv`) está blindada mediante `git-index` y `.gitignore`.
* **Criptografía:** Todas las llaves privadas (`*.key`, `*.pem`) están excluidas de la sincronización remota.
* **Trazabilidad Silenciosa:** Los logs de vigilancia (`logs/`) son de consumo local para auditoría del Fundador.

## 🛠️ Protocolos de Auditoría
Para verificar la integridad del blindaje, el Operador Maestro utiliza:
\`\`\`bash
git ls-files --others --ignored --exclude-standard
\`\`\`

## 🐜 Reporte de Vulnerabilidades
Cualquier anomalía detectada por el **Centinela** o la hormiga **hola_ant** debe ser reportada directamente al Ingeniero de Protocolos Inteligentes, **Cristhiam Leonardo Hernández Quiñonez**.

---
**"La colonia no reside en la plataforma, reside en el protocolo."**
