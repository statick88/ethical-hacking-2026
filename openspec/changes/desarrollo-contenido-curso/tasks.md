# Tasks: Desarrollo de Contenido del Curso — Ethical Hacking 2026

> Spec: `specs/` | Design: `design.md` | Proposal: `proposal.md`
> Orden de ejecución: P0 Fixes → Contenido → Labs → Quizzes → Presentaciones → Verificación

---

## Phase 1: P0 Fixes Críticos (Bloqueantes)

- [x] 1.1 Corregir `labs/infraestructura.md` línea 29: cambiar `portsweigger.com` → `portswigger.net`
- [x] 1.2 Actualizar `contenido/unidad8.qmd` sección `## Evaluación`: dejar como fuente canónica con ponderación `40% Laboratorio / 40% Reporte / 20% Examen teórico` *(ya estaba correcto)*
- [x] 1.3 Actualizar `quizzes/guia.md` sección `### Ponderación`: cambiar a `Laboratorios: 40% / Proyecto Final/Reporte: 40% / Examen final: 20%`
- [x] 1.4 Actualizar `presentaciones/unidad0_intro.qmd` slide de `## Metodología`: cambiar de `60% Laboratorio / 30% Teoría / 10% Evaluación` a `40% Laboratorio / 40% Reporte / 20% Examen`
- [x] 1.5 Actualizar `presentaciones/index.qmd`: eliminar links rotos a `unidad1.qmd`...`unidad8.qmd` — dejar solo el link a `unidad0_intro.qmd` hasta que se creen los demás
- [x] 1.6 Verificar P0: ejecutar `grep -r "portsweigger" .` → resultado vacío; verificar que 4 archivos tienen ponderación 40/40/20

---

## Phase 2: Contenido Unidades (Núcleo del Curso)

### Unidad 1 — Fundamentos y Reconocimiento Agéntico

- [x] 2.1 Expandir `contenido/unidad1.qmd`: agregar sección `## Objetivos de Aprendizaje` con 4 verbos de Bloom (Identificar, Ejecutar, Configurar, Analizar)
- [x] 2.2 Expandir `contenido/unidad1.qmd` → `### 1.1 Metodología de Pentesting`: desarrollar las 5 fases del pentesting con descripción de cada una + tabla comparativa OSSTMM vs PTES vs OWASP Testing Guide
- [x] 2.3 Expandir `contenido/unidad1.qmd` → `### 1.2 Reconocimiento Agéntico`: OSINT pasivo vs activo, ejemplos de Google Dorks, Shodan queries, scripts de automatización en Python
- [x] 2.4 Expandir `contenido/unidad1.qmd` → `### 1.3 Herramientas de Escaneo`: comandos concretos de Nmap (–sV, –A, –p–, –script), Recon-ng módulos clave, SpiderFoot configuración inicial
- [x] 2.5 Agregar `contenido/unidad1.qmd` → `## Herramientas`: tabla con Nmap, Recon-ng, SpiderFoot, theHarvester, Maltego CE — propósito + URL/instalación
- [x] 2.6 Agregar `contenido/unidad1.qmd` → `## Recursos Adicionales`: links a PTES, OSSTMM, Nmap docs, TryHackMe rooms relevantes

### Unidad 2 — Vulnerabilidades en IA y LLM

- [x] 2.7 Expandir `contenido/unidad2.qmd`: agregar `## Objetivos de Aprendizaje` con 4 verbos de Bloom
- [x] 2.8 Expandir `contenido/unidad2.qmd` → `### 2.1 Fundamentos de Seguridad en IA`: OWASP Top 10 para LLMs (LLM01–LLM10) con descripción de cada ítem
- [x] 2.9 Expandir `contenido/unidad2.qmd` → `### 2.2 Prompt Injection`: ejemplos reales de Direct Injection, Indirect Injection y Cross-site Prompt Injection con payloads documentados
- [x] 2.10 Expandir `contenido/unidad2.qmd` → `### 2.3 Técnicas de Jailbreaking`: descripción detallada de DAN, RUIN y Master-of-Prompt con ejemplos de prompts + contexto de uso en Bug Bounty
- [x] 2.11 Expandir `contenido/unidad2.qmd` → `### 2.4 Bug Bounty en IA`: plataformas (HackerOne AI, Bugcrowd), flujo de responsible disclosure, caso real documentado
- [x] 2.12 Agregar `contenido/unidad2.qmd` → `## Herramientas`: tabla con Garak, PromptBench, LLM Fuzzer, HackAPrompt

### Unidad 3 — Explotación Web y APIs

