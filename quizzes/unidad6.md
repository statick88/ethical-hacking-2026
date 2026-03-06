# Quiz Unidad 6: Evasión de Defensas

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Qué es un LOLBin (Living off the Land Binary)?

a) Un binario malicioso descargado por el atacante
b) Un binario legítimo del sistema operativo usado con fines maliciosos
c) Un tipo de malware que vive en el disco
d) Una herramienta de pentesting open source

**Respuesta correcta**: b
**Explicación**: Los LOLBins son binarios legítimos preinstalados en el sistema operativo (como certutil.exe, mshta.exe, regsvr32.exe) que los atacantes aprovechan para ejecutar código malicioso evasivo sin necesidad de subir herramientas propias.

---

### Pregunta 2 (Básica)

¿Qué es AMSI (Antimalware Scan Interface)?

a) Un tipo de firewall de Windows
b) Una interfaz de Windows que permite a los antivirus escanear scripts en memoria
c) Un protocolo de comunicación segura
d) Una herramienta de análisis de malware

**Respuesta correcta**: b
**Explicación**: AMSI es una interfaz de Windows que permite a las soluciones de seguridad interceptar y analizar el contenido de scripts como PowerShell, VBScript y JScript antes de su ejecución, incluso si están ofuscados.

---

### Pregunta 3 (Básica)

¿Qué herramienta de Metasploit se usa para generar payloads con múltiples opciones de formato y encoder?

a) msfconsole
b) msfvenom
c) msfdb
d) msfrpc

**Respuesta correcta**: b
**Explicación**: msfvenom combina msfpayload y msfencode en una sola herramienta, permitiendo generar payloads en múltiples formatos y aplicar encoders para evadir detección.

---

### Pregunta 4 (Básica)

¿Cuál es el encoder más conocido de Metasploit para evadir firmas de antivirus?

a) xor_dynamic
b) shikata_ga_nai
c) base64_encode
d) alpha_mixed

**Respuesta correcta**: b
**Explicación**: Shikata_ga_nai es un encoder polimórfico de Metasploit que transforma el payload en cada generación, haciendo más difícil la detección basada en firmas estáticas.

---

### Pregunta 5 (Intermedia)

¿En qué consiste la técnica de "process hollowing"?

a) Eliminar un proceso de la memoria del sistema
b) Crear un proceso legítimo suspendido, vaciar su memoria y reemplazarla con código malicioso
c) Inyectar una DLL en un proceso activo
d) Modificar el token de acceso de un proceso

**Respuesta correcta**: b
**Explicación**: Process hollowing crea un proceso legítimo (como svchost.exe) en estado suspendido, vacía su sección de código y la reemplaza con código malicioso, haciendo que el malware se ejecute bajo la apariencia de un proceso legítimo.

---

### Pregunta 6 (Intermedia)

¿Qué es la "Reflective DLL Injection"?

a) Inyectar una DLL cargándola desde disco
b) Técnica que carga una DLL en la memoria de un proceso remoto sin escribir nada en disco
c) Modificar el directorio de importación de un ejecutable
d) Reemplazar una DLL del sistema por una maliciosa

**Respuesta correcta**: b
**Explicación**: La Reflective DLL Injection permite cargar una DLL directamente en la memoria de un proceso objetivo sin usar las APIs estándar de carga del sistema, evitando así dejar trazas en disco y en el registro de módulos del sistema.

---

### Pregunta 7 (Intermedia)

¿Qué es una "fileless" o ejecución "no-disk"?

a) Malware que borra sus archivos después de ejecutarse
b) Técnica donde el código malicioso se ejecuta completamente en memoria sin escribir archivos en disco
c) Un tipo de ataque que no usa el sistema de archivos del objetivo
d) Malware que se oculta en archivos del sistema

**Respuesta correcta**: b
**Explicación**: Los ataques fileless ejecutan código malicioso directamente en memoria (mediante PowerShell, WMI u otras técnicas), sin depositar ejecutables en disco, lo que dificulta enormemente su detección forense.

---

### Pregunta 8 (Intermedia)

¿Qué es el "timestomping" en el contexto de cubrirse las huellas (covering tracks)?

