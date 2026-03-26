# Evaluación: Banco de Preguntas de Certificación

## Purpose

Este dominio define los requisitos para el material de evaluación sumativa y de repaso para la Certificación Ethical Hacking 2026. A diferencia de los quizzes por unidad, este banco es integral y cubre todos los dominios del curso.

## Related Prior Specs

- `openspec/specs/quizzes/spec.md`: Define el formato de quizzes por unidad (10 preguntas + 2 escenarios). Se tomará como referencia para la consistencia del formato de preguntas de opción múltiple.

## Requirements

### Requirement: Banco de 100 Preguntas Integral

El sistema DEBE incluir un documento con exactamente 100 preguntas de opción múltiple que cubran los 8 dominios del curso.

#### Scenario: Cobertura total de dominios

- GIVEN El archivo `contenido/banco-preguntas.qmd`
- WHEN Se analiza el contenido por dominios
- THEN DEBEN estar presentes preguntas de: Reconocimiento, Seguridad en IA, Active Directory, C2/Persistencia, Vulnerabilidades Web, Redes/OT, Metodología/Ética y Miscelánea.

#### Scenario: Formato de preguntas con respuesta marcada

- GIVEN Una pregunta en el banco de preguntas
- WHEN Se verifica su formato Markdown
- THEN DEBE tener 4 opciones (casillas `[ ]`)
- AND EXACTAMENTE una opción DEBE estar marcada con una `X` (`[X]`) como respuesta correcta.

### Requirement: Integración en Navegación de Quarto

El banco de preguntas DEBE ser accesible desde la barra lateral del libro en una sección destacada.

#### Scenario: Nueva Parte en el Sidebar

- GIVEN El archivo `_quarto.yml`
- WHEN Se añade la parte "Certificación"
- THEN El archivo `contenido/banco-preguntas.qmd` DEBE estar listado como capítulo de esa parte.
- AND La sección DEBE aparecer después de "Laboratorios".

### Requirement: Formato de Exportación Compatible

El documento DEBE ser procesable por Quarto para generar salidas coherentes en HTML y PDF.

#### Scenario: Renderizado PDF exitoso

- GIVEN El archivo `.qmd` con metadatos de Quarto
- WHEN Se ejecuta el comando de renderizado a PDF
- THEN El documento DEBE incluir Tabla de Contenidos y numeración de secciones.
- AND El subtítulo "Preparación para el Examen Final (100 Preguntas)" DEBE ser visible en la portada.

## Success Criteria

- [ ] 100 preguntas con respuestas marcadas.
- [ ] Organización por Dominios coherente.
- [ ] Inclusión en `_quarto.yml`.
- [ ] Sin errores de sintaxis Markdown o Quarto.
