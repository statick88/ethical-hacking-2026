---
title: "Quiz Unidad 3: Explotación Web y APIs"
author: "Diego Saavedra"
---

# ⚠️ AVISO ANTI-IA

**Esta evaluación está diseñada para medir TU comprensión, no la capacidad de una IA.**

**Si detectamos uso de IA:**
- La respuesta será marcada como inválida
- Se te pedirá explicar cada paso verbalmente
- Podrás perder puntos por copia no autorizada

**Mi recomendación:** Responde basándote en tu comprensión real del tema.

---

**Puntaje mínimo**: 7/10 (70%)

---

## Sección A: Análisis de Escenarios (40%)

### Escenario 1: SQL Injection en WebGoat

**Situación**: Estás audiendo una aplicación WebGoat y encuentras un formulario de login vulnerable.

**Comando parcial para completar:**
```bash
# Payload para bypass de autenticación:
___'--
```

**Pregunta 1:** ¿Qué información clave obtendrás de este comando que te ayudará en el reconocimiento?

**Tu respuesta debe incluir:**
- Explicación de cómo funciona el payload
- Qué resultado esperas obtener
- Cómo usarías esta técnica en un pentest real

---

### Escenario 2: XSS en campos de entrada

**Situación**: Encuentras un campo de búsqueda que no sanitiza el input.

**Comando parcial para completar:**
```bash
# Payload para XSS reflejado:
___
```

**Pregunta 2:** Analiza este output y responde:
1. ¿Qué significa que el XSS sea "reflejado" vs "almacenado"?
2. ¿Cómo verificarías si es XSS almacenado?
3. ¿Qué medidas de mitigación recomendarías?

---

### Escenario 3: IDOR en URLs

**Situación**: Observas que la aplicación usa parámetros como `userId` en las URLs.

**Comando parcial para completar:**
```bash
# Acceso a recursos de otro usuario:
curl -s "http://localhost:8080/WebGoat/___/userId=___"
```

**Pregunta 3:**
1. Completa el comando con el endpoint correcto
2. Explica qué es IDOR y por qué es peligroso
3. ¿Cómo prevenir esta vulnerabilidad?

---

## Sección B: Razonamiento Técnico (30%)

### Pregunta 4: Comparación de Vulnerabilidades

**Instrucción:** No copies respuestas. Explica con tus propias palabras.

**Comando parcial:**
```bash
# Verificar cabeceras de seguridad:
curl -I http://localhost:8080/WebGoat
```

**Pregunta:** 
1. ¿Qué cabeceras de seguridad deberían estar presentes?
2. ¿Por qué es importante `Content-Security-Policy`?
3. ¿Cómo mitigarías vulnerabilidades de configuración?

---

### Pregunta 5: Debugging de Comandos

**Situación:** Un compañero te envía este comando para SQL Injection, pero tiene errores:

```bash
sqlmap -u "http://localhost:8080/WebGoat/___" --dbs
```

**Pregunta:**
1. ¿Qué parámetro falta en el comando?
2. ¿Cómo verificarías que el comando funciona correctamente?
3. ¿Qué alternativa usarías si sqlmap no estuviera disponible?

---

## Sección C: Aplicación Práctica (30%)

### Reto 1: Construcción de Payload

**Objetivo:** Construir un payload de XSS completo usando partes proporcionadas.

**Partes disponibles:**
- Tag: `<script>`
- Función: `alert()`
- Variable: `document.cookie`
- Cierre: `</script>`

**Tu tarea:**
1. Ordena las partes en un payload funcional
2. Explica qué hace cada elemento
3. ¿Qué output esperas obtener?

**Payload a completar:**
```html
___
```

---

### Reto 2: Análisis de Escenario Real

**Escenario:** Estás realizando una auditoría y encuentras que la aplicación usa cookies de sesión.

**Pregunta:**
1. ¿Qué comandos parciales usarías para analizar cookies?
   - `curl -b "___" http://localhost:8080/WebGoat`
2. ¿Qué información buscarías específicamente?
3. ¿Cómo integrarías esto en tu reporte de pentesting?

---

## Verificación de Autoría

### Declaración Personal (Obligatoria)

**Antes de entregar, responde:**

> **¿Qué objeto está frente a tu cámara web o en tu escritorio en este momento?**

**Tu respuesta debe ser:**
- Personal y específica
- Describe algo único de tu entorno
- No puede ser genérica o copiada

**Ejemplo de respuesta aceptada:**
"Mi taza de café azul con un logo de la empresa, mi mouse negro Razer, y una nota adhesiva amarilla en el monitor"

**Ejemplo de respuesta NO aceptada:**
"Una computadora" o "Un escritorio"

---

### Checklist de Autoría

- [ ] Escribí cada respuesta basándome en mi comprensión
- [ ] Completo los comandos parciales sin copiar de fuentes externas
- [ ] Puedo explicar verbalmente cada concepto
- [ ] Mi respuesta de verificación es personal y específica
- [ ] Si me borrarán todo, podría recrear las respuestas

**Nombre:** _______________
**Fecha:** _______________
**ID Estudiante:** _______________
