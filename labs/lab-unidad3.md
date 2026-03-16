---
title: "Lab 3: Auditoría Web con OWASP WebGoat"
author: "Diego Saavedra"
---

# 🎯 Lab 3: Auditoría Web con OWASP WebGoat

## ⏱️ Timeline de Verificación

| Paso | Descripción | Tiempo | Completado |
|------|-------------|--------|------------|
| 1 | Configuración del entorno | 15 min | ⬜ |
| 2 | SQL Injection (A03) | 25 min | ⬜ |
| 3 | Cross-Site Scripting (A07) | 20 min | ⬜ |
| 4 | Broken Access Control (A01) | 20 min | ⬜ |
| 5 | Security Misconfigurations (A05) | 15 min | ⬜ |
| 6 | Documentación de hallazgos | 25 min | ⬜ |
| **Total** | | **120 min** | |

---

## 🎯 Objetivo

Seremos capaces de identificar y explotar vulnerabilidades web en una aplicación vulnerable, aplicando técnicas del OWASP Top 10.

---

## ⚠️ Importante: No Copiar, Teclear

**REGLA ORO**: Los comandos deben completarse manualmente. No copies y pegues.

**Por qué**: Escribir los comandos te ayuda a memorizar la sintaxis y entender cada parámetro.

---

## 1. Prerrequisitos

### 1.1. Software Necesario

- **Docker**: Instalado y funcionando
- **Navegador web**: Chrome, Firefox o similar
- **Burp Suite Community** (opcional, recomendado)

### 1.2. Recursos del Sistema

- **RAM**: 4GB mínimo
- **CPU**: 2 núcleos mínimo
- **Disco**: 5GB disponibles

---

## 2. Configuración del Entorno

### 2.1. Iniciar WebGoat

Haremos uso de Docker para levantar la aplicación vulnerable.

**Comando para iniciar:**
```bash
docker run -d -p 8080:8080 --name webgoat owasp/webgoat
```

**Verificación:**
```bash
docker ps | grep webgoat
```

**Resultado esperado**: Deberías ver el contenedor `webgoat` corriendo.

### 2.2. Acceder a la Aplicación

Abre tu navegador y navega a:
```
http://localhost:8080/WebGoat
```

**Credenciales iniciales:**
- Usuario: `guest`
- Contraseña: `guest`

---

## 3. Ejercicios del Laboratorio

### 3.1. SQL Injection (A03:2021 - Inyección de SQL)

**Objetivo**: Explotar vulnerabilidades de SQL Injection en el formulario de login.

#### Paso 1: Identificar el punto de inyección

**Tu tarea**: Probar payloads en el campo de usuario del formulario de login.

**Payloads parciales para completar:**
```bash
# En formulario de login, probar:
___'--
___' OR '1'='1
___' UNION SELECT NULL--
```

**Pista**: El payload básico usa comillas simples para cerrar la consulta SQL.

**Resultado esperado**: Deberías ver un bypass de autenticación o datos extraídos de la base de datos.

#### Paso 2: Extraer información de la base de datos

**Tu tarea**: Usar UNION SELECT para extraer información de la base de datos.

**Comando parcial:**
```bash
___' UNION SELECT 1,table_name,NULL FROM information_schema.tables--
```

**Pista**: `information_schema.tables` contiene los nombres de todas las tablas.

**Resultado esperado**: Lista de tablas de la base de datos.

### 3.2. Cross-Site Scripting (A07:2021 - XSS)

**Objetivo**: Explotar vulnerabilidades de Cross-Site Scripting en campos de entrada.

#### Paso 1: Identificar campos vulnerables

**Tu tarea**: Buscar campos de entrada que no sanitizen el input.

**Comandos parciales para probar:**
```bash
# En campos de búsqueda o comentarios:
___
___
```

**Payloads parciales:**
```javascript
<script>alert(document.cookie)</script>
<svg onload=alert(1)>
<img src=x onerror=alert(1)>
```

**Pista**: Busca campos donde puedas insertar HTML/JavaScript.

**Resultado esperado**: Alerta de JavaScript ejecutada en el navegador.

#### Paso 2: XSS Almacenado

**Tu tarea**: Encontrar un punto donde el XSS se almacene y se ejecute en otros usuarios.

**Comando parcial:**
```bash
# Insertar payload en campo que se muestra a otros usuarios:
___
```

**Pista**: Busca funcionalidades como comentarios, perfiles o mensajes.

**Resultado esperado**: Captura de pantalla del `alert()` ejecutándose.

### 3.3. Broken Access Control (A01:2021 - Control de Acceso Roto)

**Objetivo**: Explotar vulnerabilidades de control de acceso.

#### Paso 1: IDOR (Insecure Direct Object Reference)

**Tu tarea**: Cambiar IDs en URLs para acceder a recursos de otros usuarios.

