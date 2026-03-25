# Lab 3: OWASP Juice Shop

## Descripción

OWASP Juice Shop es una aplicación web moderna y complejo que simula una tienda online de jugos (juice shop). Es la aplicación vulnerable más actualizada y cubre prácticamente todo el OWASP Top 10 junto con muchas otras vulnerabilidades de seguridad.

### Características

- Arquitectura moderna (Node.js, Angular, SQLite)
- Interfaz de usuario atractiva y funcional
- Sistema de puntuación (Score Board)
- Más de 100 desafíos de diferentes dificultades
- APIs REST y GraphQL vulnerables

### Vulnerabilidades Cubiertas

Juice Shop incluye vulnerabilidades de múltiples categorías:

- Injection (SQL, NoSQL, Command, LDAP)
- Broken Authentication
- Sensitive Data Exposure
- XXE
- Broken Access Control
- Security Misconfiguration
- Cross-Site Scripting (XSS)
- Insecure Deserialization
- Using Components with Known Vulnerabilities
- Insufficient Logging & Monitoring

## Requisitos

- Docker Engine 24.0+
- Puerto 3000 disponible
- Mínimo 1GB de RAM
- Node.js 14+ (incluido en el contenedor)

## Credenciales por Defecto

### Cuentas de Usuario

| Campo | Valor |
|-------|-------|
| Admin Email | `admin@juice-sh.op` |
| Admin Password | `admin123` |
| User Email | `user@juice-sh.op` |
| User Password | `user123` |

### Base de Datos

| Campo | Valor |
|-------|-------|
| DB File | `juice_shop.db` (SQLite) |

> **Nota**: Estas credenciales son para propósito de CTF/aprendizaje. En producción, deben cambiarse.

## Instalación

### Usando Docker

```bash
# Ejecutar Juice Shop
docker run -d \
  --name juice-shop \
  -p 3000:3000 \
  bkimminich/juice-shop

# Verificar que el contenedor está ejecutándose
docker ps | grep juice-shop
```

### Usando Docker Compose

Crear archivo `docker-compose.yml`:

```yaml
version: '3.8'

services:
  juice-shop:
    image: bkimminich/juice-shop
    container_name: juice-shop
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=prod
    restart: unless-stopped
```

Ejecutar:

```bash
docker-compose up -d
```

## Score Board

Una de las características más importantes de Juice Shop es el Score Board, que muestra todos los desafíos disponibles y su estado.

### Acceder al Score Board

1. Abrir navegador: `http://localhost:3000`
2. Iniciar sesión o navegar como usuario guest
3. Ir a Score Board (generalmente en el footer o mediante código de trampilla)
4. Alternativamente, acceder directamente: `http://localhost:3000/#/score-board`

### Código de Trampilla para Score Board

En la consola del navegador:

```javascript
// Muestra el Score Board
localStorage.setItem('showSolvedChallenges', 'true')
localStorage.setItem('showChallengeHints', 'true')
window.location.reload()
```

## Verificación de Acceso

### Verificar que el contenedor está ejecutándose

```bash
docker ps | grep juice-shop
```

### Probar acceso a la aplicación

```bash
# Probar endpoint principal
curl -I http://localhost:3000

# Probar API REST
curl -I http://localhost:3000/api/Challenges

# Probar archivo de敦煌
curl -I http://localhost:3000/juice_logo.png
```

### Acceder desde el navegador

1. Abrir navegador en: `http://localhost:3000`
2. Debería mostrar la tienda online de jugos
3. Explorar como usuario guest o iniciar sesión

## Ejercicios

### Ejercicio 1: Exploración Inicial

1. Navegar por toda la aplicación
2. Identificar todas las funcionalidades:
   - Catálogo de productos
   - Carrito de compras
   - Login/Registro
   - Buscador
   - Panel de usuario
3. Documentar endpoints observados

### Ejercicio 2: SQL Injection en Buscador

