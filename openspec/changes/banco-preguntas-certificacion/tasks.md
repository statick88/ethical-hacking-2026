# Tasks: Banco de Estudio: Certificación Ethical Hacking 2026

**Summary**: 4 total tasks, 8 points, 3 phases

## Phase 1: Estructura y Archivos ⚡1

- [ ] **1.1** Crear el archivo `contenido/banco-preguntas.qmd` con el encabezado YAML inicial. ⚡1
  - Blocks: [2.1]
  - Tests: Verificar existencia del archivo.

**Phase Total**: 1 point | Dependencies: Linear (1.1)

## Phase 2: Implementación de Contenido ⚡4

- [ ] **2.1** Insertar las 100 preguntas organizadas por dominios, asegurando el formato de casillas Markdown (`- [ ]` / `- [X]`). ⚡4
  - Depends on: 1.1
  - Blocks: [3.1]
  - Tests: Revisión visual del formato y conteo de preguntas.

**Phase Total**: 4 points | Dependencies: Content entry (2.1)

## Phase 3: Integración y Verificación ⚡3

- [ ] **3.1** Modificar `_quarto.yml` para añadir la nueva sección "Certificación" y el capítulo `contenido/banco-preguntas.qmd`. ⚡1
  - Depends on: 2.1
  - Blocks: [3.2]

- [ ] **3.2** Verificar el renderizado de Quarto y la integridad de la navegación en la barra lateral. ⚡2
  - Depends on: 3.1
  - Tests: `quarto preview` o revisión de sintaxis.

**Phase Total**: 3 points | Dependencies: Integration chain (3.1 → 3.2)

## Critical Path
1.1 [1pt] → 2.1 [4pt] → 3.1 [1pt] → 3.2 [2pt]
Sequential time: ~40-60 min
