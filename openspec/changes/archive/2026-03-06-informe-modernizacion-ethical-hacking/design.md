# Design: Propuesta Modernización Ethical Hacking 2026

## Technical Approach

El informe de modernización curricular se genera como documento HTML profesional (`informe_final.html`), diseñado con una estructura jerárquica clara que integra 8 módulos de 150 horas, herramientas, laboratorios, certificaciones y referencias bibliográficas. El documento se estructura en secciones semánticas HTML5 con CSS profesional, permitiendo conversión a PDF mediante WeasyPrint para distribución.

**Flujo técnico:**
```
specs/ (requirements) → design.md (architecture) → templates/ → informe_final.html → PDF generation
```

## Architecture Decisions

### Decision 1: Formato HTML + CSS + WeasyPrint

**Choice**: Desarrollar como HTML5 con CSS embebido para permitir conversión PDF limpian
**Alternatives considered**: 
- LaTeX: Complejo, curva de aprendizaje
- Markdown + Pandoc: Limitación de control visual
- PDF directo: Difícil mantenimiento y actualizaciones

**Rationale**: 
- Control total de estilos, layouts y espacios
- Reutilizable (HTML nativo + navegadores)
- WeasyPrint proporciona PDF profesional sin dependencias externas
- Mantenimiento sencillo: cambios en CSS o HTML sin regenerar estructura

### Decision 2: Estructura Semántica HTML5 con Secciones Anidadas

**Choice**: Usar `<section>`, `<article>`, `<header>`, `<footer>` con jerarquía clara
**Rationale**:
- Mejora accesibilidad y SEO si se publica web
- Facilita generación de tabla de contenidos automática
- Permite estilos diferenciados por nivel jerárquico
- Estructura lógica para navegación PDF

### Decision 3: Paleta de Colores Profesional

**Choice**: 
- Primario: `#003366` (azul corporativo)
- Secundario: `#0066CC` (azul claro)
- Acentos: `#FF6600` (naranja para módulos)
- Texto: `#333333` (gris oscuro)

**Rationale**:
- Distingue claramente secciones principales
- Módulos identificables visualmente
- Coherente con marca ABACOM

### Decision 4: Integración de Módulos en Tabla Interactiva

**Choice**: Tabla expandible con información de cada módulo (horas, objetivos, herramientas)
**Implementation**:
- Cada módulo como fila con detalles desplegables
- Columnas: Módulo | Tema | Horas | Objetivos Clave | Herramientas | Certificaciones Alineadas

**Rationale**:
- Comparación rápida de módulos
- Facilita búsqueda de información específica
- Estructura ordenada y profesional

### Decision 5: Secciones de Herramientas y Labs Integradas

**Choice**: Bloques de referencia cruzada entre módulos → herramientas → plataformas CTF
**Implementation**:
```
Módulo N
  ├─ Contenido y objetivos
  ├─ Herramientas: [links a sección de herramientas]
  ├─ Labs disponibles: [links a TryHackMe/HTB]
  └─ Certificaciones alineadas: [OSCP+, CEH]
```

**Rationale**:
- Usuario navega de módulo → herramienta → lab en flujo natural
- Evita duplicación de contenido
- Mantiene documento modular y fácil de actualizar

### Decision 6: Certificaciones como Matriz de Mapeo

**Choice**: Tabla de módulos × certificaciones mostrando cobertura
**Implementation**:
```
                OSCP+  CEH v13  eJPT  PNPT  CRTP
Módulo 1          ✓      ✓       ✓
Módulo 2          ✓      ✓       ✓      ✓
...
```

**Rationale**:
- Visualización clara de alineamiento
- Facilita decisión de estudiantes
- Demuestra relevancia del programa

---

## Information Hierarchy & Document Structure

### Visual Hierarchy

