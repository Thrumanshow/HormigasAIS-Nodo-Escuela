# Arquitectura de Agentes — HormigasAIS
## Capa 4: Autoridad de Ejecución

---

## Propósito
Este documento define la **separación formal entre agentes autónomos (privados)** y
**agentes públicos (observables)** dentro del ecosistema HormigasAIS.

La Capa 4 establece **quién puede ejecutar**, **quién solo explica**, y **dónde la ejecución está prohibida**.

Este archivo es **declarativo, explicativo y auditable**.  
No activa, habilita ni dispara ningún proceso.

---

## Principio Fundamental
> **Un agente público puede explicar el sistema, pero nunca accionarlo.**

La ejecución de lógica soberana está estrictamente separada del espacio público,
educativo y observacional.

---

## 🔒 Agentes Autónomos (Privados / Soberanos)

### Definición
Agentes que **piensan, validan o ejecutan lógica** bajo control humano directo,
fuera del espacio público.

### Características
- ⚠️ No expuestos públicamente
- ⚙️ Pueden ejecutar lógica real
- 👤 Requieren **Modo Maestro**
- 📍 Contexto: **local / offline**
- 🧾 Auditables, pero **no observables públicamente**

### Ejemplos (por rol)

#### Centinela / Guardia
- `perimetro_centinela.py`
- `lbh_blindaje_permanente.sh`

#### Validadores internos
- `Stanford_LBH_Validator.py`
- `verify_integrity.py`

#### Agentes XOXO soberanos
- `XOXO_simulador_defensa.py`
- `XOXO_protocolo_sincronizacion.py`

#### Motores
- **HormigasAIS-Engine**
- **HormigasAIS-Protocol-Node** (en modo privado)

### Regla de Oro
> **Un agente autónomo nunca vive ni se ejecuta en GitHub.**

---

## 🌐 Agentes Públicos (Expuestos / Observables)

### Definición
Agentes, entidades o artefactos que **no ejecutan lógica**, y existen únicamente
para **explicar, documentar, enseñar u observar**.

### Características
- 👁️ Observables públicamente
- ❌ No ejecutan scripts
- 📚 Educativos / informativos
- 🧊 Read-only
- 🌍 Aceptables para academia, gobierno y comunidad

### Ejemplos
- Documentación:
  - `EXECUTION_POLICY.md`
  - `GOVERNANCE.md`
  - `ARCHITECTURE.md`
- Repositorios espejo:
  - **TheAntsMind**
- Labs educativos
- Demos
- Visualizaciones
- Diagramas
- Simulaciones **no ejecutables**

---

## Límite de Ejecución: GitHub

GitHub **NO** es un entorno de ejecución para HormigasAIS.

- Ningún script soberano está autorizado a ejecutarse en GitHub.
- No se permiten GitHub Actions para lógica autónoma.
- GitHub es utilizado exclusivamente para:
  - Documentación
  - Transparencia
  - Revisión
  - Educación

---

## Contexto Institucional
Esta arquitectura está diseñada para ser:
- Comprensible por **academia**
- Auditable por **instituciones**
- Clara para **gobiernos**
- Segura para **comunidad abierta**

La separación entre **explicación** y **ejecución** es intencional y obligatoria.

---

## Declaración Final
La **Capa 4 — Autoridad de Ejecución** es una capa de gobierno,
no de activación técnica.

Nada en este repositorio ejecuta agentes autónomos.

---

© 2026 HormigasAIS — Nodo-Escuela  
Arquitectura soberana, humana y auditable.
