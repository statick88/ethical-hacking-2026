# Design: Propuesta Modernización Ethical Hacking 2026

## Technical Approach

El documento de propuesta se desarrolla como informe técnico en formato HTML, convertido a PDF mediante WeasyPrint.

## Architecture Decisions

### Decision: Formato del Documento

**Choice**: HTML + WeasyPrint para PDF
**Rationale**:
- Control total sobre estilos (negritas, cursivas, tablas)
- Generación de PDF profesional
- Mantenimiento sencillo

### Decision: Estilos de Texto

**Choice**: CSS con estándares HTML
**Implementation**:
- Negritas: `<strong>` o `<b>`
- Cursivas: `<em>` o `<i>`
- Subrayado: `<u>` con color
- Hipervínculos: `<a>` con color y underline

### Decision: Tablas

**Choice**: Encabezados con fondo, filas sin fondo
**Implementation**:
```css
th { background: #003366; color: white; }
td { border-bottom: 1px solid #ddd; }
```

## File Structure

```
/Users/statick/apps/Ethical_Hacking/
├── informe_final.html
├── informe_modernizacion_ethical_hacking_2026.pdf
├── abacom-logo.png
└── openspec/
    └── changes/
        └── informe-modernizacion-ethical-hacking/
            ├── proposal.md
            ├── specs/
            │   └── informe/
            │       └── spec.md
            └── design.md
```

## Document Structure

1. **Resumen Ejecutivo**: 8 módulos, 150 horas, 8 pilares
2. **Introducción y Contexto**: Fundamentación, objetivos
3. **Análisis del Temario Actual**: Estructura existente, limitaciones
4. **Diagnóstico**: Métricas críticas, nuevas amenazas
5. **Propuesta de Modernización**: 8 módulos con detalle
6. **Habilidades Clave**: IA Agéntica, Evasión, IaC, Zero Trust
7. **Metodología de Evaluación**: Labs 45%, Proyectos 30%, CTF 15%, Teoría 10%
8. **Certificaciones Alineadas**: OSCP+, CEH v13, eJPTv2, PNPT, CRTP
9. **Infraestructura**: Docker, Kali Linux, Laboratorios
10. **Bibliografía**: IEEE format con URLs verificadas
11. **Anexo**: Herramientas del Laboratorio

## Content Details

### Módulos (150 horas)

| Módulo | Tema | Horas |
|--------|------|-------|
| 1 | Fundamentos y Reconocimiento Agéntico | 15 |
| 2 | Vulnerabilidades en IA y Modelos de Lenguaje | 20 |
| 3 | Explotación Web y APIs 2026 | 20 |
| 4 | Hacking de Identidad y AD Moderno | 20 |
| 5 | Pentesting Autónomo y Red Teaming Agéntico | 20 |
| 6 | Evasión de Defensas | 20 |
| 7 | Ciberseguridad Industrial | 20 |
| 8 | Post-Explotación, Reporte y Ética | 15 |

### Herramientas Incluidas

- **Docker & Docker Compose**: Contenedores
- **Kali Linux**: Distribución de seguridad
- **OpenClaw**: Hardening de sistemas industriales
- **Pentagi**: Pentesting automatizado
- **PLCSploit, s7scan**: Seguridad industrial

### Plataformas CTF Gratuitas

- TryHackMe (Plan Free)
- Hack The Box Academy
- OverTheWire

## Testing Strategy

| Layer | What to Test | Approach |
|-------|-------------|----------|
| Content | 8 módulos = 150 horas | Verificar suma |
| Links | URLs en bibliografía | curl -I verification |
| Spelling | Errores ortográficos | Revisión manual |
| Styles | Tablas, negritas, cursivas | Verificar HTML |