```
NIVEL 1: Portada + Metadata
  └─ Logo ABACOM, Título, Fecha, Autor

NIVEL 2: Tabla de Contenidos (autogenerada de <h1>, <h2>)

NIVEL 3: Resumen Ejecutivo (1 página)
  ├─ Problema: Amenazas 2026
  ├─ Solución: 8 módulos, 150h, IA agéntica
  └─ Valor: Estudiantes → "Estrategas de IA"

NIVEL 4: Secciones Principales (con <section class="main-section">)
  ├─ 1. Introducción y Contexto
  ├─ 2. Análisis del Temario Actual
  ├─ 3. Diagnóstico: Brechas y Amenazas
  ├─ 4. Propuesta de Modernización
  ├─ 5. Habilidades Clave
  ├─ 6. Metodología de Evaluación
  ├─ 7. Certificaciones Alineadas
  ├─ 8. Infraestructura y Laboratorios
  ├─ 9. Bibliografía
  └─ Anexo: Herramientas

NIVEL 5: Subsecciones de Módulos (con <article class="module">)
  └─ Cada módulo N (1-8):
       ├─ Descripción general
       ├─ Objetivos de aprendizaje (bullets)
       ├─ Contenido temático
       ├─ Herramientas específicas
       ├─ Labs recomendados
       ├─ Certificaciones alineadas
       └─ Horas estimadas
```

---

## Detailed File Structure

```
/Users/statick/apps/Ethical_Hacking/
├── informe_final.html                      [CREAR] Documento final
├── informe_modernizacion_ethical_hacking_2026.pdf  [GENERAR via WeasyPrint]
├── abacom-logo.png                        [EXISTS] Logo corporativo
│
└── openspec/
    └── changes/
        └── informe-modernizacion-ethical-hacking/
            ├── proposal.md                [EXISTS] Intención general
            ├── design.md                  [THIS FILE] Arquitectura técnica
            ├── tasks.md                   [EXISTS] Checklist de implementación
            │
            ├── specs/                     [EXISTS] Requisitos detallados
            │   ├── informe/
            │   │   └── spec.md
            │   ├── contenido/
            │   │   └── spec.md
            │   ├── herramientas/
            │   │   └── spec.md
            │   ├── certificaciones/
            │   │   └── spec.md
            │   └── laboratorios/
            │       └── spec.md
            │
            └── design/
                ├── html-sections.md       [CREAR] Estructura HTML detallada
                ├── css-styles.md          [CREAR] Definiciones CSS
                ├── data-modules.json      [CREAR] Datos de módulos (JSON)
                ├── data-tools.json        [CREAR] Datos de herramientas
                └── data-certifications.json [CREAR] Mapeo certificaciones
```

---

## Content Organization for 8 Modules

### Module Card Template

Cada módulo sigue esta estructura semántica:

```html
<article class="module" id="modulo-N" data-hours="15">
  <header class="module-header" style="background: #FF6600;">
    <h2 class="module-title">Módulo N: Título Descriptivo</h2>
    <p class="module-hours">15 horas</p>
  </header>
  
  <section class="module-overview">
    <h3>Descripción General</h3>
    <p>Párrafo introductorio...</p>
  </section>
  
  <section class="module-objectives">
    <h3>Objetivos de Aprendizaje</h3>
    <ul>
      <li>Objetivo 1</li>
      <li>Objetivo 2</li>
      ...
    </ul>
  </section>
  
  <section class="module-content">
    <h3>Contenido Temático</h3>
    <p>Detalles de temas, subtemas...</p>
    <table class="topics-table">
      <tr>
        <th>Tema</th>
        <th>Subtema</th>
        <th>Horas</th>
      </tr>
      ...
    </table>
  </section>
  
  <section class="module-tools">
    <h3>Herramientas Principales</h3>
    <ul>
      <li><a href="#tool-{id}">Herramienta 1</a></li>
      ...
    </ul>
  </section>
  
  <section class="module-labs">
    <h3>Laboratorios Recomendados</h3>
    <p><strong>TryHackMe:</strong> [Rooms]</p>
    <p><strong>Hack The Box:</strong> [Machines]</p>
    <p><strong>OverTheWire:</strong> [Games]</p>
  </section>
  
  <section class="module-certifications">
    <h3>Certificaciones Alineadas</h3>
    <p>OSCP+, CEH v13, ...</p>
  </section>
</article>
```

### Module Distribution (150 hours)