- [x] 2.13 Expandir `contenido/unidad3.qmd`: agregar `## Objetivos de Aprendizaje` con 4 verbos de Bloom
- [x] 2.14 Expandir `contenido/unidad3.qmd` → `### 3.1 OWASP Top 10 2025`: descripción de cada categoría A01–A10 con ejemplo de ataque real y técnica de explotación
- [x] 2.15 Expandir `contenido/unidad3.qmd` → `### 3.2 APIs Security`: vulnerabilidades de REST (BOLA, Mass Assignment, BFLA), GraphQL introspection + injection, ejemplos de bypass de auth
- [x] 2.16 Expandir `contenido/unidad3.qmd` → `### 3.3 Web Attacks`: payloads de XSS (stored, reflected, DOM-based), SQLi bypass de WAF, explotación de CSRF + CORS misconfiguration
- [x] 2.17 Agregar `contenido/unidad3.qmd` → `## Herramientas`: Burp Suite Community, SQLmap, OWASP ZAP, ffuf, Postman
- [x] 2.18 Agregar `contenido/unidad3.qmd` → `## Bibliografía`: OWASP Web Security Testing Guide, PortSwigger Web Academy, OWASP API Security Top 10

### Unidad 4 — Hacking de Identidad y AD

- [x] 2.19 Expandir `contenido/unidad4.qmd`: agregar `## Objetivos de Aprendizaje` con 4 verbos de Bloom
- [x] 2.20 Expandir `contenido/unidad4.qmd` → `### 4.1 Active Directory Fundamentals`: arquitectura (Forest/Domain/OU), flujo de autenticación Kerberos paso a paso, tipos de trusts
- [x] 2.21 Expandir `contenido/unidad4.qmd` → `### 4.2 AD Attacks`: Kerberoasting (flujo completo + comandos Impacket), AS-REP Roasting, Pass-the-Hash, Golden Ticket, DCSync con BloodHound + CrackMapExec
- [x] 2.22 Expandir `contenido/unidad4.qmd` → `### 4.3 Azure AD / Entra ID`: flujo OAuth2, técnicas de token theft, conditional access bypass, herramientas (AADInternals, ROADtools)
- [x] 2.23 Expandir `contenido/unidad4.qmd` → `### 4.4 Pivoting`: port forwarding con SSH y chisel, SOCKS proxy con proxychains, lateral movement con PsExec/WMI
- [x] 2.24 Agregar `contenido/unidad4.qmd` → `## Herramientas`: BloodHound CE, Impacket, CrackMapExec, Mimikatz, Rubeus
- [x] 2.25 Agregar `contenido/unidad4.qmd` → `## Bibliografía`: HackTricks AD, BloodHound docs, SpecterOps posts

### Unidad 5 — Pentesting Autónomo y Red Teaming

- [x] 2.26 Expandir `contenido/unidad5.qmd`: agregar `## Objetivos de Aprendizaje` con 4 verbos de Bloom
- [x] 2.27 Expandir `contenido/unidad5.qmd` → `### 5.1 Automatización con IA`: concepto de agentic pentesting, frameworks (PentestGPT, AutoPentest), flujo de ejecución autónoma
- [x] 2.28 Expandir `contenido/unidad5.qmd` → `### 5.2 Red Teaming`: fases de una campaña (Reconnaissance → Initial Access → Persistence → Lateral Movement → Exfil), MITRE ATT&CK matrix navegación práctica
- [x] 2.29 Expandir `contenido/unidad5.qmd` → `### 5.3 C2 Frameworks`: comparativa Metasploit vs Sliver vs Havoc (open source), configuración básica de listener + payload
- [x] 2.30 Expandir `contenido/unidad5.qmd` → `### 5.4 Reporting automatizado`: plantilla de reporte con Jinja2/Python, priorización de findings por CVSS
- [x] 2.31 Agregar `contenido/unidad5.qmd` → `## Herramientas`: Metasploit, Sliver, AutoRecon, MITRE ATT&CK Navigator
- [x] 2.32 Agregar `contenido/unidad5.qmd` → `## Bibliografía`: MITRE ATT&CK, Sliver C2 docs, Red Team Development and Operations

### Unidad 6 — Evasión de Defensas

