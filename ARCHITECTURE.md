# Arquitectura del Núcleo HormigasAIS – Nodo-Escuela

Este repositorio constituye el **Núcleo operativo y soberano** del sistema HormigasAIS.
Su función es educativa, estructural y de validación conceptual.

No está diseñado para exposición pública directa ni para consumo como servicio.

---

## Puerto informativo externo (solo lectura)

Existe un puerto público informativo externo, de carácter **estático y no operativo**,
destinado únicamente a presencia institucional y referencia documental.

Este puerto:

- No ejecuta código
- No expone lógica, claves ni interfaces
- No mantiene dependencia técnica con el Núcleo
- No recibe datos, eventos ni tráfico de retorno
- No actúa como API, frontend activo ni servicio intermedio

Su función es **exclusivamente informativa y declarativa**.

El Núcleo de HormigasAIS **no depende** de dicho puerto para su operación,
validación, ejecución ni toma de decisiones.

---

## Principio de separación

La arquitectura mantiene una separación estricta entre:

- **Núcleo**: lógica, contratos, validaciones, aprendizaje y soberanía
- **Puertos externos**: documentación estática y presencia informativa

Cualquier interpretación distinta a esta separación se considera inválida
dentro del diseño del sistema.
