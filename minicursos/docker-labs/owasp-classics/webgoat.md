# Lab 1: WebGoat

## Descripción

WebGoat es una plataforma de entrenamiento de seguridad web desarrollada por OWASP. Es una aplicación Java deliberadamente vulnerable que enseña lecciones de seguridad web interactivas.

### Vulnerabilidades Cubiertas

WebGoat cubre múltiples categorías de vulnerabilidades OWASP:

- Inyección SQL (SQL Injection)
- Cross-Site Scripting (XSS)
- Broken Authentication
- Sensitive Data Exposure
- XML External Entities (XXE)
- Broken Access Control
- Security Misconfiguration

## Requisitos

- Docker Engine 24.0+
- Puerto 8080 disponible
- Mínimo 2GB de RAM
- Java 8+ (incluido en el contenedor)

## Credenciales por Defecto

| Campo | Valor |
|-------|-------|
| Username | `webgoat` |
| Password | `webgoat` |

> **Nota**: Estas credenciales son las que vienen por defecto. En un entorno de producción, DEBEN ser cambiadas.

## Instalación

### Usando Docker

```bash
# Ejecutar WebGoat
docker run -d \
  --name webgoat \
  -p 8080:8080 \
  webgoat/webgoat-8.0

# Verificar que el contenedor está ejecutándose
docker ps | grep webgoat
```

### Usando Docker Compose

Crear archivo `docker-compose.yml`:

```yaml
version: '3.8'

services:
  webgoat:
    image: webgoat/webgoat-8.0
    container_name: webgoat
    ports:
      - "8080:8080"
    environment:
      - WEBGOAT_PORT=8080
    restart: unless-stopped
```

Ejecutar:

```bash
docker-compose up -d
```

## Verificación de Acceso

### Verificar que el contenedor está ejecutándose

```bash
docker ps | grep webgoat
```

Debería mostrar el contenedor "webgoat" con estado "Up".

### Probar acceso a la aplicación

```bash
# Probar endpoint principal
curl -I http://localhost:8080/WebGoat/

# Probar API
curl -I http://localhost:8080/WebGoat/api/users/current
```

### Acceder desde el navegador

1. Abrir navegador en: `http://localhost:8080/WebGoat/`
2. Debería mostrar la página de login de WebGoat
3. Iniciar sesión con credenciales por defecto:
   - Username: `webgoat`
   - Password: `webgoat`

## Ejercicios

### Ejercicio 1: Navegación Básica

1. Iniciar sesión en WebGoat
2. Explorar el menú de lecciones en el panel izquierdo
3. Seleccionar una lección de "Introduction"
4. Completar la primera lección

### Ejercicio 2: SQL Injection Básico

1. Ir a "Injection" > "SQL Injection (Intro)"
2. Leer la descripción de la vulnerabilidad
3. Completar los ejercicios prácticos
4. Documentar qué inputs causaron la inyección

### Ejercicio 3: Cross-Site Scripting (XSS)

1. Ir a "Cross-Site Scripting (XSS)" > "Reflected XSS"
2. Identificar campos vulnerables
3. Ejecutar payload básico: `<script>alert('XSS')</script>`
4. Documentar el comportamiento observado

### Ejercicio 4: Autenticación

1. Ir a "Broken Authentication"
2. Explorar las lecciones de gestión de sesiones
3. Completar ejercicio de "Session Fixation"
4. Documentar las vulnerabilidades encontradas

### Ejercicio 5: XXE (XML External Entities)

1. Ir a "XXE" > "XXE Basics"
2. Estudiar cómo se procesan archivos XML
3. Completar los ejercicios prácticos
4. Documentar el impacto de XXE

## Comandos de Gestión

### Detener el laboratorio

```bash
docker stop webgoat
```

### Reiniciar el laboratorio

```bash
docker restart webgoat
```

### Eliminar el laboratorio

```bash
docker stop webgoat
docker rm webgoat
```

### Ver logs

```bash
docker logs webgoat
docker logs -f webgoat  # Follow mode
```

## Solución de Problemas

### Puerto 8080 en uso

Si el puerto 8080 está en uso, cambiar el puerto del host:

```bash
docker run -d --name webgoat -p 9090:8080 webgoat/webgoat-8.0
```

### Contenedor no inicia

Verificar logs:

```bash
docker logs webgoat
```

### Problemas de memoria

Aumentar memoria asignada a Docker o ejecutar con límites:

```bash
docker run -d --name webgoat \
  -p 8080:8080 \
  -m 1g \
  webgoat/webgoat-8.0
```

## Referencias

- [WebGoat Official Documentation](https://webgoat.atbug.com/)
- [OWASP WebGoat GitHub](https://github.com/WebGoat/WebGoat)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