| Módulo | Tema | Horas | Pilares Cubiertos |
|--------|------|-------|-------------------|
| 1 | Fundamentos y Reconocimiento Agéntico | 15 | Fundamentals, AI Orchestration |
| 2 | Vulnerabilidades en IA y Modelos de Lenguaje | 20 | AI Security, Prompt Injection |
| 3 | Explotación Web y APIs 2026 | 20 | Web/API, Modern Techniques |
| 4 | Hacking de Identidad y AD Moderno | 20 | Identity, Modern Infrastructure |
| 5 | Pentesting Autónomo y Red Teaming Agéntico | 20 | Autonomous Pentesting, AI Agents |
| 6 | Evasión de Defensas | 20 | Evasion, Defense Bypassing |
| 7 | Ciberseguridad Industrial | 20 | ICS/OT, Industrial Security |
| 8 | Post-Explotación, Reporte y Ética | 15 | Post-Exploitation, Ethics, Reporting |
| **TOTAL** | | **150** | |

---

## Tools Integration Map

### Section: Infraestructura y Herramientas

Estructura jerárquica:

```
8. Infraestructura y Herramientas
  ├─ 8.1 Plataformas de Laboratorio
  │   ├─ Docker & Docker Compose
  │   ├─ Kali Linux (distribución oficial)
  │   ├─ VirtualBox (hipervisor gratuito)
  │   └─ VMware Fusion (para macOS)
  │
  ├─ 8.2 Herramientas de Pentesting
  │   ├─ Reconocimiento
  │   │   ├─ Nmap, Shodan, TheHarvester
  │   │   └─ [Mapeo: Módulo 1]
  │   │
  │   ├─ Explotación
  │   │   ├─ Metasploit, Burp Suite
  │   │   └─ [Mapeo: Módulos 3-5]
  │   │
  │   ├─ IA y Agentes
  │   │   ├─ Agents (OpenAI API, Claude)
  │   │   ├─ LangChain, Semantic Kernel
  │   │   └─ [Mapeo: Módulos 1-2, 5]
  │   │
  │   └─ Industrial
  │       ├─ OpenClaw, Pentagi
  │       ├─ PLCSploit, s7scan
  │       └─ [Mapeo: Módulo 7]
  │
  ├─ 8.3 Plataformas CTF
  │   ├─ TryHackMe (Plan Free)
  │   ├─ Hack The Box Academy (Tier 0)
  │   └─ OverTheWire (Wargames)
  │
  └─ 8.4 Laboratorios del Curso
      └─ [Referencia cruzada a cada módulo]
```

### Tool-to-Module Cross-Reference Table

```html
<table class="tool-reference-table">
  <thead>
    <tr>
      <th>Herramienta</th>
      <th>Tipo</th>
      <th>Módulos que usan</th>
      <th>Plataforma</th>
      <th>Licencia</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Nmap</strong></td>
      <td>Reconocimiento</td>
      <td>1, 3, 4, 5</td>
      <td>Linux/macOS/Windows</td>
      <td>Open Source</td>
    </tr>
    <tr>
      <td><strong>Metasploit</strong></td>
      <td>Explotación</td>
      <td>3, 5, 6, 7</td>
      <td>Kali Linux</td>
      <td>Open Source</td>
    </tr>
    ...
  </tbody>
</table>
```

---

## Labs & Certifications Integration

### Labs Mapping by Module

```
Módulo 1 (Fundamentos)
  └─ TryHackMe:
       - Pre Security path
       - Linux Fundamentals
       - Network Fundamentals
     
Módulo 2 (IA & LLM)
  └─ HackTheBox:
       - Prompt Injection labs (Tier 0)
       - API vulnerabilities
     
Módulo 3 (Web/APIs)
  └─ TryHackMe:
       - OWASP Top 10
       - Web Security Academy
     
Módulo 4 (Identity/AD)
  └─ HackTheBox:
       - Active Directory labs
       - Kerberos exploitation
     
Módulo 5 (Autonomous PT)
  └─ TryHackMe:
       - Red Team Core path
       - Pentesting path
     
Módulo 6 (Evasion)
  └─ HackTheBox:
       - AV/EDR bypass techniques
     
Módulo 7 (Industrial)
  └─ OverTheWire:
       - Custom ICS scenarios
     
Módulo 8 (Post-Exploitation)
  └─ Multi-platform:
       - Reporting labs
       - Case studies
```

### Certification Alignment Matrix

