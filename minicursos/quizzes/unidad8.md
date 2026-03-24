# Quiz Unidad 8: Post-Explotación, Reporte y Ética

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Qué es la "persistencia" en el contexto de post-explotación?

a) Mantener el acceso al sistema comprometido tras un reinicio o cierre de sesión
b) Permanecer oculto en el sistema durante más de 24 horas
c) Replicar el malware a otros sistemas
d) Mantener el canal C2 cifrado

**Respuesta correcta**: a
**Explicación**: La persistencia consiste en establecer mecanismos que garanticen que el acceso al sistema comprometido se mantenga incluso después de reinicios, actualizaciones o cambios de credenciales.

---

### Pregunta 2 (Básica)

¿Cuál es la herramienta más conocida para credential dumping en Windows?

a) Cobalt Strike
b) Responder
c) Mimikatz
d) Bloodhound

**Respuesta correcta**: c
**Explicación**: Mimikatz es una herramienta open source creada por Benjamin Delpy que permite extraer credenciales en texto plano, hashes NTLM y tickets Kerberos de la memoria del proceso LSASS en sistemas Windows.

---

### Pregunta 3 (Básica)

¿Qué es el "pivoting" en post-explotación?

a) Cambiar de usuario dentro del mismo sistema
b) Usar un sistema comprometido como punto de salto para atacar redes internas no accesibles directamente
c) Rotar las claves de cifrado del canal C2
d) Escalar privilegios usando vulnerabilidades del kernel

**Respuesta correcta**: b
**Explicación**: El pivoting utiliza un host comprometido como relay para alcanzar segmentos de red internos que no son directamente accesibles desde el atacante, permitiendo expandir el alcance del compromiso.

---

### Pregunta 4 (Básica)

¿Qué mecanismo de persistencia en Windows usa las claves de registro `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`?

a) Scheduled Tasks
b) Run Keys
c) WMI Subscriptions
d) DLL Hijacking

**Respuesta correcta**: b
**Explicación**: Las Run Keys son entradas del registro de Windows que ejecutan programas automáticamente al iniciar sesión el usuario, siendo uno de los mecanismos de persistencia más comunes y monitorizados.

---

### Pregunta 5 (Intermedia)

¿Qué rango de puntuación CVSS corresponde a severidad "Alta"?

a) 4.0 - 6.9
b) 7.0 - 8.9
c) 9.0 - 10.0
d) 5.5 - 7.5

**Respuesta correcta**: b
**Explicación**: Según la escala CVSS v3.x: None (0.0), Low (0.1-3.9), Medium (4.0-6.9), High (7.0-8.9) y Critical (9.0-10.0).

---

### Pregunta 6 (Intermedia)

¿Cuál es la principal diferencia entre el reporte ejecutivo y el reporte técnico de un pentest?

a) El ejecutivo es más largo y detallado
b) El ejecutivo está dirigido a la dirección con impacto en negocio; el técnico incluye evidencias y pasos de reproducción para el equipo técnico
c) Solo el técnico incluye recomendaciones de remediación
d) El ejecutivo se entrega antes y el técnico después

**Respuesta correcta**: b
**Explicación**: El reporte ejecutivo comunica el impacto en negocio, riesgos y resumen de hallazgos para audiencias no técnicas. El reporte técnico detalla las vulnerabilidades, evidencias, pasos de reproducción y recomendaciones técnicas específicas para los equipos de remediación.

---

### Pregunta 7 (Intermedia)

¿Qué ley española regula el acceso ilícito a sistemas informáticos ajenos?

a) Art. 248 del Código Penal (estafa informática)
b) Art. 197 bis del Código Penal
c) Ley Orgánica de Protección de Datos (LOPD)
d) Real Decreto de Ciberseguridad Nacional

**Respuesta correcta**: b
**Explicación**: El Art. 197 bis del Código Penal español tipifica el acceso sin autorización a sistemas de información (hacking) con penas de prisión, aplicándose incluso cuando no se causan daños aparentes.

---

### Pregunta 8 (Avanzada)

Según el RGPD (GDPR), ¿en qué plazo máximo debe notificarse una brecha de seguridad a la autoridad de control?

a) 24 horas desde la detección
b) 48 horas desde la detección
c) 72 horas desde que se tiene conocimiento de la brecha
d) 7 días hábiles desde la detección

**Respuesta correcta**: c
**Explicación**: El Art. 33 del RGPD establece que las organizaciones deben notificar a la autoridad supervisora (en España, la AEPD) dentro de las 72 horas siguientes al momento en que tenga conocimiento de una brecha de datos personales.

