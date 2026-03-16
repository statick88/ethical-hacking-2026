---
title: "Lab 1: Reconocimiento y Enumeración"
author: "Diego Saavedra"
---

# 🎯 Lab 1: Reconocimiento y Enumeración

## ⏱️ Timeline de Verificación

| Paso | Descripción | Tiempo | Completado |
|------|-------------|--------|------------|
| 1 | Reconocimiento Pasivo con OSINT | 20 min | ⬜ |
| 2 | Escaneo de Red con Nmap | 25 min | ⬜ |
| 3 | Enumeración Web | 20 min | ⬜ |
| 4 | Enumeración de Servicios | 25 min | ⬜ |
| 5 | Análisis de Resultados | 15 min | ⬜ |
| **Total** | | **105 min** | |

---

## 🎯 Objetivo

Seremos capaces de realizar un reconocimiento completo de un objetivo simulado utilizando herramientas de OSINT y escaneo de red. Aplicaremos técnicas de reconocimiento pasivo y activo **sin copiar comandos**, sino completándolos.

---

## ⚠️ Importante: No Copiar, Teclear

**REGLA ORO**: Los comandos deben completarse manualmente. No copies y pegues.

**Por qué**: Escribir los comandos te ayuda a memorizar la sintaxis y entender cada parámetro.

---

## 1. Prerrequisitos

### 1.1. Software Necesario

- **Máquina Kali Linux**: VMware/VirtualBox
- **Conexión a internet**: Para acceder a recursos online
- **Docker**: Para levantar servicios vulnerables

### 1.2. Recursos del Sistema

- **RAM**: 4GB mínimo (8GB recomendado)
- **CPU**: 2 núcleos mínimo
- **Disco**: 20GB disponibles

### 1.3. Entorno

- **Atacante**: Kali Linux (192.168.56.10)
- **Objetivo**: Máquina vulnerable en red local o TryHackMe

---

## 2. Escenario

Eres un pentester contratado por una empresa mediana para realizar la fase de reconocimiento de un pentest. Tu objetivo es obtener la máxima información posible sobre el objetivo sin interactuar directamente con sus sistemas de producción.

---

## Pasos

### Paso 1: Reconocimiento Pasivo con OSINT

**Objetivo**: Recolectar información sin tocar el objetivo.

#### Tarea 1.1: Información de Dominio con WHOIS

**Tu tarea**: Obtener información de registro del dominio

**Comando parcial:**
```bash
whois ___
```

**Pista**: Usa el dominio de ejemplo `empresa-ejemplo.com`

**Resultado esperado**: Información de registro (contacto, fechas, nameservers)

---

#### Tarea 1.2: Enumeración DNS con dig

**Tu tarea**: Consultar registros DNS del dominio

**Comandos parciales:**
```bash
# Consultar nameservers
dig ___ empresa-ejemplo.com

# Consultar mailservers
dig ___ empresa-ejemplo.com
```

**Pista**: Los flags son `NS` para nameservers y `MX` para mailservers

**Resultado esperado**: Lista de servidores de nombres y correos

---

#### Tarea 1.3: Google Dorks

**Tu tarea**: Buscar información expuesta usando operadores de búsqueda

**Comandos parciales (escribe en el buscador de Google):**
```
site:empresa-ejemplo.com ___
site:empresa-ejemplo.com ___
```

**Pista**: 
- Busca archivos PDF y Excel
- Busca términos como "password" o "username"

**Resultado esperado**: Enlaces a documentos potencialmente sensibles

---

#### Tarea 1.4: Búsqueda de Subdominios

**Tu tarea**: Encontrar subdominios del objetivo

**Comando parcial 1:**
```bash
subfinder -d ___
```

**Comando parcial 2:**
```bash
amass enum -d ___
```

**Pista**: Usa el mismo dominio de ejemplo

**Resultado esperado**: Lista de subdominios descubiertos

---

#### Tarea 1.5: Búsqueda de Emails

**Tu tarea**: Encontrar emails asociados al dominio

**Comando parcial:**
```bash
theHarvester -d ___ -b ___
```

**Pista**: 
- El dominio es `empresa-ejemplo.com`
- El backend `-b` puede ser `all`, `google`, `bing`, etc.

**Resultado esperado**: Lista de emails encontrados

---

### Paso 2: Escaneo de Red con Nmap

**Objetivo**: Identificar puertos abiertos y servicios.

#### Tarea 2.1: Escaneo TCP SYN Rápido

**Tu tarea**: Escanear rangos de red rápidamente

**Comando parcial:**
```bash
nmap -sS -F ___
```

**Pista**: El rango de red es `192.168.56.0/24`

**Resultado esperado**: Lista de hosts con puertos abiertos

---

#### Tarea 2.2: Escaneo Completo

**Tu tarea**: Escanear todos los puertos de un objetivo específico

**Comando parcial:**
```bash
nmap -sS -sV -sC -p- ___ -oN ___
```

**Pista**: 
- El objetivo es `192.168.56.5`
- Guarda el resultado en `scan_full.txt`

**Resultado esperado**: Archivo con todos los puertos y servicios

---

#### Tarea 2.3: Escaneo UDP

**Tu tarea**: Escanear puertos UDP comunes

**Comando parcial:**
```bash
nmap -sU -p ___ ___
```

**Pista**: 
- Los puertos comunes UDP son 53, 161, 123
- El objetivo es `192.168.56.5`

**Resultado esperado**: Puertos UDP abiertos

---

#### Tarea 2.4: Detección de Sistema Operativo

**Tu tarea**: Identificar el SO del objetivo

**Comando parcial:**
```bash
nmap -O ___
```

**Pista**: El objetivo es `192.168.56.5`

