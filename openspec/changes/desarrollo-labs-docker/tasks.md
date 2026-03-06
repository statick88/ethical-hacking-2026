# Tasks: Desarrollo de Laboratorios Docker

## Overview

Tareas para implementar los laboratorios dockerizados del curso de Ethical Hacking 2026.

## Task Breakdown

### Phase 1: Estructura Base

| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T1 | Crear directorio `docker-labs/` y subcarpetas por lab | Diego | P0 | ✅ Done |
| T2 | Crear archivo config.yaml para el change SDD | Diego | P0 | ✅ Done |
| T3 | Crear proposal.md | Diego | P0 | ✅ Done |
| T4 | Crear design.md | Diego | P0 | ✅ Done |
| T5 | Crear spec.md | Diego | P0 | ✅ Done |

### Phase 2: Laboratorios Dockerizados

#### Lab 1 — Reconnaissance and Enumeration
| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T1.1 | Crear docker-compose.yml para Lab 1 | Diego | P0 | ⏳ In Progress |
| T1.2 | Crear README.md detallado para Lab 1 | Diego | P0 | ⏳ In Progress |
| T1.3 | Probar Lab 1 en Windows/macOS/Linux | Diego | P1 | ❌ To Do |

#### Lab 3 — Web Security (OWASP WebGoat)
| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T3.1 | Crear docker-compose.yml para Lab 3 | Diego | P0 | ⏳ In Progress |
| T3.2 | Crear README.md detallado para Lab 3 | Diego | P0 | ⏳ In Progress |
| T3.3 | Probar Lab 3 en Windows/macOS/Linux | Diego | P1 | ❌ To Do |

#### Lab 4 — Active Directory (BloodHound)
| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T4.1 | Crear docker-compose.yml para Lab 4 | Diego | P0 | ⏳ In Progress |
| T4.2 | Crear README.md detallado para Lab 4 | Diego | P0 | ⏳ In Progress |
| T4.3 | Probar Lab 4 en Windows/macOS/Linux | Diego | P1 | ❌ To Do |

#### Lab 5 — Automated Pentesting
| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T5.1 | Crear docker-compose.yml para Lab 5 | Diego | P0 | ⏳ In Progress |
| T5.2 | Crear README.md detallado para Lab 5 | Diego | P0 | ⏳ In Progress |
| T5.3 | Probar Lab 5 en Windows/macOS/Linux | Diego | P1 | ❌ To Do |

#### Lab 6 — Undetectable Payloads
| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T6.1 | Crear docker-compose.yml para Lab 6 | Diego | P0 | ⏳ In Progress |
| T6.2 | Crear README.md detallado para Lab 6 | Diego | P0 | ⏳ In Progress |
| T6.3 | Probar Lab 6 en Windows/macOS/Linux | Diego | P1 | ❌ To Do |

#### Lab 7 — OT Security (OpenPLC)
| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T7.1 | Crear docker-compose.yml para Lab 7 | Diego | P0 | ⏳ In Progress |
| T7.2 | Crear README.md detallado para Lab 7 | Diego | P0 | ⏳ In Progress |
| T7.3 | Probar Lab 7 en Windows/macOS/Linux | Diego | P1 | ❌ To Do |

#### Lab 8 — Final Project
| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T8.1 | Crear docker-compose.yml para Lab 8 | Diego | P0 | ⏳ In Progress |
| T8.2 | Crear README.md detallado para Lab 8 | Diego | P0 | ⏳ In Progress |
| T8.3 | Probar Lab 8 en Windows/macOS/Linux | Diego | P1 | ❌ To Do |

### Phase 3: Validación y Optimización

| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T9 | Probar todos los labs en Windows 10/11 | Diego | P1 | ❌ To Do |
| T10 | Probar todos los labs en macOS M1/M2 | Diego | P1 | ❌ To Do |
| T11 | Probar todos los labs en Ubuntu 22.04 | Diego | P1 | ❌ To Do |
| T12 | Optimizar imágenes Docker para reducir tamaño | Diego | P2 | ❌ To Do |
| T13 | Limitar recursos de contenedores | Diego | P2 | ❌ To Do |

### Phase 4: Documentación Final

| Task | Description | Owner | Priority | Status |
|------|-------------|-------|----------|--------|
| T14 | Revisar y actualizar todos los README.md | Diego | P1 | ❌ To Do |
| T15 | Crear instructions.md general | Diego | P1 | ❌ To Do |
| T16 | Validar links en documentación | Diego | P2 | ❌ To Do |
| T17 | Añadir screenshots a README.md | Diego | P2 | ❌ To Do |

## Dependencies

- T1 ← T1.1, T3.1, T4.1, T5.1, T6.1, T7.1, T8.1
- T2 ← T3, T4, T5
- T3 ← T4, T5
- T4 ← T5
- T1.1 ← T1.2
- T3.1 ← T3.2
- T4.1 ← T4.2
- T5.1 ← T5.2
- T6.1 ← T6.2
- T7.1 ← T7.2
- T8.1 ← T8.2

## Timeline

| Phase | Duration |
|-------|----------|
| Phase 1 | 1 día |
| Phase 2 | 7 días |
| Phase 3 | 3 días |
| Phase 4 | 2 días |
| **Total** | **13 días** |
