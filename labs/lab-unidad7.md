# Lab 7: Hardening y Pentesting de Sistemas OT

## Objetivo

Realizar hardening de un sistema Linux industrial simulado y verificar su seguridad.

## Prerrequisitos

- Docker
- Acceso a internet para descargar herramientas

## Entorno

```bash
# Instalar OpenPLC (simulador PLC)
docker run -d -p 8080:8080 -p 502:502 --name openplc openplc/plc

# Instalar OpenClaw
git clone https://github.com/OTRF/OpenClaw
cd OpenClaw && pip install -r requirements.txt
```

## Escenario

Un cliente del sector industrial solicita un hardening de sus sistemas Linux industriales. Debes aplicar las mejores prácticas y verificar.

## Pasos

### Paso 1: Análisis Inicial

```bash
# Escanear puertos del PLC
nmap -sS -p 502 192.168.56.5

# Identificar servicios
nmap -sV -p 502 192.168.56.5
```

### Paso 2: Hardening con OpenClaw

```bash
# Ejecutar hardening
python openclaw.py --target 192.168.56.5 --report hardening_report.html

# Revisar recomendaciones
cat hardening_report.html
```

### Paso 3: Pentesting con Pentagi

```bash
# Instalar Pentagi
docker build -t pentagi .
docker run -d -p 5000:5000 pentagi

# Ejecutar escaneo
# Acceder a http://localhost:5000
```

### Paso 4: Verificación Post-Hardening

```bash
# Comparar resultados antes/después
nmap -sS -p 502 192.168.56.5
```

## Entregable

**Archivo**: `ot_security_report.md`

Incluir:
- Estado inicial
- Medidas de hardening aplicadas
- Resultados de pentest
- Comparativa antes/después
- Recomendaciones finales

## Resultado Esperado

Al completar el lab, el estudiante debe demostrar comprensión de la superficie de ataque OT y las medidas de mitigación:

1. **Modbus expuesto identificado**: Output de `nmap -sS -p 502 192.168.56.5` mostrando `502/tcp open  modbus` antes del hardening.
2. **Lectura de registros Modbus**: Uso de `modbus-cli` o script Python con `pymodbus` que lea al menos un registro del PLC simulado, mostrando el valor leído (ej. `Coil 0: True`).
3. **Hardening aplicado**: Captura del reporte HTML de OpenClaw mostrando el estado inicial vs. final con al menos 5 controles mejorados (ej. firewall, autenticación, cifrado de tráfico).
4. **Comparativa de superficie de ataque**: Dos outputs de Nmap (antes y después) mostrando reducción de puertos expuestos o servicios endurecidos.

**Flag de completitud**: El puerto 502 (Modbus) debe estar filtrado o con autenticación configurada en el escaneo post-hardening, documentado en el reporte final.

## Recursos

- [OpenPLC Runtime Documentation](https://autonomylogic.com/docs/)
- [ICS-CERT Advisories (CISA)](https://www.cisa.gov/ics-advisories)
- [NIST SP 800-82: Guide to ICS Security](https://csrc.nist.gov/publications/detail/sp/800-82/rev-3/final)
- [MITRE ATT&CK for ICS](https://attack.mitre.org/matrices/ics/)
- [pyModbus Documentation](https://pymodbus.readthedocs.io/)
- [SANS ICS Security Resources](https://www.sans.org/industrial-control-systems-security/)
