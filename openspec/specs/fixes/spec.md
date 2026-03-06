# Fixes Críticos — Specification

## Purpose

Especificaciones para los bugs P0 que afectan la coherencia del curso antes de cualquier publicación. Estos fixes son bloqueantes — deben resolverse antes de desarrollar contenido nuevo.

---

## Requirements

### Requirement: Evaluación Unificada

El curso DEBE tener una única fuente de verdad para la ponderación de evaluación. Actualmente existen 4 versiones distintas en 4 archivos distintos, lo cual es una contradicción directa hacia los estudiantes.

La ponderación DEBE ser:
- Laboratorios: **40%**
- Proyecto Final / Reporte: **40%**
- Examen Teórico: **20%**

Todos los archivos que mencionan evaluación DEBEN reflejar exactamente esta ponderación.

#### Scenario: Verificación de coherencia de evaluación

- GIVEN El curso Ethical Hacking 2026 con 4 archivos que mencionan evaluación
- WHEN Se busca la ponderación en `contenido/unidad8.qmd`, `quizzes/guia.md`, `presentaciones/unidad0_intro.qmd` y `openspec/changes/informe-modernizacion-ethical-hacking/design.md`
- THEN Todos los archivos DEBEN mostrar: Laboratorios 40%, Proyecto/Reporte 40%, Examen 20%
- AND No DEBE existir ninguna otra ponderación en ningún archivo del proyecto

#### Scenario: Fuente de verdad principal

- GIVEN La sección `## Evaluación` en `contenido/unidad8.qmd`
- WHEN Un estudiante consulta cómo se califica el curso
- THEN DEBE ver exactamente: "40% Laboratorio, 40% Reporte, 20% Examen teórico"

---

### Requirement: URL PortSwigger Correcta

El proyecto DEBE referenciar PortSwigger Web Security Academy con la URL correcta. La URL actual `portsweigger.com` es incorrecta y no resuelve al sitio real.

#### Scenario: URL corregida en infraestructura

- GIVEN El archivo `labs/infraestructura.md` línea 29
- WHEN Se verifica la URL de PortSwigger Web Security Academy
- THEN DEBE ser `portswigger.net` (no `portsweigger.com`)
- AND La URL DEBE ser accesible (HTTP 200)

#### Scenario: Sin typos en otras referencias

- GIVEN Todos los archivos del proyecto
- WHEN Se busca cualquier referencia a PortSwigger
- THEN Todas DEBEN usar `portswigger.net`
- AND Ninguna DEBE contener la variante mal escrita `portsweigger`

---

### Requirement: Links de Presentaciones Funcionales

El índice de presentaciones DEBE referenciar únicamente archivos que existen. Los links rotos confunden al estudiante y rompen la navegación del libro Quarto.

#### Scenario: Index sin links rotos al momento del fix

- GIVEN El archivo `presentaciones/index.qmd`
- WHEN Se verifica cada link en el índice
- THEN Cada link DEBE apuntar a un archivo `.qmd` que exista en el sistema de archivos
- AND NO DEBE haber referencias a `unidad1.qmd` ... `unidad8.qmd` hasta que esos archivos existan

#### Scenario: Index actualizado conforme se crean presentaciones

- GIVEN Una nueva presentación creada en `presentaciones/unidadN.qmd`
- WHEN Se agrega al índice `presentaciones/index.qmd`
- THEN El link DEBE ser válido e incluir el nombre de la unidad
- AND El número de orden DEBE ser secuencial (1 al 8)

---

### Requirement: Bibliografía en Todas las Unidades

Todas las unidades U1-U8 DEBEN tener sección `## Bibliografía` con al menos 2 referencias en formato IEEE con URLs verificadas.

Las unidades U1 y U2 ya cumplen. Las unidades U3-U8 DEBEN agregarse.

#### Scenario: Unidad sin bibliografía (estado a corregir)

- GIVEN `contenido/unidad3.qmd` hasta `contenido/unidad8.qmd`
- WHEN Se verifica la sección de bibliografía
- THEN Cada archivo DEBE contener `## Bibliografía` con mínimo 2 referencias
- AND Las URLs DEBEN responder HTTP 200

#### Scenario: Formato IEEE respetado

- GIVEN Una referencia bibliográfica en cualquier unidad
- WHEN Se verifica el formato
- THEN DEBE seguir el patrón: `[N] Apellido, Inicial. "Título." *Fuente*, año. [Online]. URL`
- O DEBE ser un link con texto descriptivo del recurso oficial
