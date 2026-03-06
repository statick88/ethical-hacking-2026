# Quiz Unidad 1: Fundamentos y Reconocimiento Agéntico

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Cuál es la primera fase del pentesting según la metodología PTES?

a) Explotación
b) Reconocimiento
c) Reporte
d) Escaneo

**Respuesta correcta**: b
**Explicación**: El reconocimiento (Intelligence Gathering) es la primera fase donde se recolecta información sobre el objetivo.

---

### Pregunta 2 (Básica)

¿Qué tipo de reconocimiento NO toca directamente el objetivo?

a) Escaneo de puertos
b) OSINT pasivo
c) Nmap activo
d) Conexión directa

**Respuesta correcta**: b
**Explicación**: El OSINT pasivo usa fuentes públicas sin interactuar con el objetivo.

---

### Pregunta 3 (Intermedia)

¿Cuál de las siguientes herramientas se utiliza principalmente para reconocimiento web automatizado?

a) Nmap
b) Metasploit
c) Recon-ng
d) Burp Suite

**Respuesta correcta**: c
**Explicación**: Recon-ng es un framework modular específico para reconocimiento web.

---

### Pregunta 4 (Intermedia)

¿Qué flag de Nmap realiza un escaneo SYN (half-open)?

a) -sT
b) -sU
c) -sS
d) -sP

**Respuesta correcta**: c
**Explicación**: -sS es el escaneo SYN que no completa el handshake TCP.

---

### Pregunta 5 (Intermedia)

¿Cuál es el propósito del parámetro `-sC` en Nmap?

a) Escaneo de servicios
b) Ejecución de scripts NSE por defecto
c) Detección de SO
d) Escaneo rápido

**Respuesta correcta**: b
**Explicación**: -sC ejecuta los scripts por defecto del NSE.

---

### Pregunta 6 (Avanzada)

En el contexto de OSINT, ¿qué es un "Google Dork"?

a) Un exploit para Google
b) Búsqueda avanzada con operadores
c) Una herramienta de hacking
d) Un tipo de ataque

**Respuesta correcta**: b
**Explicación**: Los Google Dorks son consultas avanzadas usando operadores como site:, filetype:, etc.

---

### Pregunta 7 (Básica)

¿Qué protocolo usa Nmap por defecto para el escaneo?

a) UDP
b) TCP
c) ICMP
d) HTTP

**Respuesta correcta**: b
**Explicación**: Nmap escanea puertos TCP por defecto.

---

### Pregunta 8 (Intermedia)

¿Cuál es el rango de puertos "bien conocidos" en TCP?

a) 0-1023
b) 1024-49151
c) 49152-65535
d) 1-80

**Respuesta correcta**: a
**Explicación**: Los puertos 0-1023 son puertos bien conocidos (well-known ports).

---

### Pregunta 9 (Avanzada)

¿Qué herramienta es mejor para enumeración masiva de subdominios?

a) Nmap básico
b) theHarvester
c) Burp Suite
d) SQLmap

**Respuesta correcta**: b
**Explicación**: theHarvester está diseñado para enumerar subdominios, emails y más.

---

### Pregunta 10 (Intermedia)

¿Cuál es la principal ventaja del escaneo UDP comparado con TCP?

a) Más rápido
b) Más silencioso
c) Puede detectar servicios sin handshake
d) Siempre más detallado

**Respuesta correcta**: c
**Explicación**: El escaneo UDP puede identificar servicios que responden sin necesidad de handshake.

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Un pentester recibe un objetivo: `empresa.com`. Necesita identificar todos los subdominios posibles.

**Pregunta**: ¿Cuál es el mejor enfoque inicial?

a) Ejecutar nmap -p- empresa.com
b) Usar Google Dorks para buscar subdominios
c) Enviar emails de phishing
d) Atacar directamente el DNS

**Respuesta esperada**: Usar Google Dorks como `site:empresa.com -www` y herramientas como subfinder o amass.

**Criterios**: El estudiante debe identificar que OSINT es la primera opción antes de escaneo activo.

---

### Escenario 2

**Situación**: Durante un escaneo con Nmap, el resultado muestra "filtered" en varios puertos.

**Pregunta**: ¿Qué significa el estado "filtered"?

a) El puerto está cerrado
b) El puerto está abierto
c) Probablemente hay un firewall filtrando
d) El escaneo falló

**Respuesta esperada**: "Filtered" indica que un firewall o filtro de red está evitando que Nmap determine el estado del puerto.

**Criterios**: El estudiante debe entender la diferencia entre estados: open, closed, filtered.
