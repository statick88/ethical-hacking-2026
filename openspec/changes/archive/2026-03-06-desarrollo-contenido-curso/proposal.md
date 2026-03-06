# Proposal: Desarrollo de Contenido del Curso — Ethical Hacking 2026

## Intent

El informe de modernización curricular está entregado y aprobado (PDF firmado). El siguiente paso crítico es desarrollar el **contenido real del curso**: las 8 unidades didácticas, 8 laboratorios específicos, 8 sets de quizzes y 8 presentaciones están actualmente en estado esqueleto (36-45 líneas cada unidad, 0 labs específicos, 0 quizzes reales, 0 presentaciones U1-U8).

Además, existen 4 inconsistencias críticas heredadas que deben resolverse antes de publicar cualquier contenido:
1. 4 versiones distintas de la ponderación de evaluación
2. URL con typo: `portsweigger.com` en lugar de `portswigger.net`
3. Links rotos en `presentaciones/index.qmd` (apunta a archivos inexistentes)
4. 6/8 unidades sin bibliografía

## Scope

### In Scope

- **Fix críticos (P0):** Unificar evaluación, corregir URL, reparar links
- **Contenido U1-U8:** Expandir cada unidad de esqueleto a contenido pedagógico real (objetivos, teoría, ejemplos, herramientas, paso a paso)
- **Laboratorios U1-U8:** 1 lab estructurado por unidad con escenario, pasos numerados, capturas esperadas y entregable
- **Quizzes U1-U8:** 10 preguntas de opción múltiple + 2 escenarios prácticos por unidad
- **Presentaciones U1-U8:** Slides en formato Metropolis RevealJS para cada unidad
- **Bibliografía U3-U8:** Agregar referencias IEEE a las 6 unidades que no las tienen
- **Assets:** Diagramas de ataque con excalidraw para unidades clave (U1, U4, U5, U6)

### Out of Scope

- Modificar el informe HTML/PDF ya entregado (`informe_final.html`, `.pdf`)
- Cambiar la estructura de los 8 módulos o su distribución de horas
- Crear infraestructura cloud o laboratorios de pago
- Certificaciones o material de terceros con derechos de autor

## Approach

Desarrollo iterativo por fases. Primero resolver los bugs críticos (P0) que afectan la coherencia del curso, luego desarrollar el contenido por capas: primero todo el contenido teórico (U1-U8 en paralelo), luego labs, luego quizzes, luego presentaciones. Los assets/diagramas van integrados durante el desarrollo de contenido.

La **fuente de verdad de evaluación** será `contenido/unidad8.qmd` (sección Evaluación) y se sincronizará en todos los demás archivos.

Ponderación unificada acordada:
- Laboratorios: **40%**
- Proyecto Final / Reporte: **40%**  
- Examen Teórico: **20%**

## Affected Areas

| Área | Impact | Descripción |
|------|--------|-------------|
| `contenido/unidad{1-8}.qmd` | Modified | Expandir de esqueleto a contenido real (~500-800 líneas c/u) |
| `contenido/unidad{1-8}/` | New | Subcarpetas para assets específicos de cada unidad |
| `labs/infraestructura.md` | Modified | Corregir URL portswigger |
| `labs/lab-unidad{1-8}.md` | New | 1 lab estructurado por unidad |
| `quizzes/unidad{1-8}.md` | New | 10 preguntas + 2 escenarios por unidad |
| `presentaciones/unidad{1-8}.qmd` | New | 8 presentaciones Metropolis RevealJS |
| `presentaciones/index.qmd` | Modified | Corregir links rotos |
| `assets/images/` | New | Diagramas excalidraw y screenshots |
| `_quarto.yml` | Modified | Incluir labs y quizzes en el libro si aplica |

## Risks

| Riesgo | Probabilidad | Mitigación |
|--------|-------------|------------|
| Contenido técnico desactualizado al publicar | Media | Priorizar conceptos sobre herramientas específicas; incluir "última versión" en herramientas |
| Inconsistencia de profundidad entre unidades | Media | Definir template estándar de unidad antes de desarrollar |
| Labs con dependencias de software específico | Baja | Solo usar Docker + Kali Linux como base (ya definido en infra) |
| Sobrecarga de contenido en unidades cortas (U1, U8 = 15h) | Baja | Calibrar cantidad de temas según horas asignadas |

## Rollback Plan

Todo el contenido es aditivo sobre archivos `.qmd` y `.md`. Si una unidad no queda bien:
- Revertir el archivo específico a su versión esqueleto anterior
- El libro Quarto renderiza igual con menos contenido
- No hay base de datos ni estado que revertir

## Dependencies

- Quarto instalado y funcional (ya verificado — book renderiza)
- Extensión Metropolis instalada (ya presente en `_extensions/`)
- Docker + Kali Linux para validar comandos de labs
- Acceso a TryHackMe / HackTheBox para referencias de labs

## Success Criteria

- [ ] Ponderación de evaluación idéntica en los 4 archivos que la mencionan
- [ ] URL `portswigger.net` correcta en `labs/infraestructura.md`
- [ ] 0 links rotos en `presentaciones/index.qmd`
- [ ] Todas las unidades U1-U8 con contenido real (mínimo 300 líneas c/u)
- [ ] 8 labs específicos creados (1 por unidad), con pasos numerados y entregable
- [ ] 8 sets de quizzes creados (10 preguntas + 2 escenarios c/u)
- [ ] 8 presentaciones RevealJS creadas (mínimo 15 slides c/u)
- [ ] Bibliografía IEEE en todas las unidades U1-U8
- [ ] `quarto render` ejecuta sin errores en todo el proyecto