**Resultado esperado**: Sistema operativo detectado

---

#### Tarea 2.5: Scripts de Vulnerabilidad

**Tu tarea**: Ejecutar scripts de detección de vulnerabilidades

**Comando parcial:**
```bash
nmap --script vuln ___
```

**Pista**: El objetivo es `192.168.56.5`

**Resultado esperado**: Lista de vulnerabilidades detectadas

---

### Paso 3: Enumeración Web

**Objetivo**: Identificar tecnologías y vulnerabilidades web.

#### Tarea 3.1: WhatWeb - Tecnología Web

**Tu tarea**: Identificar tecnologías del sitio web

**Comando parcial:**
```bash
whatweb -a 3 http://___
```

**Pista**: El objetivo es `192.168.56.5`

**Resultado esperado**: Tecnologías detectadas (CMS, frameworks, etc.)

---

#### Tarea 3.2: Nikto - Escaneo Web

**Tu tarea**: Realizar escaneo de vulnerabilidades web

**Comando parcial:**
```bash
nikto -h http://___
```

**Pista**: El objetivo es `192.168.56.5`

**Resultado esperado**: Lista de vulnerabilidades web

---

#### Tarea 3.3: Directorios con ffuf

**Tu tarea**: Descubrir directorios ocultos

**Comando parcial:**
```bash
ffuf -u http://___/FUZZ -w /usr/share/wordlists/dirb/common.txt
```

**Pista**: El objetivo es `192.168.56.5`

**Resultado esperado**: Lista de directorios encontrados

---

#### Tarea 3.4: Subdominios Web

**Tu tarea**: Encontrar subdominios web

**Comando parcial:**
```bash
gobuster dns -d ___ -w /usr/share/wordlists/subdomains.txt
```

**Pista**: El dominio es `empresa-ejemplo.com`

**Resultado esperado**: Subdominios web encontrados

---

### Paso 4: Enumeración de Servicios

#### Tarea 4.1: Enumeración SMB

**Tu tarea**: Enumerar recursos SMB

**Comando parcial:**
```bash
enum4linux ___
```

**Pista**: El objetivo es `192.168.56.5`

**Resultado esperado**: Información de recursos compartidos

---

#### Tarea 4.2: Enumeración SNMP

**Tu tarea**: Consultar información SNMP

**Comando parcial:**
```bash
snmpwalk -c ___ -v2c ___
```

**Pista**: 
- La comunidad por defecto es `public`
- El objetivo es `192.168.56.5`

**Resultado esperado**: Información del dispositivo

---

#### Tarea 4.3: FTP Anónimo

**Tu tarea**: Probar acceso FTP anónimo

**Comando parcial:**
```bash
ftp ___
```

**Pista**: El objetivo es `192.168.56.5`

**Credenciales a probar:**
- Usuario: `anonymous`
- Contraseña: `anonymous` o email

**Resultado esperado**: Acceso exitoso o rechazado

---

#### Tarea 4.4: SSH

**Tu tarea**: Verificar acceso SSH

**Comando parcial:**
```bash
ssh -v ___
```

**Pista**: El objetivo es `192.168.56.5`

**Resultado esperado**: Información de versión SSH

---

### Paso 5: Análisis de Resultados

**Tu tarea**: Crear un resumen de hallazgos

**Comando parcial:**
```bash
cat > ___ << EOF
=== RECONOCIMIENTO DE RED ===
Objetivo: 192.168.56.5
Fecha: $(date)

=== PUERTOS ABIERTOS ===
$(grep "^[0-9]*\/open" ___)

=== SERVICIOS VULNERABLES ===
[Listar hallazgos]

=== RECOMENDACIONES ===
1.
2.
3.
EOF
```

**Pista**: 
- El archivo de salida es `reconocimiento_resumen.txt`
- El archivo de entrada es `scan_full.txt`

**Resultado esperado**: Archivo de resumen estructurado

---

## Ejercicios Independientes

**Sin ayuda, completa estos desafíos:**

1. Encuentra 3 subdominios de `example.com` usando diferentes herramientas
2. Escanea tu propia máquina (localhost) con nmap y documenta los puertos abiertos
3. Busca información OSINT de una empresa de tu ciudad usando Google Dorks

---

## Verificación

**Checklist para confirmar que completaste el lab:**

- [ ] WHOIS devolvió información del dominio
- [ ] DNS enumeró nameservers y mailservers
- [ ] Encontraste al menos 1 subdominio con subfinder
- [ ] Escaneo completo guardado en `scan_full.txt`
- [ ] Identificaste al menos 1 vulnerabilidad con nmap --script vuln
- [ ] WhatWeb identificó tecnologías del sitio web
- [ ] ffuf encontró al menos 1 directorio
- [ ] Creaste el archivo `reconocimiento_resumen.txt`

---

## Troubleshooting

### Problema: "command not found"

**Solución**: Instala la herramienta faltante
```bash
sudo apt update && sudo apt install ___
```

### Problema: "No route to host"

**Solución**: Verifica que el objetivo esté en la misma red o accesible

### Problema: "Timeout" en escaneos

**Solución**: Aumenta el timeout con `--max-rtt-timeout`

---

## Entregable

**Archivo**: `reconnaissance_report.md`

Incluir:
- Información de dominio (WHOIS, DNS)
- Subdominios encontrados
- Puertos abiertos con servicios
- Tecnologías identificadas
- Hallazgos de seguridad iniciales
- Recomendaciones para siguiente fase

---

## Recursos

- [Nmap Documentation](https://nmap.org/book/man.html)
- [OSINT Framework](https://osintframework.com/)
- [TryHackMe: Reconnaissance](https://tryhackme.com/room/reconlearn)
