# Lab 1: Reconocimiento y Enumeración

## Objetivo

Realizar un reconocimiento completo de un objetivo simulado utilizando herramientas de OSINT y escaneo de red. El estudiante aplicará técnicas de reconocimiento pasivo y activo.

## Prerrequisitos

- Máquina Kali Linux (VMware/VirtualBox)
- Conexión a internet para acceder a recursos online
- Docker instalado para levantar servicios vulnerables

## Entorno

- **Atacante**: Kali Linux (192.168.56.10)
- **Objetivo**: Máquina vulnerable en red local o TryHackMe

## Escenario

Eres un pentester contratado por una empresa mediana para realizar la fase de reconocimiento de un pentest. Tu objetivo es obtener la máxima información posible sobre el objetivo sin interactuar directamente con sus sistemas de producción.

## Pasos

### Paso 1: Reconocimiento Pasivo con OSINT

**Objetivo**: Recolectar información sin tocar el objetivo.

```bash
# 1. Buscar información del dominio con WHOIS
whois empresa-ejemplo.com

# 2. Enumeración DNS con dig
dig NS empresa-ejemplo.com
dig MX empresa-ejemplo.com

# 3. Google Dorks para información expuesta
# Buscar archivos sensibles
site:empresa-ejemplo.com filetype:pdf
site:empresa-ejemplo.com filetype:xls | xlsx
site:empresa-ejemplo.com "password"
site:empresa-ejemplo.com "username"

# 4. Buscar subdominios
subfinder -d empresa-ejemplo.com
amass enum -d empresa-ejemplo.com

# 5. Buscar emails con theHarvester
theHarvester -d empresa-ejemplo.com -b all
```

**Output esperado**: Lista de subdominios, emails, servicios expuestos.

### Paso 2: Escaneo de Red con Nmap

**Objetivo**: Identificar puertos abiertos y servicios.

```bash
# 1. Escaneo TCP SYN rápido
nmap -sS -F 192.168.56.0/24

# 2. Escaneo completo con detección de servicios
nmap -sS -sV -sC -p- 192.168.56.5 -oN scan_full.txt

# 3. Escaneo UDP
nmap -sU -p 53,161,123 192.168.56.5

# 4. Detección de sistema operativo
nmap -O 192.168.56.5

# 5. Scripts de vulnerabilidad
nmap --script vuln 192.168.56.5
```

**Output esperado**: Lista de puertos abiertos, versiones de servicios, SO detectado.

### Paso 3: Enumeración Web

**Objetivo**: Identificar tecnologías y vulnerabilidades web.

```bash
# 1. WhatWeb - tecnología web
whatweb -a 3 http://192.168.56.5

# 2. nikto - escaneo web
nikto -h http://192.168.56.5

# 3. Directorios con ffuf
ffuf -u http://192.168.56.5/FUZZ -w /usr/share/wordlists/dirb/common.txt

# 4. Subdominios web
gobuster dns -d empresa-ejemplo.com -w /usr/share/wordlists/subdomains.txt
```

### Paso 4: Enumeración de Servicios

```bash
# 1. Enumeración SMB
enum4linux 192.168.56.5

# 2. Enumeración SNMP
snmpwalk -c public -v2c 192.168.56.5

# 3. FTP anónimo
ftp 192.168.56.5
# Probar: anonymous/anonymous

# 4. SSH
ssh -v 192.168.56.5
```

### Paso 5: Análisis de Resultados

```bash
# Crear resumen de hallazgos
cat > reconocimiento_resumen.txt << EOF
=== RECONOCIMIENTO DE RED ===
Objetivo: 192.168.56.5
Fecha: $(date)

=== PUERTOS ABIERTOS ===
$(grep "^[0-9]*\/open" scan_full.txt)

=== SERVICIOS VULNERABLES ===
[Listar hallazgos]

=== RECOMENDACIONES ===
1.
2.
3.
EOF
```

## Resultado Esperado

El estudiante debe entregar:
1. Lista de información OSINT recolectada
2. Mapa de puertos y servicios
3. Tecnologías web identificadas
4. Potenciales vectores de ataque documentados

## Entregable

**Archivo**: `reconnaissance_report.md`

Incluir:
- Información de dominio (WHOIS, DNS)
- Subdominios encontrados
- Puertos abiertos con servicios
- Tecnologías identificadas
- Hallazgos de seguridad iniciales
- Recomendaciones para siguiente fase

## Recursos

- [Nmap Documentation](https://nmap.org/book/man.html)
- [OSINT Framework](https://osintframework.com/)
- [TryHackMe: Reconnaissance](https://tryhackme.com/room/reconlearn)
