# Presentaciones por Unidad — Specification

## Purpose

Especificaciones para las 8 presentaciones RevealJS del curso usando el tema Metropolis. Actualmente solo existe `presentaciones/unidad0_intro.qmd` (intro del curso). Esta spec define qué DEBE contener cada presentación de unidad.

---

## Requirements

### Requirement: Una Presentación por Unidad

El curso DEBE tener exactamente 8 presentaciones de contenido, una por unidad, más la intro existente.

#### Scenario: Existencia de archivos de presentación

- GIVEN El directorio `presentaciones/`
- WHEN Se lista su contenido
- THEN DEBE existir `presentaciones/unidad1.qmd` hasta `presentaciones/unidad8.qmd`
- AND DEBE existir `presentaciones/unidad0_intro.qmd` (ya existe, no modificar)
- AND DEBE existir `presentaciones/index.qmd` con links funcionales a todos los archivos

---

### Requirement: Frontmatter Estándar Metropolis

Cada presentación DEBE usar el tema Metropolis con la configuración estándar del proyecto.

#### Scenario: Frontmatter correcto

- GIVEN El frontmatter YAML de cualquier presentación `unidadN.qmd`
- WHEN Se verifica la configuración
- THEN DEBE incluir exactamente:
  ```yaml
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
  ```
- AND El `title` DEBE coincidir con el título del archivo `contenido/unidadN.qmd` correspondiente

---

### Requirement: Estructura Estándar de Presentación

Cada presentación DEBE seguir una estructura pedagógica coherente.

#### Scenario: Secciones obligatorias presentes

- GIVEN Una presentación `presentaciones/unidadN.qmd`
- WHEN Se verifica su estructura de slides
- THEN DEBE contener las siguientes secciones separadas por `---`:
  1. **Agenda** — índice visual de la unidad (bullets con los temas)
  2. **Objetivos** — 3-5 objetivos de aprendizaje (mismos que en contenido)
  3. **{Subtema 1}** — al menos 2 slides por subtema del contenido
  4. **{Subtema 2}** — al menos 2 slides
  5. **{Subtema N}** — al menos 2 slides
  6. **Demo / Lab Preview** — slide con el escenario del lab de la unidad
  7. **Recursos** — links a bibliografía y recursos adicionales
  8. **Q&A** — slide final

#### Scenario: Cantidad mínima de slides

- GIVEN Una presentación completa de unidad
- WHEN Se cuentan los separadores `---`
- THEN DEBE haber mínimo 15 slides
- AND DEBE haber máximo 30 slides (no sobrecargar la sesión)

---

### Requirement: Slides con Contenido Visual

Las slides DEBEN favorecer contenido visual sobre texto denso.

#### Scenario: Regla de contenido por slide

- GIVEN Cualquier slide de contenido (no portada, no agenda)
- WHEN Se verifica su contenido
- THEN DEBE tener máximo 5 bullets por slide
- AND Cada bullet DEBE ser máximo 1 línea (no párrafos)
- AND DEBE usar código en bloque (```bash o ```python) cuando muestre comandos

#### Scenario: Slides de comandos formateados

- GIVEN Un slide que muestra un comando o payload
- WHEN Se verifica el formato
- THEN DEBE usar bloque de código con syntax highlighting
- AND NO DEBE poner comandos como texto plano en bullets

---

### Requirement: Coherencia con el Contenido

Las presentaciones DEBEN ser la versión visual del contenido de cada unidad — mismos temas, misma terminología, mismos ejemplos clave.

#### Scenario: Alineación con contenido/unidadN.qmd

- GIVEN La presentación `presentaciones/unidadN.qmd` y el contenido `contenido/unidadN.qmd`
- WHEN Se comparan los subtemas cubiertos
- THEN DEBEN coincidir los mismos subtemas `###` del contenido
- AND Los objetivos DEBEN ser los mismos en ambos archivos
- AND El lab referenciado en la presentación DEBE ser el mismo que en `labs/lab-unidadN.md`

---

### Requirement: Index de Presentaciones Actualizado

El archivo `presentaciones/index.qmd` DEBE listar todas las presentaciones con links funcionales.

#### Scenario: Index completo y funcional

- GIVEN `presentaciones/index.qmd`
- WHEN Se verifica su contenido
- THEN DEBE listar de `unidad0_intro.qmd` a `unidad8.qmd` (9 entradas total)
- AND Cada link DEBE ser un archivo `.qmd` existente en `presentaciones/`
- AND Los títulos DEBEN coincidir con el frontmatter `title` de cada archivo