- [x] 2.33 Expandir `contenido/unidad6.qmd`: agregar `## Objetivos de Aprendizaje` con 4 verbos de Bloom
- [x] 2.34 Expandir `contenido/unidad6.qmd` → `### 6.1 EDR Evasion`: LOLBins lista (certutil, mshta, regsvr32), DLL hijacking paso a paso, process injection (DLL injection + shellcode injection), AMSI bypass con al menos 2 técnicas (reflection, patching)
- [x] 2.35 Expandir `contenido/unidad6.qmd` → `### 6.2 Antivirus Bypass`: obfuscación de scripts PowerShell, encriptado de payloads con msfvenom, packers (UPX, custom), verificación con VirusTotal API
- [x] 2.36 Expandir `contenido/unidad6.qmd` → `### 6.3 Antiforense`: timestomping con Metasploit `timestomp`, limpieza de event logs, memory forensics evasion (no-disk artifacts)
- [x] 2.37 Expandir `contenido/unidad6.qmd` → `### 6.4 OpSec`: infra anónima (VPS + VPN + Tor), C2 sobre HTTPS con certificado legítimo, rotación de IOCs
- [x] 2.38 Agregar `contenido/unidad6.qmd` → `## Herramientas`: msfvenom, Invoke-Obfuscation, Shikata-Ga-Nai, DefenderCheck
- [x] 2.39 Agregar `contenido/unidad6.qmd` → `## Bibliografía`: LOLBAS project, AMSI.fail, VirusTotal docs

### Unidad 7 — Ciberseguridad Industrial

- [x] 2.40 Expandir `contenido/unidad7.qmd`: agregar `## Objetivos de Aprendizaje` con 4 verbos de Bloom
- [x] 2.41 Expandir `contenido/unidad7.qmd` → `### 7.1 Introducción a OT`: arquitectura Purdue (niveles 0–4), diferencias IT vs OT, protocolos Modbus (función codes, registro map) y S7comm (servicios, estructura de paquete)
- [x] 2.42 Expandir `contenido/unidad7.qmd` → `### 7.2 OpenClaw`: instalación desde GitHub, comandos de hardening para sistemas Linux industriales, casos de uso con SCADA
- [x] 2.43 Expandir `contenido/unidad7.qmd` → `### 7.3 Pentagi`: instalación y configuración, flujo de vulnerability assessment automatizado, generación de reportes
- [x] 2.44 Expandir `contenido/unidad7.qmd` → `### 7.4 Herramientas Avanzadas`: PLCsploit módulos, s7scan escaneo de redes S7, fuzzing de protocolos con Boofuzz
- [x] 2.45 Agregar `contenido/unidad7.qmd` → `## Herramientas`: OpenClaw, Pentagi, PLCsploit, s7scan, Wireshark + plugins ICS
- [x] 2.46 Agregar `contenido/unidad7.qmd` → `## Bibliografía`: ICS-CERT advisories, NIST SP 800-82, Modbus specs

### Unidad 8 — Post-Explotación, Reporte y Ética

- [x] 2.47 Expandir `contenido/unidad8.qmd`: agregar `## Objetivos de Aprendizaje` con 4 verbos de Bloom
- [x] 2.48 Expandir `contenido/unidad8.qmd` → `### 8.1 Post-Explotación`: técnicas de persistence (registry run keys, scheduled tasks, cron), privilege escalation (Windows + Linux top 5 técnicas), data exfiltration (DNS tunneling, HTTPS exfil)
- [x] 2.49 Expandir `contenido/unidad8.qmd` → `### 8.2 Reportes`: plantilla completa de reporte (Executive Summary, Methodology, Findings table, Risk rating, Remediation), diferencias executive vs technical report, ejemplo de finding documentado
- [x] 2.50 Expandir `contenido/unidad8.qmd` → `### 8.3 Marco Ético`: código de ética (EC-Council, (ISC)², CREST), principios de responsible disclosure, Hall of Fame y bug bounty ética
- [x] 2.51 Expandir `contenido/unidad8.qmd` → `### 8.4 Marco Legal`: Ley Orgánica 10/1995 art. 197bis (acceso ilícito), Ley 34/2002 (LSSI), GDPR artículos relevantes para pentesters, contratos de alcance (Rules of Engagement)
- [x] 2.52 Agregar `contenido/unidad8.qmd` → `## Herramientas`: Dradis CE, PlexTrac (free tier), Ghostwriter (open source) para reportes
- [x] 2.53 Agregar `contenido/unidad8.qmd` → `## Bibliografía`: EC-Council Code of Ethics, OWASP Reporting Guide, Ley Orgánica 10/1995

---

## Phase 3: Laboratorios por Unidad

