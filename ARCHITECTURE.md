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

---

## Archivos locales no versionados
 
(Runtime soberano):

El Nodo-Escuela puede generar y utilizar archivos locales que no forman parte del Núcleo versionado y, por diseño, no se sincronizan con GitHub.
Estos archivos existen únicamente en el entorno local de ejecución y cumplen funciones operativas, de seguridad o de observación temporal.
Características de estos archivos:
No representan estado arquitectónico del sistema
No contienen lógica nuclear versionada
No son requeridos para clonar, compilar o auditar el repositorio
No deben ser incluidos en commits ni pull requests
Su exclusión es intencional y está gobernada por .gitignore
Ejemplos de categorías locales no versionadas:
Variables de entorno y credenciales (.env*)
Registros de actividad y trazabilidad local (*.log)
Artefactos humanos o de certificación (*.human)
Scripts operativos de uso local (scripts/, *.sh, *.py)
Documentación dinámica generada en tiempo real
La presencia de estos archivos no indica error, desalineación ni estado inconsistente del repositorio.
Su coexistencia con el Núcleo es una decisión arquitectónica consciente que preserva la soberanía, seguridad y estabilidad del Nodo-Escuela.
