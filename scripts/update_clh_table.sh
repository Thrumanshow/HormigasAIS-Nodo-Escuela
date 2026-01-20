#!/bin/bash
# Reemplazo integral de la sección de Estados para mantener Pureza LBH

# 1. Definimos la nueva sección lógica
NUEVA_TABLA="## 7. Estados Operativos Reconocidos (CLH)

| Estado        | Descripción CLH | Ejecución | Auditoría | Clausura |
|--------------|------------------|-----------|-----------|----------|
| **VIVO** | Secuencia activa bajo observación soberana continua | Permitida | Continua | Prohibida sin CLHQ |
| **OBSERVACIÓN** | Secuencia sin ejecución, con lectura y registro | No | Activa | No requerida |
| **SELLADO** | Secuencia cerrada con sello temporal válido | No | Histórica | Completa |
| **ARCHIVADO** | Secuencia sellada y retirada del ciclo operativo | No | Pasiva | Definitiva |"

# 2. Sobrescritura controlada (de la sección 7 en adelante para evitar filas sueltas)
# Esto corta el archivo en la sección 7 y pega la nueva tabla limpia
sed -i '/## 7. Estados/,$d' CLH.md
echo "$NUEVA_TABLA" >> CLH.md

echo "✨ [SISTEMA] Tabla de Estados sincronizada con Pureza 100%."
