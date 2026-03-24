---
title: "Quiz Unidad 1: Fundamentos y Reconocimiento Agéntico"
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

### Escenario 1: Reconocimiento Inicial

**Situación**: Eres pentester y recibes el objetivo `intranet.empresa.local`. No tienes acceso directo a la red, pero necesitas información inicial.

**Comando parcial para completar:**
```bash
whois ___
```

**Pregunta 1:** ¿Qué información clave obtendrás de este comando que te ayudará en el reconocimiento?

**Tu respuesta debe incluir:**
- Al menos 3 tipos de datos que whois proporciona
- Cómo usarías cada uno en tu reconocimiento

---

### Escenario 2: Análisis de Output

**Output de Nmap:**
```
PORT   STATE    SERVICE
22/tcp open     ssh
80/tcp filtered http
443/tcp open    https
```

**Pregunta 2:** Analiza este output y responde:
1. ¿Qué significa que el puerto 80 esté "filtered"?
2. ¿Qué enfoque de ataque podrías intentar considerando este estado?
3. ¿Qué comando parcial usarías para investigar más a fondo?
   - `nmap -sV -p ___ [IP]`

---

### Escenario 3: Comando Incompleto

**Situación**: Necesitas escanear todos los puertos de una IP específica, pero solo recuerdas parte del comando.

**Comando parcial:**
```bash
nmap -p- ___
```

**Pregunta 3:**
1. Completa el comando con la IP adecuada (usa 192.168.1.100 como ejemplo)
2. Explica qué hace cada flag del comando
3. ¿Qué alternativa usarías si necesitaras escanear solo puertos TCP comunes?

---

## Sección B: Razonamiento Técnico (30%)

### Pregunta 4: Comparación de Herramientas

**Instrucción:** No copies respuestas. Explica con tus propias palabras.

**Comando parcial 1:**
```bash
nmap -sS -F ___
```

**Comando parcial 2:**
```bash
masscan ___ --rate=1000
```

**Pregunta:** 
1. ¿En qué escenario usarías nmap vs masscan?
2. ¿Qué ventajas tiene cada uno?
3. Completa ambos comandos con una IP de ejemplo y explica el resultado esperado

---

### Pregunta 5: Debugging de Comandos

**Situación:** Un compañero te envía este comando para enumerar subdominios, pero tiene errores:

```bash
subfinder -d ___ -o output.txt -v
```

**Pregunta:**
1. ¿Qué parámetro falta en el comando?
2. ¿Cómo verificarías que el comando funciona correctamente?
3. ¿Qué alternativa usarías si subfinder no estuviera disponible?

---

## Sección C: Aplicación Práctica (30%)

### Reto 1: Construcción de Comando

**Objetivo:** Construye un comando de reconocimiento completo usando solo partes proporcionadas.

**Partes disponibles:**
- Herramienta: `nmap`
- Flags: `-sS`, `-sV`, `-p-`, `--open`
- IP objetivo: `192.168.1.50`

**Tu tarea:**
1. Ordena las partes en un comando funcional
2. Explica qué hace cada flag
3. ¿Qué output esperas obtener?

**Comando a completar:**
```bash
___ ___ ___ ___ ___
```

---

### Reto 2: Análisis de Escenario Real

**Escenario:** Estás realizando reconocimiento pasivo y encuentras que la empresa objetivo usa WordPress en su sitio principal.

**Pregunta:**
1. ¿Qué comandos parciales usarías para investigar vulnerabilidades específicas de WordPress?
   - `wpscan --url ___ --enumerate ___`
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
