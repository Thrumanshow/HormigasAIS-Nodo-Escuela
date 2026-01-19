# Documento de Desacople Soberano

**Proyecto:** HormigasAIS – Nodo-Escuela  
**Marco:** LBH (Lenguaje Binario HormigasAIS)  
**Estado:** Activo / Blindaje Permanente

---

## 1. Propósito

Este documento establece el desacople soberano permanente del repositorio
**HormigasAIS-Nodo-Escuela** frente a plataformas, flujos o infraestructuras
no autorizadas (ej. GitLab), garantizando:

- Integridad del código
- Soberanía operativa
- Prevención de fugas accidentales o refactors peligrosos
- Control humano explícito sobre el ciclo de vida del repositorio

El desacople no es una acción política ni comercial, sino **arquitectónica y ética**.

---

## 2. Principio de Soberanía

El Nodo-Escuela es un espacio de aprendizaje, validación y observación,
no de ejecución delegada ni de sincronización automática con terceros.

Principios fundamentales:

- 🔒 Un solo origen autorizado
- 🧠 Decisión humana por encima de la automatización
- 🐜 El enjambre observa, no replica

---

## 3. Origen Único Autorizado

El único remoto permitido es:

- **GitHub / Thrumanshow / HormigasAIS-Nodo-Escuela**

Cualquier intento de:

- agregar remotos alternos
- empujar código a plataformas externas
- sincronizar mirrors automáticos

se considera una **violación del contrato LBH**.

---

## 4. Mecanismo de Blindaje

Se implementa un hook de Git (`pre-push`) que:

- inspecciona los remotos configurados
- detecta referencias a GitLab u otros destinos no autorizados
- bloquea el push de forma inmediata

Este mecanismo es:

- local
- explícito
- reversible solo por decisión humana consciente

---

## 5. Prevención de Riesgos

Este desacople previene:

- PRs “inocentes” con código copiado de adapters
- refactors que comprometan la soberanía del Nodo-Escuela
- sincronizaciones automáticas fuera de contexto
- contaminación del entorno educativo con lógica productiva

---

## 6. Relación con Otros Repositorios

El Nodo-Escuela:

- NO ejecuta código de adapters
- NO sincroniza con nodos productivos
- OBSERVA y documenta, no replica

Cualquier integración debe cumplir estrictamente:

1. Documento formal
2. Revisión humana
3. Aprobación explícita

---

## 7. Declaración Final

> El desacople no es aislamiento.  
> Es conciencia de frontera.

HormigasAIS protege sus nodos no por desconfianza,
sino por **responsabilidad estructural**.

---

**Firmado:**  
Cristhiam Quiñonez  
HormigasAIS – Inteligencia Colaborativa
