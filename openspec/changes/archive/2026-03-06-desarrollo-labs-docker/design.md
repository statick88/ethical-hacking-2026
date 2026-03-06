# Design: Arquitectura de Laboratorios Docker para Ethical Hacking

## Overview

Los laboratorios dockerizados se estructuran en un directorio principal `docker-labs/` con subcarpetas para cada laboratorio. Cada lab incluye:

- `docker-compose.yml`: Definición de servicios
- `README.md`: Instrucciones detalladas para el estudiante
- `Dockerfile` (opcional): Configuraciones custom
- `config/` (opcional): Archivos de configuración
- `scripts/` (opcional): Scripts de apoyo

## Architecture Diagram

```
docker-labs/
├── lab1/              # Reconnaissance and Enumeration
│   ├── docker-compose.yml
│   ├── README.md
│   └── config/
├── lab3/              # Web Security (OWASP WebGoat)
│   ├── docker-compose.yml
│   └── README.md
├── lab4/              # Active Directory (BloodHound)
│   ├── docker-compose.yml
│   ├── README.md
│   └── Dockerfile
├── lab5/              # Automated Pentesting
│   ├── docker-compose.yml
│   └── README.md
├── lab6/              # Undetectable Payloads
│   ├── docker-compose.yml
│   └── README.md
├── lab7/              # OT Security (OpenPLC)
│   ├── docker-compose.yml
│   ├── README.md
│   └── config/
└── lab8/              # Final Project
    ├── docker-compose.yml
    └── README.md
```

## Network Architecture

Todos los laboratorios usan redes Docker bridge personalizadas para aislar el tráfico:

```
172.18.0.0/16 - Red principal
├── lab1: 172.18.1.0/24
│   ├── kali: 172.18.1.10
│   └── metasploitable2: 172.18.1.20
├── lab3: 172.18.3.0/24
│   └── webgoat: 172.18.3.10
├── lab4: 172.18.4.0/24
│   ├── kali: 172.18.4.10
│   ├── dc01: 172.18.4.20
│   └── bloodhound: 172.18.4.30
├── lab5: 172.18.5.0/24
│   ├── kali: 172.18.5.10
│   └── target: 172.18.5.20
├── lab6: 172.18.6.0/24
│   └── kali: 172.18.6.10
├── lab7: 172.18.7.0/24
│   ├── kali: 172.18.7.10
│   └── openplc: 172.18.7.20
└── lab8: 172.18.8.0/24
    ├── kali: 172.18.8.10
    ├── web: 172.18.8.20
    ├── db: 172.18.8.30
    └── api: 172.18.8.40
```

## Services

### Base Images

- **Kali Linux**: `kalilinux/kali-rolling` con herramientas preinstaladas
- **Metasploitable 2**: `tutum/metasploitable:latest`
- **WebGoat**: `webgoat/webgoat-8.0`
- **BloodHound**: `bloodhoundcommunityedition/bloodhound:latest`
- **OpenPLC**: `openplcproject/openplc:v3`
- **Active Directory**: `debdutdeb/win2019-ad`

### Resource Limits

Cada servicio tiene límites de recursos para evitar sobrecarga:

```yaml
deploy:
  resources:
    limits:
      memory: 2G
    reservations:
      memory: 1G
```

## Volume Management

Uso de volúmenes Docker para persistencia de datos:

```yaml
volumes:
  data:
    driver: local
  logs:
    driver: local
```

## Security Considerations

- **Contenedores Privileged**: Algunos labs (Lab 4 - AD, Lab 7 - OT) necesitan permisos especiales
- **Port Mapping**: Los puertos se mapean a puertos locales específicos por lab
- **Network Isolation**: Redes bridge separadas para cada laboratorio
- **Cleanup**: Scripts para eliminar contenedores y volúmenes

## Implementation Steps

1. Crear estructura de carpetas
2. Escribir docker-compose.yml por lab
3. Escribir README.md detallado
4. Probar cada lab en diferentes sistemas
5. Optimizar imágenes y recursos
6. Documentar troubleshooting