---

### Pregunta 9 (Avanzada)

¿Qué framework C2 es el más utilizado en operaciones de red team profesionales y está desarrollado por HelpSystems (anteriormente Fortra)?

a) Metasploit Framework
b) Empire
c) Cobalt Strike
d) Sliver

**Respuesta correcta**: c
**Explicación**: Cobalt Strike es el framework C2 comercial más utilizado en red team profesional, conocido por sus Beacon payloads, maleabilidad de comunicación y capacidades de simulación de adversarios avanzados (APT).

---

### Pregunta 10 (Avanzada)

¿En qué consiste el "responsible disclosure" o divulgación responsable?

a) Publicar la vulnerabilidad inmediatamente para que todos puedan protegerse
b) Reportar la vulnerabilidad al vendedor/afectado, dar un plazo razonable para remediarla y solo entonces publicarla
c) Vender la vulnerabilidad al mejor postor antes de publicarla
d) Reportar únicamente a las autoridades gubernamentales

**Respuesta correcta**: b
**Explicación**: El responsible disclosure (también conocido como coordinated vulnerability disclosure) es el proceso ético de informar al fabricante o responsable de la vulnerabilidad, negociar un plazo para la corrección (típicamente 90 días) y publicar los detalles solo después de que exista un parche disponible.

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Durante un pentest autorizado a una empresa de retail, obtienes acceso a un servidor Windows con privilegios de administrador local. Desde ese servidor, consigues acceso a la base de datos de clientes que contiene nombres, emails, fechas de nacimiento y números de tarjeta de crédito parcialmente enmascarados de 250.000 clientes. El pentest está en su tercera semana de cuatro.

**Preguntas de análisis**:

1. ¿Qué obligaciones legales y éticas tienes en este momento como pentester?
2. ¿Cómo documentas este hallazgo sin comprometer la privacidad de los datos reales?
3. ¿Qué información debe incluir el reporte para este hallazgo específico en cada sección (ejecutiva vs técnica)?

**Respuesta esperada**: Obligaciones: detener el acceso a datos personales reales en cuanto se confirma el hallazgo, notificar al cliente de inmediato (no esperar al reporte final) ya que pueden tener obligaciones RGPD propias. Documentación: capturar solo las evidencias mínimas necesarias (estructura de tabla, número de registros, campos presentes), nunca exportar datos reales; usar datos anonimizados en el reporte. Reporte ejecutivo: impacto en negocio (riesgo RGPD, multas, reputación), afectados estimados. Reporte técnico: vector de acceso, pasos de reproducción, evidencias sin PII, CVSS calculado.

**Criterios**: El estudiante debe demostrar comprensión de las obligaciones legales (RGPD, Art. 197 bis), la importancia de la notificación inmediata en hallazgos críticos y el manejo ético de datos personales durante un pentest.

---

### Escenario 2

**Situación**: Tras completar un red team de 6 semanas, has comprometido el 80% de los activos del cliente, incluyendo el controlador de dominio, un servidor de correo con emails de directivos y varios equipos de desarrolladores con acceso a código fuente. Ahora debes redactar el informe final y presentarlo al CISO y a los desarrolladores.

**Preguntas de análisis**:

1. ¿Cómo estructurarías el informe final y qué elementos incluirías en cada sección?
2. ¿Cómo priorizarías las recomendaciones de remediación para el equipo técnico?
3. ¿Qué mensaje principal llevarías a la presentación con el CISO vs la presentación con los desarrolladores?

**Respuesta esperada**: Estructura del informe: portada + NDA/scope, resumen ejecutivo (impacto en negocio, métricas clave: tiempo hasta compromiso, % activos comprometidos), hallazgos por criticidad, recomendaciones priorizadas, apéndices técnicos con evidencias. Priorización: primero las que impidieron la detección (Active Directory, lateral movement sin alertas), luego las de mayor impacto (DC, correo), con remediation roadmap a 30/60/90 días. Para el CISO: impacto en negocio, exposición de datos ejecutivos, postura de seguridad, inversiones recomendadas. Para los desarrolladores: vulnerabilidades técnicas específicas, código o configuraciones concretas a cambiar, recursos de formación.

**Criterios**: El estudiante debe demostrar capacidad para comunicar resultados técnicos a diferentes audiencias, y entender que el valor del pentest se mide por la calidad de las recomendaciones accionables, no solo por los hallazgos.
