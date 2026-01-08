# GOBERNANZA_TEMPORAL_LBH.md

## Constitución del Tiempo de HormigasAIS

**GOBERNANZA_TEMPORAL_LBH.md es la Constitución del tiempo de HormigasAIS.** No es exageración:  
el código ejecuta,  
los logs prueban,  
este documento legitima.

---

## 1. Propósito
Este documento define las reglas, límites y estados bajo los cuales el tiempo es gobernado dentro del ecosistema HormigasAIS y su protocolo LBH.

En este sistema:
- el tiempo **no es implícito**,
- el tiempo **no es asumido**,
- el tiempo es un **recurso soberano gobernado por contrato**.

---

## 2. Principio Fundamental
Ningún proceso, agente, nodo o adaptación puede operar fuera de una **ventana temporal explícitamente válida**.

Toda actividad:
- ocurre dentro de una secuencia,
- pertenece a un ciclo,
- y puede ser auditada retrospectivamente.

---

## 3. Definiciones Clave

**Secuencia** Unidad temporal lógica que agrupa eventos coherentes bajo un mismo estado de gobernanza.

**Ciclo** Periodo completo con inicio, operación y cierre sellado. Un ciclo cerrado **no se reabre**.

**Ventana Temporal** Intervalo autorizado para ejecución, validación o silencio operativo.

**Silencio Gobernado** Estado válido donde no hay ejecución, pero sí registro y legitimidad.

---

## 4. Estados Temporales Válidos
Un Nodo LBH solo puede existir en uno de los siguientes estados:

- **PRE-DESPLIEGUE**: Preparación sin ejecución productiva.
- **ACTIVO**: Ejecución autorizada dentro de secuencia válida.
- **HIBERNACIÓN**: Pausa consciente y documentada.
- **MANTENIMIENTO**: Ajustes técnicos sin explotación operativa.
- **COMERCIAL**: Operación bajo licencia e IP activa.

Cualquier estado no listado aquí se considera **inválido**.

---

## 5. Reglas No Negociables
1. Ningún agente escribe fuera de su secuencia.
2. Una secuencia cerrada no acepta eventos.
3. El silencio sin documentación es una violación.
4. Los límites temporales no se optimizan ni se omiten.
5. Todo cambio de estado queda registrado y sellado.
6. El Nodo-Escuela **nunca ejecuta código del Adapter**.

---

## 6. Relación con Licencia e IP
- La explotación comercial solo es válida en estado **COMERCIAL**.
- Estados PRE-DESPLIEGUE, HIBERNACIÓN y MANTENIMIENTO **no habilitan explotación**.
- IP generada fuera de ventana válida carece de legitimidad operativa.
- El tiempo gobierna la validez de la IP, no al revés.

---

## 7. Auditoría y Verificación
La auditoría se basa en registros de estado, sellos temporales, hashes de integridad y contratos LBH activos.
El log prueba que algo ocurrió. Este documento prueba que **podía ocurrir**.

---

## 8. Autoridad y Cambios
- Este archivo es normativo.
- Solo puede modificarse mediante commit explícito, registro de motivo y validación soberana (CLHQ).

---

## 9. Cierre
En HormigasAIS: el código ejecuta, los logs prueban, **la gobernanza temporal legitima**.
Todo lo que no esté dentro del tiempo gobernado existe solo como ruido.