a) Sincronizar los relojes de los sistemas comprometidos
b) Modificar los timestamps de archivos para dificultar el análisis forense
c) Borrar los logs del sistema de eventos
d) Cambiar la zona horaria del sistema

**Respuesta correcta**: b
**Explicación**: El timestomping consiste en modificar los metadatos de tiempo (creación, modificación, acceso) de los archivos creados o modificados durante el ataque, haciendo que parezcan existir desde antes del período sospechoso.

---

### Pregunta 9 (Avanzada)

¿Cuál de las siguientes técnicas de bypass de AMSI en PowerShell es la más común?

a) Deshabilitar el servicio Windows Defender
b) Usar un script que sobrescribe la función AmsiScanBuffer en memoria
c) Ejecutar PowerShell con privilegios de SYSTEM
d) Compilar el script con Visual Studio

**Respuesta correcta**: b
**Explicación**: El bypass más común de AMSI consiste en parchear en memoria la función AmsiScanBuffer del proceso de PowerShell para que siempre devuelva AMSI_RESULT_CLEAN, deshabilitando efectivamente el escaneo sin modificar nada en disco.

---

### Pregunta 10 (Avanzada)

En el contexto de evasión de EDR (Endpoint Detection and Response), ¿qué son las "syscalls directas"?

a) Llamadas a funciones de la API de Windows
b) Técnica que invoca directamente las llamadas al sistema del kernel sin pasar por las DLLs hooked del usuario
c) Un tipo especial de shellcode
d) Comandos del sistema operativo ejecutados por CMD

**Respuesta correcta**: b
**Explicación**: Los EDR modernos hookean las DLLs de usuario (como ntdll.dll) para monitorizar llamadas a la API. Las syscalls directas evitan estos hooks invocando directamente las instrucciones de syscall del kernel, eludiendo así la telemetría del EDR.

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Estás realizando un red team contra una empresa que tiene Windows Defender habilitado con protección en tiempo real, AMSI activo y un EDR de terceros (CrowdStrike Falcon). Has generado un payload con msfvenom usando shikata_ga_nai, pero es detectado inmediatamente al ejecutarlo.

**Preguntas de análisis**:

1. ¿Por qué shikata_ga_nai no es suficiente frente a soluciones modernas de detección?
2. ¿Qué técnicas combinarías para lograr la ejecución del payload de forma evasiva?
3. ¿Qué LOLBin usarías para ejecutar el payload y por qué reduce la probabilidad de detección?

**Respuesta esperada**: El estudiante debe entender que los encoders estáticos como shikata_ga_nai son bien conocidos por las firmas de AV. La combinación debe incluir: bypass de AMSI, uso de payload fileless (PowerShell en memoria), uso de un LOLBin como certutil o mshta para la carga inicial, y posiblemente syscalls directas para evadir el EDR. El LOLBin reduce la detección porque el proceso iniciador es legítimo y conocido.

**Criterios**: El estudiante debe demostrar comprensión multicapa de las defensas y la necesidad de combinar técnicas, no depender de una sola.

---

### Escenario 2

**Situación**: Tras comprometer un servidor Windows 2019, necesitas mantener persistencia discreta y luego extraer las credenciales del sistema. El cliente ha desplegado auditoria de eventos avanzada (Windows Event Forwarding hacia un SIEM).

**Preguntas de análisis**:

1. ¿Qué mecanismo de persistencia usarías que tenga menor visibilidad en los logs de eventos de Windows?
2. ¿Cómo realizarías credential dumping evitando que Mimikatz sea detectado?
3. ¿Qué técnicas de "covering tracks" aplicarías sabiendo que los logs se envían a un SIEM remoto?

**Respuesta esperada**: Para persistencia: WMI subscriptions o COM hijacking tienen menor ruido que Run keys. Para credential dumping: usar técnicas in-memory sin soltar Mimikatz en disco, o usar LSASS dump indirecto con comsvcs.dll. Para cubrir huellas: como los logs van a un SIEM remoto, no tiene sentido limpiar los logs locales; en su lugar, el estudiante debe mencionar operar con herramientas con menor huella de eventos (LOLBins) y cuidar el timing de las acciones.

**Criterios**: El estudiante debe demostrar pensamiento adversarial realista y entender que cubrir huellas es más complejo cuando existe reenvío de logs centralizado.
