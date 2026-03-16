# 🛡️ Unidad 6: Evasión de Defensas - LAB PRÁCTICO

## 📋 Arquitectura
- **Victima (172.18.6.10)**: Ubuntu server protegido con ClamAV (Antivirus estático) y Auditd (Behavioral Monitoring).
- **Atacante (172.18.6.20)**: Kali con Go, PyArmor y UPX para crear payloads ofuscados.

## 🚀 Ejercicios Sugeridos

### 1. Evasión de Firmas (ClamAV)
1. Genera un payload estándar con `msfvenom` (Linux ELF).
2. Súbelo a la víctima y escanéalo: `clamscan payload.elf`.
3. **Reto:** Modifica el código fuente (o usa un packer como UPX) hasta que `clamscan` reporte "OK".

### 2. Evasión de Comportamiento (Auditd)
1. Ejecuta comandos ruidosos en la víctima (`cat /etc/shadow`).
2. Revisa los logs de Auditd (`/var/log/audit/audit.log`).
3. **Reto:** Usa técnicas de "Living off the Land" (ej. python oneliners) para leer archivos sin usar binarios monitoreados como `cat`.

### 3. Desarrollo de Malware Custom (Go)
1. Escribe un reverse shell simple en Go.
2. Compílalo y verifica si es detectado.
3. Ofusca el binario (strip symbols, garble) para evadir análisis estático.

## 🛑 Limpieza

### Opción 1: Usar scripts de automatización (Recomendado)

```bash
cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab6

# Iniciar el lab
./setup.sh

# Verificar estado
./check-lab.sh

# Resetear el lab (eliminar todo)
./reset.sh
```

### Opción 2: Manual con Docker Compose

`docker-compose down -v`
