# Design: Desarrollo de Contenido del Curso — Ethical Hacking 2026

## Technical Approach

El proyecto es un libro Quarto (`type: book`) que compila 8 unidades `.qmd` en HTML y PDF. La estrategia técnica es **extensión aditiva**: agregar contenido real a los archivos esqueleto existentes sin cambiar la arquitectura del libro ni tocar los entregables ya aprobados (`informe_final.html`, `.pdf`).

Los fixes P0 van primero (son bloqueantes para la coherencia del curso). Luego el contenido se desarrolla en orden: unidades → labs → quizzes → presentaciones. Los assets (diagramas excalidraw) se crean inline durante el desarrollo de contenido.

## Architecture Decisions

### Decision: Fuente de Verdad de Evaluación

**Choice**: `contenido/unidad8.qmd` sección `## Evaluación` como fuente canónica. Los demás archivos DEBEN referenciar o replicar exactamente esa ponderación.

**Alternatives considered**:
- Crear un `_variables.yml` global de Quarto con la ponderación — descartado por complejidad innecesaria para 4 ocurrencias
- Mantener cada archivo independiente — descartado porque fue la causa del bug actual

**Rationale**: `unidad8.qmd` es la unidad de cierre del curso; es el lugar semánticamente correcto para definir evaluación. Simple, directo, sin magia.

---

### Decision: Estructura de Labs — Markdown en `/labs/`

**Choice**: Un archivo `labs/lab-unidadN.md` por unidad, en Markdown plano. Los labs NO se incluyen en el `_quarto.yml` como capítulos del libro — son documentos de referencia independientes.

**Alternatives considered**:
- Incluir labs dentro de cada `contenido/unidadN.qmd` — descartado porque hace los archivos de contenido demasiado largos y mezcla teoría con práctica
- Agregar labs como capítulos del libro Quarto — descartado porque cambia la estructura del libro ya definida en `_quarto.yml`

**Rationale**: El libro ya tiene su estructura fija (8 unidades en `contenido/`). Los labs son material de soporte, no capítulos. Markdown plano es más portable y el estudiante puede usarlo independientemente.

---

### Decision: Estructura de Quizzes — Markdown en `/quizzes/`

**Choice**: Un archivo `quizzes/unidadN.md` por unidad, en Markdown plano con formato de pregunta estandarizado (igual que `guia.md` existente).

**Alternatives considered**:
- Formato JSON (como sugiere `guia.md`) — descartado porque dificulta la lectura directa y el profesor necesita revisarlos fácilmente
- Incluir quizzes en el libro Quarto — descartado por la misma razón que los labs

**Rationale**: Consistencia con el patrón ya establecido en `guia.md`. El instructor puede convertirlos a cualquier formato (Google Forms, Moodle) desde Markdown.

---

### Decision: Presentaciones — RevealJS con Metropolis

**Choice**: Un archivo `presentaciones/unidadN.qmd` por unidad, usando el tema Metropolis ya instalado en `_extensions/shafayetShafee/metropolis/`. Mismo frontmatter que `unidad0_intro.qmd`.

**Alternatives considered**:
- PowerPoint export desde Quarto — descartado, Metropolis RevealJS ya está instalado y funcionando
- Presentaciones separadas del repo Quarto — descartado, innecesario

**Rationale**: Reutilizar exactamente el mismo setup que `unidad0_intro.qmd`. Patrón ya validado, extensión ya instalada. Cero nueva infraestructura.

---

### Decision: Diagrama de Ataque con Excalidraw

**Choice**: Usar la extensión `parmsam/excalidraw` (ya instalada) para diagramas en unidades U1 (reconocimiento), U4 (AD attack path), U5 (kill chain) y U6 (evasión flow).

**Alternatives considered**:
- Imágenes PNG estáticas — descartado, excalidraw ya está instalado y da diagramas editables
- Mermaid diagrams (soporte nativo Quarto) — válida alternativa, pero excalidraw es más expresivo para attack flows

**Rationale**: La extensión está instalada pero nunca se usó. Es el momento de amortizarla.

---

### Decision: Bibliografía — Links Markdown con texto descriptivo

**Choice**: Para U3-U8, agregar bibliografía como lista de links Markdown con texto descriptivo (igual que U1-U2 existentes). NO usar formato IEEE numérico en el código fuente.

**Alternatives considered**:
- Formato IEEE estricto `[N] Apellido, ...` — descartado porque U1-U2 usan links simples y hay que ser consistentes
- BibTeX con `bibliography:` en frontmatter — descartado por sobreingeniería

**Rationale**: Consistencia con el patrón ya establecido en U1 y U2. El formato IEEE se reserva para el informe HTML/PDF (que ya está entregado).

---

## Data Flow

```
_quarto.yml
    │
    ├── index.qmd (portada)
    │
    └── contenido/unidad{1-8}.qmd  ←── Fuente de verdad de contenido
            │
            ├── Referencia → labs/lab-unidad{N}.md     (ejecutable independiente)
            ├── Referencia → quizzes/unidad{N}.md      (evaluación independiente)
            └── Alineado  → presentaciones/unidad{N}.qmd  (slides de la sesión)

presentaciones/index.qmd
    └── Links → presentaciones/unidad{0-8}.qmd

_extensions/
    └── metropolis/ → usado por presentaciones/unidad{0-8}.qmd
    └── excalidraw/ → usado en contenido/unidad{1,4,5,6}.qmd
```

## File Changes