**Comando parcial:**
```bash
# Acceder a recursos de otro usuario:
curl -s "http://localhost:8080/WebGoat/___/userId=___"
```

**Pista**: Prueba cambiar el parámetro `userId` o similar.

**Resultado esperado**: Acceso a datos de otro usuario sin autenticación.

#### Paso 2: Bypass de restricciones de admin

**Tu tarea**: Intentar acceder a funcionalidades administrativas sin ser admin.

**Acciones parciales:**
```bash
# Probar diferentes métodos:
1. Cambiar headers: ___
2. Modificar cookies: ___
3. Usar HTTP methods alternativos: ___
```

**Pista**: Prueba HEAD, OPTIONS o modifica headers de autenticación.

**Resultado esperado**: Acceso a funcionalidades administrativas.

### 3.4. Security Misconfigurations (A05:2021 - Mala Configuración de Seguridad)

**Objetivo**: Identificar cabeceras de seguridad faltantes o información sensible expuesta.

#### Paso 1: Analizar cabeceras HTTP

**Tu tarea**: Obtener las cabeceras HTTP de la aplicación.

**Comando parcial:**
```bash
curl -I ___
```

**Pista**: Usa el flag `-I` para obtener solo las cabeceras.

**Resultado esperado**: Lista de cabeceras HTTP con sus valores.

#### Paso 2: Identificar cabeceras faltantes

**Tu tarea**: Identificar al menos 3 cabeceras de seguridad ausentes.

**Cabeceras a buscar:**
- `X-Frame-Options`: Previene clickjacking
- `Content-Security-Policy`: Previene XSS
- `Strict-Transport-Security`: Fuerza HTTPS
- `X-Content-Type-Options`: Previene MIME sniffing

**Comando parcial:**
```bash
# Verificar cabeceras específicas:
curl -I http://localhost:8080/WebGoat | grep -i "___"
```

**Resultado esperado**: Identificación de cabeceras de seguridad ausentes.

---

## 4. Verificación del Laboratorio

Hemos completado el laboratorio cuando:

- [ ] WebGoat está corriendo en Docker
- [ ] SQL Injection exitosa (bypass de autenticación o extracción de datos)
- [ ] XSS almacenado ejecutándose en el navegador
- [ ] IDOR explotado (acceso a datos de otro usuario)
- [ ] Cabeceras de seguridad analizadas
- [ ] Reporte de hallazgos documentado

---

## 5. Entregable

**Archivo**: `web_security_audit.md`

**Contenido obligatorio**:
- Descripción técnica de cada vulnerabilidad
- Pasos para reproducir (con comandos parciales completados)
- Request/Response capturado
- Impacto de cada vulnerabilidad
- Recomendación de remediación

**Evidencia mínima aceptable**:
- Captura de Burp Suite con el request SQL injection y respuesta
- Archivo `web_security_audit.md` con las 4 vulnerabilidades documentadas
- Capturas de pantalla de XSS y IDOR explotados

---

## 6. Troubleshooting

### Problema 1: "No se puede conectar a WebGoat"

**Solución**:
```bash
# Verificar contenedor
docker ps | grep webgoat

# Si no está corriendo, reiniciar
docker stop webgoat
docker rm webgoat
docker run -d -p 8080:8080 --name webgoat owasp/webgoat
```

### Problema 2: "SQL Injection no funciona"

**Solución**:
- Verifica que estás usando el payload correcto
- Prueba con diferentes combinaciones de comillas
- Usa Burp Suite para capturar y modificar requests

### Problema 3: "XSS no se ejecuta"

**Solución**:
- Verifica que el payload está siendo interpretado como HTML
- Prueba diferentes payloads (alert, console.log, etc.)
- Revisa la consola del navegador para errores

---

## 7. Ejercicios Propuestos

**Sin ayuda, completa estos desafíos:**

1. Encuentra una vulnerabilidad de Command Injection en WebGoat
2. Explota una vulnerabilidad de XXE (XML External Entity)
3. Identifica vulnerabilidades de deserialización de objetos

---

## 8. Recursos

- [PortSwigger Web Security Academy](https://portswigger.net/web-security)
- [OWASP WebGoat](https://owasp.org/www-project-webgoat/)
- [OWASP Top 10 - 2021](https://owasp.org/Top10/)
- [OWASP Testing Guide v4.2](https://owasp.org/www-project-web-security-testing-guide/)
- [CWE-89: SQL Injection](https://cwe.mitre.org/data/definitions/89.html)
- [CWE-79: Cross-site Scripting](https://cwe.mitre.org/data/definitions/79.html)

---

**Alumno**: Diego Medardo Saavedra García  
**Universidad**: Universidad Complutense de Madrid  
**Máster**: Ciberseguridad: Seguridad Defensiva y Ofensiva  
**Curso**: 2026/2027