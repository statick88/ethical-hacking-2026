# Quiz Unidad 7: Ciberseguridad Industrial (OT/ICS)

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Qué significa la sigla SCADA?

a) Secure Control and Data Architecture
b) Supervisory Control and Data Acquisition
c) System Control and Data Analysis
d) Standard Control and Data Access

**Respuesta correcta**: b
**Explicación**: SCADA (Supervisory Control and Data Acquisition) son sistemas usados para monitorizar y controlar infraestructuras industriales como plantas eléctricas, redes de agua y oleoductos.

---

### Pregunta 2 (Básica)

¿Qué es un PLC?

a) Private LAN Controller
b) Protocol Layer Component
c) Programmable Logic Controller
d) Process Logic Computer

**Respuesta correcta**: c
**Explicación**: Un PLC (Programmable Logic Controller) es un dispositivo industrial de computación especializado que controla procesos físicos como motores, válvulas y sensores en entornos industriales.

---

### Pregunta 3 (Básica)

¿Qué protocolo industrial utiliza por defecto el puerto TCP 502?

a) DNP3
b) EtherNet/IP
c) Modbus TCP
d) PROFINET

**Respuesta correcta**: c
**Explicación**: Modbus TCP opera sobre el puerto 502 y es uno de los protocolos de comunicación industrial más antiguos y ampliamente usados, originalmente diseñado sin mecanismos de autenticación o cifrado.

---

### Pregunta 4 (Intermedia)

¿Cuál es la principal diferencia entre seguridad IT y seguridad OT?

a) OT usa protocolos más modernos y seguros
b) En OT, la disponibilidad y seguridad física tienen prioridad sobre la confidencialidad
c) IT tiene más restricciones regulatorias que OT
d) No hay diferencias significativas en los enfoques de seguridad

**Respuesta correcta**: b
**Explicación**: En entornos OT, la disponibilidad y la seguridad física (safety) son críticas; un fallo puede causar daños físicos o pérdidas de vidas. Esto invierte la tríada CIA respecto a IT, donde la confidencialidad suele ser la prioridad principal.

---

### Pregunta 5 (Intermedia)

¿En el Modelo de Purdue (Purdue Reference Model), cuál es el nivel más bajo de la jerarquía?

a) Nivel 1 - Control básico
b) Nivel 0 - Proceso físico
c) Nivel 2 - Supervisión
d) Nivel 3 - Operaciones de sitio

**Respuesta correcta**: b
**Explicación**: El Nivel 0 del Modelo Purdue representa el proceso físico en sí (sensores, actuadores, maquinaria), siendo la capa más cercana al entorno industrial real.

---

### Pregunta 6 (Intermedia)

¿Qué protocolo usa Siemens para la comunicación con sus PLCs de la serie S7?

a) Modbus
b) DNP3
c) S7comm
d) EtherNet/IP

**Respuesta correcta**: c
**Explicación**: S7comm es un protocolo propietario de Siemens usado para comunicarse con sus PLCs de la familia S7 (S7-300, S7-400, S7-1200, S7-1500). Fue uno de los protocolos objetivo en el ataque Stuxnet.

---

### Pregunta 7 (Intermedia)

¿Cuál fue el primer ciberataque conocido que causó daño físico a infraestructura industrial crítica?

a) NotPetya
b) BlackEnergy
c) Stuxnet
d) Triton/TRISIS

**Respuesta correcta**: c
**Explicación**: Stuxnet (descubierto en 2010) fue el primer malware conocido diseñado para causar daño físico real, dirigido a las centrifugadoras del programa nuclear iraní mediante la manipulación de PLCs Siemens S7.

---

### Pregunta 8 (Avanzada)

¿Qué herramienta se utiliza específicamente para fuzzing de protocolos industriales como Modbus y DNP3?

a) Nmap
b) Boofuzz
c) Metasploit básico
d) Burp Suite

**Respuesta correcta**: b
**Explicación**: Boofuzz es un framework de fuzzing de red que soporta protocolos industriales y permite realizar pruebas de robustez enviando datos malformados a dispositivos como PLCs y RTUs.

---