| Archivo | Acción | Descripción |
|---------|--------|-------------|
| `labs/infraestructura.md` | Modify | Corregir `portsweigger.com` → `portswigger.net` (línea 29) |
| `presentaciones/index.qmd` | Modify | Corregir links — referenciar solo archivos existentes hasta que se creen |
| `contenido/unidad8.qmd` | Modify | Unificar evaluación (40/40/20) como fuente canónica |
| `quizzes/guia.md` | Modify | Actualizar ponderación a 40/40/20 |
| `presentaciones/unidad0_intro.qmd` | Modify | Actualizar ponderación a 40/40/20 (slide de Metodología) |
| `contenido/unidad{1-8}.qmd` | Modify | Expandir de esqueleto a contenido real (300-800 líneas) + bibliografía U3-U8 |
| `contenido/unidad{1-8}/` | Modify | Poblar subcarpetas con assets si aplica |
| `labs/lab-unidad{1-8}.md` | Create | 8 labs nuevos con estructura estándar |
| `quizzes/unidad{1-8}.md` | Create | 8 sets de quizzes (10 preguntas + 2 escenarios) |
| `presentaciones/unidad{1-8}.qmd` | Create | 8 presentaciones RevealJS con Metropolis |
| `assets/images/` | Create | Diagramas excalidraw para U1, U4, U5, U6 |

## Interfaces / Contracts

### Template de Unidad (contenido/unidadN.qmd)

```markdown
# Unidad N: {Título}

## Objetivos de Aprendizaje

- {Verbo Bloom} {objeto de aprendizaje medible}
- ...

## Contenido Teórico

### N.1 {Subtema}

{Explicación real, mínimo 5 líneas}

```bash
# Ejemplo de comando si aplica
comando --opcion valor
```

### N.2 {Subtema}
...

## Herramientas

| Herramienta | Propósito | Instalación / URL |
|-------------|-----------|-------------------|
| ...         | ...       | ...               |

## Laboratorio

> Ver [`labs/lab-unidadN.md`](../labs/lab-unidadN.md) para el escenario completo.

**Escenario:** {descripción breve del lab}

## Recursos Adicionales

- [Título recurso](URL)

## Bibliografía

- [Nombre oficial del recurso](URL)
```

### Template de Lab (labs/lab-unidadN.md)

```markdown
# Lab N: {Título}

## Objetivo
## Prerrequisitos
## Entorno
## Escenario
## Pasos
### Paso 1: {nombre}
```bash
comando
```
**Output esperado:** `...`

### Paso 2: {nombre}
...

## Resultado Esperado
## Entregable
## Recursos
```

### Template de Quiz (quizzes/unidadN.md)

```markdown
# Quiz Unidad N: {Título}

**Puntaje mínimo:** 7/10 (70%)

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

{Enunciado}

a) ...
b) ...
c) ...
d) ...

**Respuesta correcta:** {letra}
**Explicación:** ...

...

## Escenarios Prácticos

### Escenario 1

**Situación:** ...
**Pregunta:** ...
**Respuesta esperada:** ...
**Criterios:** ...
```

### Template de Presentación (presentaciones/unidadN.qmd)

```yaml
---
title: "Unidad N: {Título}"
subtitle: "Ethical Hacking 2026 — ABACOM"
author: "Diego Saavedra"
institute: "ABACOM"
format:
  metropolis-revealjs:
    slide-number: true
    transition: slide
    center: true
    footer: "Ethical Hacking 2026 - ABACOM"
---
```

## Testing Strategy

| Capa | Qué verificar | Cómo |
|------|--------------|------|
| Estructura | Todos los archivos de labs/quizzes/presentaciones existen | `ls` en cada directorio |
| Contenido | Líneas mínimas por archivo | `wc -l` en cada unidad |
| Links | 0 links rotos en presentaciones/index.qmd | Revisión manual + Quarto render |
| Evaluación | 4 archivos con ponderación 40/40/20 | Grep en el proyecto |
| URL | `portswigger.net` correcto | `grep -r portsweigger` devuelve vacío |
| Render | `quarto render` sin errores | Ejecutar en terminal |
| Bibliografía | U3-U8 tienen sección `## Bibliografía` | `grep -L "Bibliografía"` devuelve vacío |

## Migration / Rollout

No hay migración de datos. Estrategia de rollout:

1. **Fase P0** — Fixes críticos primero (evalución, URL, links). Verificar con `grep` y render.
2. **Fase Contenido** — Unidades U1-U8 una a la vez. Cada unidad es independiente; un error en U3 no bloquea U4.
3. **Fase Labs** — Después de que su unidad correspondiente esté completa.
4. **Fase Quizzes** — Pueden ir en paralelo con labs.
5. **Fase Presentaciones** — Al final, cuando el contenido esté estable.

En cualquier punto se puede hacer `quarto render` para verificar el estado actual del libro.

## Open Questions

- [ ] ¿Las presentaciones se renderizan en el mismo `quarto render` del libro o por separado? (El `_quarto.yml` actual tiene `post-render: quarto render presentaciones` — verificar que funciona para los nuevos archivos)
- [ ] ¿Las subcarpetas `contenido/unidad{1-8}/` son para assets específicos de cada unidad o para sub-capítulos? (Actualmente vacías — asumo assets; confirmar antes de poblar)
- [ ] ¿El lab de U8 es el Proyecto Final evaluable o es un lab adicional? (La propuesta dice que U8 tiene "Proyecto Final" — definir si lab-unidad8 = proyecto final o son separados)