```html
<table class="certification-matrix">
  <thead>
    <tr>
      <th>Módulo</th>
      <th>OSCP+</th>
      <th>CEH v13</th>
      <th>eJPTv2</th>
      <th>PNPT</th>
      <th>CRTP</th>
      <th>Coverage %</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>1. Fundamentos Agénticos</td>
      <td>✓</td>
      <td>✓</td>
      <td>✓</td>
      <td>✓</td>
      <td>✓</td>
      <td>100%</td>
    </tr>
    <tr>
      <td>2. IA & LLM</td>
      <td>●</td>
      <td>✓</td>
      <td>●</td>
      <td>●</td>
      <td>●</td>
      <td>20%</td>
    </tr>
    ...
  </tbody>
</table>
```

Legend:
- `✓` = Core topic
- `●` = Related/Advanced topic
- Empty = Not covered

---

## Interactive Elements

### 1. Expandable Module Cards (CSS + HTML)

```html
<details class="module-details">
  <summary class="module-summary">
    <span class="module-number">Módulo 3</span>
    <span class="module-title">Explotación Web y APIs 2026</span>
    <span class="module-hours">20h</span>
  </summary>
  
  <div class="module-content">
    <!-- Full module details here -->
  </div>
</details>
```

**CSS for styling:**
```css
details > summary {
  cursor: pointer;
  background: #0066CC;
  color: white;
  padding: 12px;
  font-weight: bold;
  border-left: 4px solid #FF6600;
}

details[open] > summary {
  background: #003366;
  border-left: 4px solid #FF0000;
}

details > div {
  padding: 20px;
  background: #f9f9f9;
  border: 1px solid #ddd;
}
```

### 2. Tooltip Definitions

For technical terms (Prompt Injection, Zero Trust, etc.):

```html
<span class="tooltip" title="Técnica donde se inyecta instrucciones maliciosas en prompts para manipular salidas de modelos LLM">
  Prompt Injection
  <span class="tooltip-icon">?</span>
</span>
```

### 3. Table of Contents (Auto-generated from headings)

```html
<nav class="toc">
  <h2>Tabla de Contenidos</h2>
  <!-- Generated from h1, h2, h3 tags -->
  <ul id="toc-list"></ul>
</nav>

<script>
  // Simple TOC generator
  const headings = document.querySelectorAll('h1, h2, h3');
  const toc = document.getElementById('toc-list');
  
  headings.forEach(heading => {
    const li = document.createElement('li');
    const link = document.createElement('a');
    link.href = `#${heading.id || heading.textContent.replace(/\s+/g, '-')}`;
    link.textContent = heading.textContent;
    li.appendChild(link);
    toc.appendChild(li);
  });
</script>
```

### 4. Filtering/Search (Optional - for web version)

```html
<div class="search-bar">
  <input type="text" id="search-modules" placeholder="Buscar módulo..." />
  <button onclick="filterModules()">Buscar</button>
</div>

<script>
  function filterModules() {
    const query = document.getElementById('search-modules').value.toLowerCase();
    document.querySelectorAll('.module').forEach(module => {
      module.style.display = module.textContent.toLowerCase().includes(query) ? 'block' : 'none';
    });
  }
</script>
```

---

## Visual Layout (CSS Architecture)

### Color Scheme

```css
:root {
  --primary-blue: #003366;
  --secondary-blue: #0066CC;
  --accent-orange: #FF6600;
  --text-dark: #333333;
  --text-light: #666666;
  --bg-light: #f9f9f9;
  --bg-white: #ffffff;
  --border-gray: #dddddd;
  --success: #28a745;
  --warning: #ffc107;
  --error: #dc3545;
}
```

### Typography Hierarchy

```css
h1 { font-size: 2.5em; color: var(--primary-blue); margin: 0.5em 0; }
h2 { font-size: 2em; color: var(--secondary-blue); margin: 0.75em 0; }
h3 { font-size: 1.5em; color: var(--text-dark); margin: 1em 0; }

body { 
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  line-height: 1.6;
  color: var(--text-dark);
}

p { margin: 0.5em 0; }
```

### Box Model for Sections

```css
section {
  margin: 2em 0;
  padding: 1.5em;
  background: var(--bg-white);
  border-left: 4px solid var(--secondary-blue);
}

section.main-section {
  background: linear-gradient(to right, var(--bg-light), var(--bg-white));
  border-top: 3px solid var(--primary-blue);
  page-break-inside: avoid;  /* For PDF */
}