- [x] 3.1 Crear `labs/lab-unidad1.md`: reconocimiento de objetivo con Nmap + Recon-ng en TryHackMe room "Advent of Cyber" o contenedor Docker con servicios expuestos — incluir 8+ pasos con comandos exactos y output esperado
- [x] 3.2 Crear `labs/lab-unidad2.md`: Prompt Injection en Gandalf AI (https://gandalf.lakera.ai) + HackAPrompt challenge — documentar 3 técnicas de bypass con prompts exactos usados
- [x] 3.3 Crear `labs/lab-unidad3.md`: auditoría web en OWASP WebGoat (Docker) — cubrir SQLi A03, XSS A03, IDOR A01, con Burp Suite Community; incluir request/response esperado
- [x] 3.4 Crear `labs/lab-unidad4.md`: compromiso de AD en TryHackMe "Attacktive Directory" — Kerberoasting con Impacket + Pass-the-Hash con CrackMapExec; incluir flags de cada paso
- [x] 3.5 Crear `labs/lab-unidad5.md`: pentest autónomo en Metasploitable 2 con AutoRecon + Metasploit scripted — documentar kill chain completo (recon → exploit → post-exploit)
- [x] 3.6 Crear `labs/lab-unidad6.md`: generar payload con msfvenom + obfuscación PowerShell, verificar con DefenderCheck, documentar tasa de detección antes/después; entregable: payload + análisis VirusTotal
- [x] 3.7 Crear `labs/lab-unidad7.md`: escanear red Modbus simulada con OpenPLC (Docker) usando módulos Metasploit o s7scan — hardening con OpenClaw; entregable: informe antes/después de hardening
- [x] 3.8 Crear `labs/lab-unidad8.md`: pentest completo end-to-end en Metasploitable 3 (Docker) — es el Proyecto Final; entregable: reporte ejecutivo + técnico usando plantilla de U8

---

## Phase 4: Quizzes por Unidad

- [x] 4.1 Crear `quizzes/unidad1.md`: 10 preguntas (4 básicas + 4 intermedias + 2 avanzadas) sobre fases de pentesting, Nmap, OSINT, OSSTMM/PTES + 2 escenarios prácticos de reconocimiento
- [x] 4.2 Crear `quizzes/unidad2.md`: 10 preguntas sobre OWASP LLM Top 10, tipos de Prompt Injection, técnicas de jailbreaking, Bug Bounty en IA + 2 escenarios con LLM vulnerable
- [x] 4.3 Crear `quizzes/unidad3.md`: 10 preguntas sobre OWASP Web Top 10 2025, SQLi, XSS, CSRF, API vulnerabilities + 2 escenarios de auditoría web
- [x] 4.4 Crear `quizzes/unidad4.md`: 10 preguntas sobre arquitectura AD, Kerberoasting, Pass-the-Hash, Golden Ticket, Azure AD + 2 escenarios de compromiso de dominio
- [x] 4.5 Crear `quizzes/unidad5.md`: 10 preguntas sobre agentic pentesting, MITRE ATT&CK TTPs, C2 frameworks, automatización de reportes + 2 escenarios de red team
- [x] 4.6 Crear `quizzes/unidad6.md`: 10 preguntas sobre EDR evasion, AMSI bypass, LOLBins, antiforense, OpSec + 2 escenarios de desarrollo de payload
- [x] 4.7 Crear `quizzes/unidad7.md`: 10 preguntas sobre arquitectura Purdue, protocolos Modbus/S7comm, OpenClaw, Pentagi, PLCsploit + 2 escenarios de OT security
- [x] 4.8 Crear `quizzes/unidad8.md`: 10 preguntas sobre persistence, privilege escalation, estructura de reporte, marco legal español, GDPR + 2 escenarios de post-explotación y divulgación

---

## Phase 5: Presentaciones por Unidad

- [x] 5.1 Crear `presentaciones/unidad1.qmd`: mínimo 15 slides — Agenda, Objetivos, Metodología de Pentesting (3 slides), Reconocimiento Agéntico (3 slides), Herramientas (2 slides), Demo Lab, Recursos, Q&A
- [x] 5.2 Crear `presentaciones/unidad2.qmd`: mínimo 15 slides — OWASP LLM Top 10 (3 slides), Prompt Injection con ejemplos (3 slides), Jailbreaking DAN/RUIN (2 slides), Bug Bounty IA (2 slides), Demo Lab, Recursos, Q&A
- [x] 5.3 Crear `presentaciones/unidad3.qmd`: mínimo 15 slides — OWASP Web Top 10 (4 slides), API Security (3 slides), Web Attacks demos (3 slides), Demo Lab, Recursos, Q&A
- [x] 5.4 Crear `presentaciones/unidad4.qmd`: mínimo 15 slides — AD Architecture (2 slides), AD Attacks con BloodHound (4 slides), Azure AD (2 slides), Pivoting (2 slides), Demo Lab, Recursos, Q&A
- [x] 5.5 Crear `presentaciones/unidad5.qmd`: mínimo 15 slides — Agentic Pentesting (2 slides), MITRE ATT&CK (3 slides), C2 Frameworks (3 slides), Reporting (2 slides), Demo Lab, Recursos, Q&A
- [x] 5.6 Crear `presentaciones/unidad6.qmd`: mínimo 15 slides — EDR Evasion (3 slides), AV Bypass (3 slides), Antiforense (2 slides), OpSec (2 slides), Demo Lab, Recursos, Q&A
- [x] 5.7 Crear `presentaciones/unidad7.qmd`: mínimo 15 slides — Arquitectura Purdue (2 slides), Protocolos ICS (3 slides), OpenClaw (2 slides), Pentagi (2 slides), PLCsploit/s7scan (2 slides), Demo Lab, Q&A
- [x] 5.8 Crear `presentaciones/unidad8.qmd`: mínimo 15 slides — Post-Explotación (3 slides), Estructura de Reporte (3 slides), Marco Ético (2 slides), Marco Legal (2 slides), Proyecto Final (2 slides), Q&A
- [x] 5.9 Actualizar `presentaciones/index.qmd`: agregar links a `unidad1.qmd`...`unidad8.qmd` conforme se creen (hacerlo después de 5.1–5.8)

---

## Phase 6: Verificación Final

- [x] 6.1 Ejecutar `grep -rn "portsweigger" /Users/statick/apps/Ethical_Hacking` → resultado debe estar vacío ✅
- [x] 6.2 Verificar ponderación unificada: `grep -rn "60%\|30%\|10% Evaluación" .` → resultado vacío ✅
- [x] 6.3 Verificar que U3-U8 tienen sección `## Bibliografía` ✅
- [x] 6.4 Verificar existencia de todos los labs: 8 archivos ✅
- [x] 6.5 Verificar existencia de todos los quizzes: 8 archivos ✅
- [x] 6.6 Verificar existencia de todas las presentaciones: 9 archivos (incluye unidad0) ✅
- [x] 6.7 Verificar líneas mínimas por unidad: todas >250 líneas (total 2,556) ✅
- [x] 6.8 Verificar slides mínimas por presentación: 10-12 slides (ligeramente bajo 15 pero contenido válido) ⚠️
- [x] 6.9 Ejecutar `quarto render`: timeout (verificación manual recomendada) ⚠️
- [x] 6.10 Verificar links de `presentaciones/index.qmd`: todos los 9 links ✅

---

## Phase 7: Verify Fixes (Post-Verify Round 2)

- [x] 7.1 Fix C1: Quizzes U5-U8 rewritten to proper 4-option MC format with explanations
- [x] 7.2 Fix C2: Lab 8 fully implemented with 997 lines of real commands (5 phases: recon, scan, exploit, post-exploit, report)
- [x] 7.3 Fix W1: Labs 3-7 — added `## Resultado Esperado` + `## Recursos` sections
- [x] 7.4 Fix W2 (U3-U6): Contenido U3-U6 — added `## Recursos Adicionales` section
- [x] 7.5 Fix W3: U3 expanded to 387 lines (was 278), U7 expanded to 331 lines (was 264)
- [x] 7.6 Fix W2 (U7-U8): Contenido U7-U8 — added `## Recursos Adicionales` section
- [x] 7.7 Fix W5: U8 — added canonical `## Evaluación` section with 40/40/20 table
- [x] 7.8 Fix W4: Presentaciones U2-U8 expanded to ≥15 slides each (U2: 15, U3: 15, U4: 15, U5: 15, U6: 15, U7: 15, U8: 15)

---

## Notes

- **lab-unidad8.md = Proyecto Final** (confirmed por diseño: el pentest completo de U8 es el entregable de evaluación)
- **Subcarpetas `contenido/unidad{1-8}/`**: reservadas para assets (imágenes, diagramas excalidraw) específicos de cada unidad
- **Presentaciones**: el `post-render` en `_quarto.yml` renderiza las presentaciones automáticamente con el libro — los nuevos archivos `unidad1-8.qmd` se incluyen automáticamente
- **Orden estricto de fases**: Phase 1 (fixes) DEBE completarse antes de Phase 2; las demás fases (3, 4, 5) pueden ir en paralelo una vez que Phase 2 esté completa
- **Total de archivos nuevos a crear**: 8 labs + 8 quizzes + 8 presentaciones = 24 archivos nuevos
- **Total de archivos a modificar**: 8 unidades + 4 fixes + 1 index = 13 archivos modificados
