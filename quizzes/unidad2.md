# Quiz Unidad 2: Vulnerabilidades en IA y Modelos de Lenguaje

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Qué es Prompt Injection?

a) Inyección de código en el modelo
b) Manipulación de entradas para obtener respuestas no autorizadas
c) Un tipo de malware
d) Un protocolo de red

**Respuesta correcta**: b

---

### Pregunta 2 (Básica)

¿Cuál es el OWASP Top 10 para LLMs #1?

a) Insecure Output Handling
b) Prompt Injection
c) Training Data Poisoning
d) Model Denial of Service

**Respuesta correcta**: b

---

### Pregunta 3 (Intermedia)

¿Qué técnica de jailbreaking crea una "persona" alternativa?

a) Prompt Injection
b) DAN (Do Anything Now)
c) Token Smuggling
d) Fuzzing

**Respuesta correcta**: b

---

### Pregunta 4 (Intermedia)

¿En qué consiste el Indirect Prompt Injection?

a) Enviar instrucciones en el mensaje directo
b) Inyectar instrucciones a través de datos que el LLM procesará
c) Modificar el código fuente del modelo
d) Enviar múltiples prompts simultáneamente

**Respuesta correcta**: b

---

### Pregunta 5 (Avanzada)

¿Qué plataforma ofrece bug bounty para OpenAI?

a) OnlyFans
b) HackerOne
c) Reddit
d) Twitter

**Respuesta correcta**: b

---

### Pregunta 6 (Básica)

¿Qué herramienta se usa para fuzzing de prompts?

a) Nmap
b) Garak
c) Metasploit
d) SQLmap

**Respuesta correcta**: b

---

### Pregunta 7 (Intermedia)

¿Cuál es el propósito de "temperature" en un LLM?

a) Controlar la seguridad
b) Controlar la "creatividad" de las respuestas
c) Aumentar la velocidad
d) Reducir costes

**Respuesta correcta**: b

---

### Pregunta 8 (Avanzada)

¿Qué técnica usa caracteres combinables para evadir filtros?

a) Base64 encoding
b) Unicode obfuscation
c) JWT manipulation
d) SQL injection

**Respuesta correcta**: b

---

### Pregunta 9 (Básica)

¿Qué es Gandalf AI?

a) Un framework de pentesting
b) Un laboratorio para practicar prompt injection
c) Un antivirus
d) Un sistema operativo

**Respuesta correcta**: b

---

### Pregunta 10 (Intermedia)

El "Responsible Disclosure" implica:

a) Publicar vulnerabilidades inmediatamente
b) Reportar al vendor y dar tiempo para remediar
c) Vender la vulnerabilidad
d) Ignorar el hallazgo

**Respuesta correcta**: b

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Estás auditando un chatbot empresarial que usa un LLM. El usuario puede enviar mensajes que son procesados directamente.

**Pregunta**: ¿Qué vulnerabilidad es más probable?

a) Buffer Overflow
b) Prompt Injection
c) SQL Injection
d) XSS tradicional

**Respuesta esperada**: Prompt Injection, ya que la entrada del usuario se procesa directamente por el LLM.

---

### Escenario 2

**Situación**: Un investigador encuentra que un sitio web vulnerable a XSS puede controlar las respuestas de un LLM que resume páginas.

**Pregunta**: ¿Qué tipo de ataque es?

a) Direct Prompt Injection
b) Indirect Prompt Injection
c) Cross-Site Scripting tradicional
d) Inyección SQL

**Respuesta esperada**: Indirect Prompt Injection a través del contenido XSS que el LLM procesa.