### Pregunta 9 (Avanzada)

¿Qué estándar del NIST se enfoca específicamente en la seguridad de Sistemas de Control Industrial (ICS)?

a) NIST SP 800-53
b) NIST SP 800-115
c) NIST SP 800-82
d) NIST CSF 2.0

**Respuesta correcta**: c
**Explicación**: NIST SP 800-82 "Guide to Industrial Control Systems (ICS) Security" proporciona orientación específica para proteger SCADA, DCS y otros sistemas de control industrial.

---

### Pregunta 10 (Avanzada)

¿Qué es un ataque de "air gap jumping"?

a) Atacar sistemas a través de Internet
b) Técnicas para comprometer sistemas aislados de redes convencionales usando canales físicos o electromagnéticos
c) Un tipo de ataque de denegación de servicio
d) Saltar de una VLAN a otra

**Respuesta correcta**: b
**Explicación**: Los ataques de air gap jumping utilizan canales no convencionales como USB infectados (Stuxnet), emisiones electromagnéticas, acústicas, de temperatura o de luz para exfiltrar datos o comprometer sistemas físicamente aislados de cualquier red.

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Una empresa del sector energético te contrata para evaluar la seguridad de su planta. Durante el reconocimiento, descubres con Shodan dispositivos industriales expuestos a Internet respondiendo en el puerto 502. Al conectarte, el dispositivo acepta comandos Modbus sin ningún tipo de autenticación y permite leer y escribir registros que controlan válvulas críticas.

**Preguntas de análisis**:

1. ¿Qué riesgos específicos representa esta exposición y cómo los clasificarías según impacto?
2. ¿Cómo presentarías este hallazgo al cliente sin comprometer los sistemas de producción durante el pentest?
3. ¿Qué controles recomendarías para remediar esta exposición siguiendo el Modelo de Purdue?

**Respuesta esperada**: El estudiante debe identificar: riesgo crítico de disponibilidad y safety (no solo confidencialidad), la posibilidad de manipulación de procesos físicos. Para el reporte: documentar el hallazgo sin ejecutar comandos de escritura en producción (solo lectura para evidenciar), coordinar con el cliente antes de cualquier prueba activa. Para remediación: eliminar exposición directa a Internet, segmentar según Purdue, implementar Firewall industrial/DMZ OT, considerar protocolo con autenticación (DNP3 SAv5 o IPsec).

**Criterios**: El estudiante debe mostrar comprensión del contexto OT donde las pruebas activas pueden tener consecuencias físicas graves, y adaptar su metodología en consecuencia.

---

### Escenario 2

**Situación**: Durante un ejercicio de red team contra una planta de tratamiento de agua, logras acceso a la red corporativa IT. Descubres que existe conexión entre la red IT y la red OT a través de un servidor SCADA que tiene dos interfaces de red. El sistema usa Windows Server 2008 R2 sin parches y tiene una HMI (Human-Machine Interface) accesible.

**Preguntas de análisis**:

1. ¿Cómo pivotarías desde la red IT hacia la red OT de forma controlada?
2. ¿Qué consideraciones éticas y de safety debes tener antes de intentar cualquier acción sobre la HMI?
3. ¿Qué recomendarías para eliminar este punto de cruce IT/OT o hacerlo más seguro?

**Respuesta esperada**: Para el pivoting: el servidor SCADA con doble interfaz es el pivote natural; usar técnicas de port forwarding o proxy SOCKS. Para consideraciones éticas: en plantas de agua/energía NUNCA ejecutar acciones que puedan afectar el proceso físico; toda acción sobre HMI debe acordarse previamente con el cliente y tener un plan de rollback; idealmente realizar el ejercicio sobre un entorno de staging o con ingenieros del cliente supervisando. Para remediación: implementar DMZ industrial con firewall entre IT y OT, usar unidirectional security gateways (data diodes), actualizar el servidor SCADA.

**Criterios**: El estudiante debe demostrar conciencia de que en OT el principio "primum non nocere" (primero, no dañar) es fundamental, y que los ejercicios de seguridad industrial requieren coordinación más estrecha con el cliente que en IT.
