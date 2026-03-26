# Proposal: Banco de Estudio: Certificación Ethical Hacking 2026

## Intent

Proporcionar un banco de 100 preguntas de opción múltiple como material de repaso exhaustivo para la Certificación Ethical Hacking 2026. Este recurso actuará como el "Examen Final" o simulacro de preparación para los estudiantes.

## Related Prior Work

No se encontraron patrones similares previos en Engram para bancos de preguntas de esta escala (100 ítems).

## Scope

### In Scope
- Creación de `contenido/banco-preguntas.qmd` con las 100 preguntas.
- Formateo de las preguntas con casillas de verificación (Markdown `- [ ]` y `- [X]`).
- Organización por Dominios (1 al 8) según la estructura proporcionada.
- Integración en el índice lateral de Quarto en una nueva parte denominada "Certificación".

### Out of Scope
- Implementación de lógica interactiva de JavaScript para calificación automática (se mantiene como material de estudio estático/PDF).
- Creación de nuevos laboratorios asociados.

## Approach

1.  **Formato de Contenido**: Se utilizará el formato `.qmd` nativo de Quarto para asegurar que la exportación a PDF y HTML sea impecable.
2.  **Estructura de Navegación**: Se añadirá una nueva entrada en `_quarto.yml` después de la sección de "Laboratorios".
3.  **Estética**: Se mantendrá el estilo visual del curso (Solar theme) y se añadirán metadatos de Quarto para el subtítulo y autoría.

## Affected Areas

| Area | Impact | Description |
|------|--------|-------------|
| `contenido/banco-preguntas.qmd` | New | Archivo con las 100 preguntas de certificación. |
| `_quarto.yml` | Modified | Inclusión de la nueva sección en la navegación del libro. |

## Risks

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| El archivo sea demasiado largo para renderizado PDF | Low | Quarto maneja bien documentos extensos; se dividirá por secciones (Dominios). |
| Inconsistencia en el formato de las preguntas | Medium | Se aplicará un template riguroso para las 100 preguntas. |

## Rollback Plan

1. Eliminar `contenido/banco-preguntas.qmd`.
2. Revertir cambios en `_quarto.yml`.

## Dependencies

- Quarto CLI (ya instalado en el entorno).

## Success Criteria

- [ ] El archivo `contenido/banco-preguntas.qmd` existe y tiene las 100 preguntas.
- [ ] La barra lateral del sitio muestra la sección "Certificación" -> "Banco de Preguntas".
- [ ] El documento se renderiza correctamente en HTML y PDF sin errores de sintaxis.
