# Quiz Unidad 3: Explotación Web y APIs

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Cuál es el OWASP Top 10 #1 actual?

a) XSS
b) SQL Injection
c) Broken Access Control
d) Insecure Design

**Respuesta correcta**: c

---

### Pregunta 2 (Básica)

¿Qué tipo de XSS se ejecuta en el servidor?

a) DOM-based
b) Reflected
c) Stored
d) Client-side

**Respuesta correcta**: c

---

### Pregunta 3 (Intermedia)

¿Qué significa IDOR?

a) Insecure Direct Object Reference
b) Internal Data Object Reference
c) Input Data Operation Routine
d) Internet Data Object Request

**Respuesta correcta**: a

---

### Pregunta 4 (Intermedia)

¿Cuál es el puerto default de GraphQL?

a) 80
b) 443
c) 5000
d) No tiene puerto fijo

**Respuesta correcta**: d

---

### Pregunta 5 (Avanzada)

¿Qué herramienta es mejor para SQL Injection automatizado?

a) Nmap
b) Burp Suite
c) SQLmap
d) Nikto

**Respuesta correcta**: c

---

### Pregunta 6 (Básica)

¿Qué es BOLA en APIs REST?

a) Basic Object Layer Access
b) Broken Object Level Authorization
c) Business Object Link Authentication
d) Binary Operation Log Analysis

**Respuesta correcta**: b

---

### Pregunta 7 (Intermedia)

¿Cómo se evadir CSRF protection?

a) Enviar el token en GET
b) No enviar el token desde otro dominio
c) Usar POST con JSON
d) Cambiar el User-Agent

**Respuesta correcta**: b

---

### Pregunta 8 (Avanzada)

¿Qué header falta en esta configuración vulnerable?

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Credentials: true
```

a) Access-Control-Allow-Methods
b) Es inseguro porque permite credenciales con wildcards
c) Access-Control-Expose-Headers
d) Nada, está correcta

**Respuesta correcta**: b

---

### Pregunta 9 (Básica)

¿Qué herramienta incluye un proxy interceptante?

a) Nmap
b) SQLmap
c) Burp Suite
d) Nikto

**Respuesta correcta**: c

---

### Pregunta 10 (Intermedia)

¿Cuál es el payload típico para SQL Injection básico?

a) <script>alert(1)</script>
b) ' OR '1'='1
c) ../../../etc/passwd
d) {{7*7}}

**Respuesta correcta**: b

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Encuentras un formulario de login que valida contra la base de datos.

**Pregunta**: ¿Qué vulnerabilidad es más probable?

a) XSS
b) CSRF
c) SQL Injection
d) IDOR

**Respuesta esperada**: SQL Injection

---

### Escenario 2

**Situación**: Una API permite cambiar el ID en la URL para ver perfiles de otros usuarios.

**Pregunta**: ¿Qué vulnerabilidad?

a) BOLA
b) XXE
c) SSRF
d) Open Redirect

**Respuesta esperada**: BOLA (Broken Object Level Authorization)