article.module {
  margin: 1em 0;
  padding: 1em;
  background: var(--bg-light);
  border-radius: 4px;
  border: 1px solid var(--border-gray);
}
```

### Table Styling

```css
table {
  width: 100%;
  border-collapse: collapse;
  margin: 1em 0;
}

table th {
  background: var(--primary-blue);
  color: white;
  padding: 12px;
  text-align: left;
  font-weight: bold;
  border: none;
}

table td {
  padding: 10px;
  border-bottom: 1px solid var(--border-gray);
}

table tbody tr:hover {
  background: var(--bg-light);
}

table tbody tr:nth-child(even) {
  background: var(--bg-white);
}
```

---

## File Changes & Data Structure

| File | Action | Description |
|------|--------|-------------|
| `informe_final.html` | **Create** | Documento HTML principal con estructura jerárquica |
| `openspec/design/html-sections.md` | **Create** | Detalle de cada sección HTML (semantic markup) |
| `openspec/design/css-styles.md` | **Create** | Definiciones CSS completas |
| `openspec/design/data-modules.json` | **Create** | Datos de 8 módulos (JSON structured) |
| `openspec/design/data-tools.json` | **Create** | Catálogo de herramientas con mapeo módulos |
| `openspec/design/data-certifications.json` | **Create** | Matriz de alineamiento certificaciones |
| `informe_modernizacion_ethical_hacking_2026.pdf` | **Generate** | Generado mediante WeasyPrint desde HTML |

### data-modules.json Structure

```json
{
  "modules": [
    {
      "id": "module-1",
      "number": 1,
      "title": "Fundamentos y Reconocimiento Agéntico",
      "hours": 15,
      "description": "...",
      "objectives": ["Obj1", "Obj2"],
      "tools": ["nmap", "shodan", "theharvester"],
      "labs": {
        "tryhackme": ["Pre Security", "Linux Fundamentals"],
        "hackthebox": ["Starting Point Tier 0"],
        "overthewire": []
      },
      "certifications": ["OSCP+", "CEH v13", "eJPTv2"]
    },
    ...
  ]
}
```

---

## Testing Strategy

| Layer | What to Test | Approach |
|-------|-------------|----------|
| **HTML Structure** | Semantic markup, headings hierarchy | Validar con W3C HTML Validator |
| **CSS Rendering** | Estilos, colores, layouts en navegadores | Probar en Chrome, Firefox, Safari |
| **PDF Generation** | Conversión WeasyPrint, paginación | Generar PDF y verificar visualmente |
| **Content Accuracy** | 150 horas totales, módulos completos | Sumar horas, verificar secciones |
| **Links & References** | URLs en bibliografía activas | `curl -I` o verificación manual |
| **Spelling & Grammar** | Errores ortográficos en español | Revisión manual + spell checker |
| **Cross-References** | Links internos (módulo→herramientas→labs) | Verificar todos los `href` internos |
| **Table Data** | Matrices de certificaciones, herramientas | Validar contra specs |

---

## Migration / Rollout

**No migration required.** Este es un nuevo documento que establece un baseline. Las actualizaciones futuras se harán por:
1. Editar `data-*.json` para cambios de contenido
2. Actualizar CSS en `openspec/design/css-styles.md`
3. Regenerar `informe_final.html`
4. Re-generar PDF

---

## Open Questions

- [ ] ¿Se incluye interactividad JavaScript en el PDF o solo en versión HTML?
- [ ] ¿Máximo de 1 página por módulo en PDF o se permite expansión?
- [ ] ¿Tabla de contenidos con números de página (requiere CSS de paginación específica)?
- [ ] ¿Incluir QR codes a labs o solo URLs?
- [ ] ¿Versión HTML se publica en web o solo se genera para PDF?

---

## Summary

**Design creates:**
1. Semantic HTML5 structure with clear visual hierarchy
2. Module cards with expandable details (8 modules, 150 hours)
3. Cross-reference system: Modules → Tools → Labs → Certifications
4. Professional CSS styling with ABACOM color palette
5. Data-driven approach (JSON files for easy updates)
6. PDF-ready layout with proper paging and styling
7. Optional interactive elements (expandable sections, TOC, tooltips)
