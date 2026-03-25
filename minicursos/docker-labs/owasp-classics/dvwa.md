# Lab 2: DVWA (Damn Vulnerable Web Application)

## Descripción

DVWA es una aplicación web PHP/MySQL deliberadamente vulnerable. Es una herramienta de entrenamiento esencial para profesionales de seguridad y desarrolladores que desean aprender sobre vulnerabilidades web comunes.

### Vulnerabilidades Cubiertas

DVWA incluye las siguientes vulnerabilidades OWASP Top 10:

- Broken Access Control
- Security Misconfiguration
- Cross-Site Scripting (XSS)
- SQL Injection (SQLi)
- Command Injection
- File Inclusion (Local/Remote)
- CSRF (Cross-Site Request Forgery)

## Requisitos

- Docker Engine 24.0+
- Puerto 80 interno (exponer como puerto libre en host)
- MySQL (incluido en el contenedor)
- Mínimo 512MB de RAM

## Credenciales por Defecto

| Campo | Valor |
|-------|-------|
| Username | `admin` |
| Password | `password` |

| Campo | Valor (Base de Datos) |
|-------|----------------------|
| DB User | `root` |
| DB Password | `root` |

> **Nota**: En un entorno de producción, TODAS estas credenciales deben ser cambiadas inmediatamente.

## Instalación

### Usando Docker

```bash
# Ejecutar DVWA
docker run -d \
  --name dvwa \
  -p 8081:80 \
  -p 443:443 \
  vulnerables/web-dvwa

# Verificar que el contenedor está ejecutándose
docker ps | grep dvwa
```

> **Nota**: Se usa puerto 8081 para evitar conflicto con otros servicios en el puerto 8080.

### Usando Docker Compose

Crear archivo `docker-compose.yml`:

```yaml
version: '3.8'

services:
  dvwa:
    image: vulnerables/web-dvwa
    container_name: dvwa
    ports:
      - "8081:80"
      - "4443:443"
    environment:
      - WEB_PORT=80
      - HTTPS_PORT=443
    restart: unless-stopped
```

Ejecutar:

```bash
docker-compose up -d
```

## Configuración de Seguridad

DVWA tiene tres niveles de seguridad que pueden configurarse desde la interfaz:

| Nivel | Descripción | Uso |
|-------|-------------|-----|
| **low** | Sin protecciones | Aprender vulnerabilidades básicas |
| **medium** | Protecciones parciales | Practicar bypass de filtros |
| **high** | Protecciones completas | Desafíos avanzados |

### Cambiar nivel de seguridad

1. Iniciar sesión en DVWA
2. Ir a "DVWA Security" en el menú
3. Seleccionar el nivel deseado
4. Click en "Submit"

## Verificación de Acceso

### Verificar que el contenedor está ejecutándose

```bash
docker ps | grep dvwa
```

### Probar acceso a la aplicación

```bash
# Probar HTTP
curl -I http://localhost:8081

# Probar HTTPS (si está configurado)
curl -kI https://localhost:4443
```

### Acceder desde el navegador

1. Abrir navegador en: `http://localhost:8081`
2. Debería mostrar la página de login de DVWA
3. Si aparece "Could not connect to the database", esperar 30 segundos y recargar
4. Iniciar sesión con credenciales por defecto:
   - Username: `admin`
   - Password: `password`
5. Ir a "Setup" > "Create/Reset Database" para inicializar la base de datos

## Ejercicios

### Ejercicio 1: SQL Injection

1. Configurar Security Level a "low"
2. Ir a "SQL Injection"
3. Introducir: `' OR '1'='1`
4. Observar el comportamiento
5. Cambiar a "medium" y "high", documentar las diferencias

### Ejercicio 2: XSS Reflected

1. Ir a "XSS Reflected"
2. Introducir payload: `<script>alert('XSS')</script>`
3. Observar que el script se ejecuta
4. Probar con diferentes filtros
5. Documentar qué funciona en cada nivel de seguridad

### Ejercicio 3: XSS Stored

1. Ir a "XSS Stored"
2. Dejar un mensaje malicioso en el guestbook
3. Verificar que se ejecuta cada vez que alguien visita la página
4. Comparar con XSS Reflected

### Ejercicio 4: Command Injection

1. Ir a "Command Injection"
2. Ejecutar comandos del sistema:
   - `127.0.0.1 && whoami`
   - `127.0.0.1 && cat /etc/passwd`
3. Documentar los comandos que funcionan

### Ejercicio 5: File Inclusion

1. Ir a "File Inclusion"
2. Intentar incluir archivos locales:
   - `../../../../etc/passwd`
3. Probar Remote File Inclusion
4. Documentar las configuraciones vulnerables

### Ejercicio 6: CSRF

1. Ir a "CSRF"
2. Crear una página falsa que cambie la contraseña
3. Documentar cómo funciona el ataque
4. Comparar con las protecciones en nivel "high"

## Comandos de Gestión

### Detener el laboratorio

```bash
docker stop dvwa
```

### Reiniciar el laboratorio

```bash
docker restart dvwa
```

### Eliminar el laboratorio

```bash
docker stop dvwa
docker rm dvwa
```

### Ver logs

```bash
docker logs dvwa
docker logs -f dvwa  # Follow mode
```

### Reiniciar base de datos

Para reiniciar la base de datos a estado inicial:

```bash
docker exec dvwa setup-silent
```

## Solución de Problemas

### Error de conexión a base de datos

La base de datos MySQL puede tomar tiempo en iniciar. Esperar hasta 60 segundos:

```bash
# Ver logs de la base de datos
docker logs dvwa

# Reiniciar contenedor si es necesario
docker restart dvwa
```

### Puerto en uso

Cambiar puerto:

```bash
docker run -d --name dvwa -p 8082:80 vulnerables/web-dvwa
```

### Permisos de archivos

Si hay errores de permisos:

```bash
docker exec dvwa chmod -R 777 /var/www/html/hackable/uploads
```

## Niveles de Seguridad - Comparación

| Vulnerabilidad | Low | Medium | High |
|----------------|-----|--------|------|
| SQL Injection | Sin filtro | addslashes() | Prepared statements |
| XSS | Sin filtro | htmlspecialchars | Strict CSP |
| Command Injection | Sin filtro | Operador ; bloqueado | Whitelist |
| File Inclusion | Allow include | Bloquea ../ | Validación estricta |

## Referencias

- [DVWA Official GitHub](https://github.com/digininja/DVWA)
- [DVWA Documentation](https://dvwa.co.uk/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
