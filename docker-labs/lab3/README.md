# 🕷️ Unidad 3: Explotación Web y APIs 2026 - LAB PRÁCTICO

## 📋 Arquitectura
- **DVWA (Port 80)**: SQLi y XSS clásico (Hacking tradicional).
- **Juice Shop (Port 3000)**: Web moderna (Node.js/Angular), NoSQL, JWT, XSS avanzado.
- **VAPI (Port 8081)**: Laboratorio de seguridad de APIs REST (BOLA, Mass Assignment).
- **Kali Linux (172.18.3.20)**: Entorno atacante.

## 🚀 Ejercicios Sugeridos

### 1. SQL Injection en DVWA
- Logeate sin conocer la password usando \u0027 OR \u00271\u0027=\u00271.
- Usa `sqlmap` desde Kali contra `http://dvwa/login.php`.

### 2. XSS en Juice Shop
- Encuentra el campo de búsqueda e inyecta un payload `<iframe src="javascript:alert(\u0027XSS\u0027)">`.
- Busca el IDOR en las facturas de clientes (BOLA).

### 3. API Hacking en VAPI
- Audita los endpoints `/api/v1/user/1` y manipula los IDs.
- Prueba Inyección de Comandos en la funcionalidad de reporte.

## 🛑 Limpieza
`docker-compose down -v`