# Arquitectura del Núcleo HormigasAIS – Nodo-Escuela

## Propósito del repositorio

El repositorio **Nodo-Escuela** constituye el núcleo pedagógico y experimental del ecosistema HormigasAIS.
Su función principal es **enseñar, validar y documentar principios**, no ejecutar sistemas productivos ni automatizaciones activas.

Este repositorio existe para:
- Definir contratos conceptuales y técnicos.
- Servir como espacio de aprendizaje controlado.
- Documentar decisiones arquitectónicas sin riesgo operativo.
- Evitar acoplamientos prematuros con entornos externos.

Nodo-Escuela **no es un runtime**, es un **espacio de formación y validación**.

---

## Principios arquitectónicos

1. **Soberanía del núcleo**  
   El núcleo no depende de servicios externos para existir o ser comprendido.

2. **No ejecución por defecto**  
   Ningún archivo del núcleo se ejecuta automáticamente.

3. **Claridad > Automatización**  
   La legibilidad y la intención pesan más que la optimización.

4. **Separación estricta de dominios**  
   El aprendizaje no debe contaminar la operación.

5. **Git como registro, no como oráculo**  
   GitHub refleja el diseño, no el estado real del sistema local.

---

## Separación de dominios (Núcleo vs Externo)

**Núcleo (este repositorio):**
- Documentación
- Especificaciones
- Protocolos
- Diagramas conceptuales
- Ejemplos no ejecutables

**Externo (fuera del repositorio):**
- Scripts activos
- Adaptadores
- Automatizaciones
- Llaves, tokens, estados
- Experimentos de runtime

Esta separación es **intencional y obligatoria**.

---

## Puerto informativo externo (solo lectura)

El Nodo-Escuela puede:
- Referenciar comportamientos externos
- Documentar resultados
- Explicar flujos

Pero **nunca ejecuta ni importa** código externo activo.

Todo enlace externo se considera:
> Informativo, no operativo.

---

## Política de ejecución y dependencia

- No se permite ejecución automática de scripts.
- No se permiten dependencias activas obligatorias.
- No se aceptan PRs que introduzcan:
  - `cron`
  - `daemon`
  - `webhooks activos`
  - ejecución implícita

Cualquier ejemplo ejecutable debe:
- Estar claramente marcado como demostrativo.
- No ejecutarse sin acción explícita del usuario.

---

## Archivos locales no versionados (runtime soberano)

Existen archivos que **sí funcionan localmente**, pero **no deben ser versionados**.

Estos archivos:
- Son válidos.
- Son funcionales.
- Son deliberadamente invisibles para GitHub mediante `.gitignore`.

Ejemplos comunes:
- Logs de ejecución
- Estados temporales
- Scripts de prueba local
- Variables de entorno
- Adaptadores en fase experimental

El uso de `.gitignore` **no invalida** estos archivos.
Al contrario:
> Preserva la soberanía del runtime local y evita conflictos estructurales.

GitHub **no necesita verlos** para que el sistema funcione.

---

## Gobernanza y cambios estructurales

Cualquier cambio que afecte:
- La política de ejecución
- La separación de dominios
- El rol del Nodo-Escuela

Debe:
1. Justificarse explícitamente.
2. Documentarse antes de implementarse.
3. No romper la soberanía del núcleo.

Las decisiones arquitectónicas pesan más que la conveniencia técnica inmediata.

---

## Notas finales

Nodo-Escuela no compite con producción.
Nodo-Escuela **protege el pensamiento**.

La arquitectura aquí descrita es un contrato.
Romperlo implica rediseñar, no improvisar.