1. Ir al buscador de productos
2. Probar payloads:
   - `' OR '1'='1`
   - `'; DROP TABLE Users;--`
3. Observar diferentes respuestas
4. Documentar qué funciona y qué no

### Ejercicio 3: XSS Stored en Reseñas

1. Ir a la sección de reseñas de productos
2. Insertar XSS en el campo de reseña:
   - `<script>alert('XSS')</script>`
   - `<img src=x onerror=alert(1)>`
3. Verificar ejecución en diferentes páginas

### Ejercicio 4: Broken Access Control - Admin

1. Intentar acceder a panel de admin:
   - `/admin`
   - `/#/admin`
2. Identificar cómo escalar privilegios
3. Documentar el path de explotación

### Ejercicio 5: Vulnerabilidades de API

1. Estudiar endpoints de la API:
   - `/api/Products`
   - `/api/Users`
   - `/api/Basket`
2. Identificar:
   - Falta de autorización
   - Información sensible expuesta
   - IDOR (Insecure Direct Object Reference)

### Ejercicio 6: Score Board y Desafíos

1. Acceder al Score Board
2. Completar desafíos de dificultad "Tutorial"
3. Progresar a desafíos "Easy"
4. Documentar hallazgos en cada categoría

### Ejercicio 7: CSRF

1. Crear un formulario malicioso que cambie el email del usuario
2. Enviar link al usuario logueado
3. Verificar si el ataque tiene éxito

### Ejercicio 8: JWT Vulnerabilities

1. Analizar tokens JWT de autenticación
2. Intentar ataques:
   - Algoritmo none
   - Key confusion
   - Expiración manipulada
3. Documentar la explotación

## Comandos de Gestión

### Detener el laboratorio

```bash
docker stop juice-shop
```

### Reiniciar el laboratorio

```bash
docker restart juice-shop
```

### Eliminar el laboratorio

```bash
docker stop juice-shop
docker rm juice-shop
```

### Ver logs

```bash
docker logs juice-shop
docker logs -f juice-shop  # Follow mode
```

### Acceder a shell del contenedor

```bash
docker exec -it juice-shop sh
```

## Solución de Problemas

### Puerto 3000 en uso

Cambiar puerto:

```bash
docker run -d --name juice-shop -p 3001:3000 bkimminich/juice-shop
```

### Error de memoria

Aumentar límite de memoria:

```bash
docker run -d --name juice-shop \
  -p 3000:3000 \
  -m 1g \
  bkimminich/juice-shop
```

### Problemas de rendimiento

Ejecutar con más recursos:

```bash
docker run -d --name juice-shop \
  -p 3000:3000 \
  --cpus=2 \
  --memory=2g \
  bkimminich/juice-shop
```

### Base de datos corrupta

Reiniciar datos:

```bash
docker exec juice-shop npm run json-server -- --port 3000 &
# O regenerar base de datos
docker exec juice-shop node init.js
```

## Desafíos Populares

| Desafío | Dificultad | Categoría |
|---------|------------|-----------|
| Score Board | - | Intro |
| Admin Section | Easy | Broken Access Control |
| Zero Stars | Easy | Injection |
| Reflected XSS | Easy | XSS |
| Database Schema | Medium | Injection |
| Forgotten Dev Backup | Medium | Sensitive Data |
| Retrieve Blueprint | Medium | Security Misconfiguration |
| Admin Registration | Hard | Broken Access Control |

## Herramientas Recomendadas

- **OWASP ZAP**: Proxy de seguridad
- **Burp Suite**: Análisis de tráfico
- **sqlmap**: Automatización SQLi
- **dirb**: Enumeración de directorios

## Referencias

- [Juice Shop Official Site](https://juice-shop.herokuapp.com/)
- [Juice Shop GitHub](https://github.com/juice-shop/juice-shop)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP Juice Shop Wiki](https://pwning.owasp-juice.shop/)
