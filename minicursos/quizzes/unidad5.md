# Quiz Unidad 5: Pentesting Autónomo y Red Teaming

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Qué significa la sigla CVSS?

a) Common Vulnerability Scoring System
b) Cybersecurity Vulnerability Scan Standard
c) Critical Vulnerability Summary Sheet
d) Common Vector Security Score

**Respuesta correcta**: a
**Explicación**: CVSS (Common Vulnerability Scoring System) es un estándar abierto para evaluar la gravedad de las vulnerabilidades de seguridad, con puntuaciones del 0 al 10.

---

### Pregunta 2 (Básica)

¿Qué rango de puntuación CVSS se considera "Crítico"?

a) 7.0 - 8.9
b) 5.0 - 6.9
c) 9.0 - 10.0
d) 8.0 - 9.5

**Respuesta correcta**: c
**Explicación**: Las vulnerabilidades con CVSS entre 9.0 y 10.0 se clasifican como Críticas y requieren remediación inmediata.

---

### Pregunta 3 (Básica)

¿Qué herramienta automatiza el proceso completo de reconocimiento en un pentest?

a) Metasploit
b) AutoRecon
c) Nmap básico
d) SQLmap

**Respuesta correcta**: b
**Explicación**: AutoRecon es una herramienta de reconocimiento multi-hilo que ejecuta automáticamente múltiples herramientas de enumeración en paralelo sobre los objetivos.

---

### Pregunta 4 (Básica)

¿Cuál es el entregable principal al finalizar un pentest profesional?

a) Un exploit funcional
b) El listado de herramientas usadas
c) El reporte de pentest
d) Las credenciales encontradas

**Respuesta correcta**: c
**Explicación**: El reporte de pentest es el documento formal que incluye hallazgos, evidencias, impacto y recomendaciones de remediación para el cliente.

---

### Pregunta 5 (Intermedia)

¿Cuál es la principal diferencia entre un Red Team y un pentest tradicional?

a) El Red Team usa más herramientas
b) El Red Team simula un adversario real con objetivos específicos durante un período extendido
c) El pentest es siempre más exhaustivo
d) No hay diferencia operacional

**Respuesta correcta**: b
**Explicación**: El Red Team emula tácticas, técnicas y procedimientos (TTPs) de actores de amenaza reales para medir la capacidad de detección y respuesta del equipo defensor, mientras que el pentest busca vulnerabilidades de forma más sistemática.

---

### Pregunta 6 (Intermedia)

¿Qué es el "agentic pentesting"?

a) Pentesting realizado por equipos de agentes humanos
b) Pentesting asistido por IA autónoma que toma decisiones sin intervención constante
c) Un tipo de pentest de aplicaciones web
d) Pentesting remoto sin acceso físico

**Respuesta correcta**: b
**Explicación**: El agentic pentesting utiliza agentes de IA como PentestGPT o sistemas basados en LLMs que pueden razonar, planificar y ejecutar acciones de forma autónoma durante un ejercicio de seguridad.

---

### Pregunta 7 (Intermedia)

¿Qué framework de MITRE documenta las tácticas, técnicas y procedimientos de los atacantes?

a) MITRE CVE
b) MITRE D3FEND
c) MITRE ATT&CK
d) MITRE SHIELD

**Respuesta correcta**: c
**Explicación**: MITRE ATT&CK es una base de conocimiento de TTPs basada en observaciones del mundo real que los red teamers usan para planificar y mapear sus actividades.

---

### Pregunta 8 (Intermedia)

¿Qué herramienta de IA fue diseñada específicamente para asistir en operaciones de pentesting mediante un enfoque conversacional?

a) AutoSploit
b) PentestGPT
c) Metasploit AI
d) GPT-Nmap

**Respuesta correcta**: b
**Explicación**: PentestGPT es una herramienta basada en LLMs que guía al pentester a través de las fases del proceso, sugiriendo herramientas y técnicas según el contexto del objetivo.

---

### Pregunta 9 (Avanzada)

¿Cuál de las siguientes NO es un framework C2 (Command and Control)?

a) Cobalt Strike
b) Sliver
c) Havoc
d) Nmap

**Respuesta correcta**: d
**Explicación**: Nmap es una herramienta de escaneo y reconocimiento de red. Cobalt Strike, Sliver y Havoc son frameworks C2 utilizados en operaciones de red teaming para controlar sistemas comprometidos.

---

### Pregunta 10 (Avanzada)

En el contexto de la automatización de pentesting, ¿qué es el "vulnerability chaining"?

a) Encadenar herramientas de escaneo secuencialmente
b) Combinar múltiples vulnerabilidades de bajo impacto para lograr un impacto mayor
c) Listar vulnerabilidades por orden de descubrimiento
d) Usar la misma vulnerabilidad en múltiples objetivos

**Respuesta correcta**: b
**Explicación**: El vulnerability chaining consiste en combinar varias vulnerabilidades que individualmente tienen poco impacto, pero encadenadas permiten comprometer un sistema o escalar privilegios de forma significativa.

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Eres contratado para realizar un red team contra una empresa de servicios financieros. El cliente quiere evaluar su capacidad de detección ante un ataque de ransomware simulado. Tienes 4 semanas y acceso a toda la superficie de ataque externa.

**Preguntas de análisis**:

1. ¿Qué fases incluirías en tu planificación y en qué orden las ejecutarías?
2. ¿Cómo mapearías tus actividades al framework MITRE ATT&CK para el informe final?
3. ¿Qué métricas usarías para medir el éxito del ejercicio desde la perspectiva del equipo de seguridad del cliente?

**Respuesta esperada**: El estudiante debe identificar las fases: reconocimiento externo → acceso inicial → movimiento lateral → persistencia → simulación de impacto. Debe mencionar el uso de MITRE ATT&CK para mapear TTPs, y proponer métricas como tiempo de detección (MTTD), tiempo de respuesta (MTTR) y porcentaje de TTPs detectados.

**Criterios**: El estudiante debe demostrar comprensión de la diferencia entre red team y pentest, y entender cómo se evalúa el Blue Team dentro de un ejercicio de red teaming.

---

### Escenario 2

**Situación**: Durante un pentest automatizado con AutoRecon, identificas 5 vulnerabilidades: una de CVSS 6.5 en el servidor web, una de CVSS 9.8 en un servicio FTP expuesto, dos de CVSS 4.3 en el CMS, y una de CVSS 7.1 en el servidor de base de datos. El cliente solicita priorización para la remediación.

**Preguntas de análisis**:

1. ¿En qué orden priorizarías la remediación y por qué?
2. ¿Sería posible encadenar alguna de estas vulnerabilidades para aumentar el impacto? Justifica.
3. ¿Cómo presentarías estos hallazgos en el reporte ejecutivo versus el técnico?

**Respuesta esperada**: El estudiante debe priorizar por CVSS: primero la de 9.8 (Crítica), luego la de 7.1 (Alta), luego la de 6.5 (Media) y por último las de 4.3. Debe explorar si el CVSS 6.5 del web más el 9.8 del FTP permiten pivotar. Debe distinguir que el ejecutivo necesita impacto en negocio y el técnico necesita pasos de reproducción.

**Criterios**: El estudiante debe aplicar correctamente la escala CVSS y demostrar pensamiento crítico sobre vulnerability chaining y comunicación a diferentes audiencias.
