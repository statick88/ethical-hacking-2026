# Laboratorios - Ethical Hacking 2026

## Infraestructura

### Requisitos del Sistema

- **RAM:** Mínimo 8GB (16GB recomendado)
- **CPU:** 4 núcleos
- **Almacenamiento:** 100GB libres
- **Virtualización:** VirtualBox / VMware Fusion

### Software Base

- Docker Desktop
- Kali Linux 2024
- VirtualBox / VMware Fusion

---

## Entornos de Práctica

### Plataformas Online Gratuitas

| Plataforma | Tipo | URL |
|------------|------|-----|
| TryHackMe | Labs interactivos | tryhackme.com |
| Hack The Box | CTF y labs | hackthebox.eu |
| OverTheWire | Wargames | overthewire.org |
| PortSwigger Web Security Academy | Web Security | portswigger.net |

### Laboratorios Locales

- Docker containers
- Kali Linux VM
- Metasploitable
- OWASP WebGoat

---

## Docker

### Comandos Básicos

```bash
# Listar contenedores
docker ps -a

# Iniciar contenedor
docker start <nombre>

# Acceder a contenedor
docker exec -it <nombre> bash

# Ver logs
docker logs <nombre>
```

---

## Kali Linux

### Herramientas Preinstaladas

- Nmap
- Metasploit
- Burp Suite
- SQLmap
- John the Ripper
- Hydra
- Wireshark
- Nikto

---

## Configuración de Red

### Red NAT para Laboratorios

```
Adaptador: NAT
Puerto forwarded: 2222 -> 22
Rango IP: 192.168.56.0/24
```

### Aislamiento

- No conectar labs a red principal
- Usar VPN si es necesario
- Documentar IPs y accesos
