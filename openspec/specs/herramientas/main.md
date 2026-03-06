# Delta Spec: Herramientas y Plataformas Gratuitas

## Purpose

Esta especificación define los requisitos para las herramientas y plataformas que DEBEN utilizarse en el programa de modernización. Enfatiza el uso de opciones gratuitas/open source para maximizar la accesibilidad.

## ADDED Requirements

### Requirement: Suite de Herramientas Gratuitas de Pentesting

El programa DEBE incluir una suite completa de herramientas de pentesting que sean libres de costo.

#### Scenario: Selección de herramientas de reconocimiento

- GIVEN Un módulo que requiere reconocimiento
- WHEN Se selecciona herramienta de OSINT
- THEN DEBE incluir: Nmap (escaneo de puertos), Shodan/Censys (búsqueda), theHarvester (OSINT), Recon-ng (framework OSINT), Gobuster (enumeración web)
- AND Todas DEBEN ser gratuitas y open source

#### Scenario: Herramientas de explotación web

- GIVEN El módulo 3 (Explotación Web y APIs)
- WHEN Se configura el laboratorio
- THEN DEBE incluir: Burp Suite Community Edition, OWASP ZAP, Nikto, SQLMap
- AND Cada herramienta DEBE estar documentada con ejemplos
- AND Se DEBEN proporcionar alternativas para sistemas con recursos limitados

#### Scenario: Herramientas de Active Directory

- GIVEN El módulo 4 (Hacking de Identidad)
- WHEN Se prepara el laboratorio de AD
- THEN DEBE incluir: Bloodhound (visualización de rutas de ataque), Impacket (toolkit de ataque), Kerbrute (enumeración Kerberos), Responder (credential interception), Hashcat (offline cracking)
- AND TODOS deben ser open source

#### Scenario: Herramientas de automatización y red teaming

- GIVEN El módulo 5 (Pentesting Autónomo)
- WHEN Se configura la automatización
- THEN DEBE incluir: Metasploit Framework (exploit framework), Empire/Powershell Empire (C2), Cobalt Strike (alternativa open: Sliver), SharpHound (AD enumeration), PEAS/LinPEAS (privilege escalation)
- AND Las herramientas DEBEN permitir scripteo y automatización
- AND Se DEBEN proporcionar ejemplos de cadenas de automatización

#### Scenario: Herramientas de evasión y offuscación

- GIVEN El módulo 6 (Evasión de Defensas)
- WHEN Se enseña evasión de antivirus
- THEN DEBE incluir: Veil-Framework (ofuscación), msfvenom (generación de payloads), Mimikatz (credential dumping), ProGuard (obfuscación Java), YARA (detection rules)
- AND Se DEBEN proporcionar técnicas open source

#### Scenario: Herramientas de ciberseguridad industrial

- GIVEN El módulo 7 (Ciberseguridad Industrial)
- WHEN Se configura el ambiente OT/IT
- THEN DEBE incluir: OpenClaw (hardening de sistemas), Pentagi (pentesting automatizado), PLCSploit (exploit PLC), s7scan (escaneo SIEMENS), Modbus scanner (enumeración), Wireshark (análisis de protocolos industriales)
- AND Se DEBEN documentar conexiones con el mundo real industrial

#### Scenario: Herramientas de análisis y reporting

- GIVEN El módulo 8 (Reporte y Ética)
- WHEN Se crea un reporte de vulnerabilidades
- THEN DEBE incluir: Dradis (framework de colaboración), DefectDojo (gestión de vulnerabilidades), CvssCalculator (cálculo de severidad), Grype (scanning de dependencias), Trivy (scanning de contenedores)
- AND Las herramientas DEBEN facilitar reportes profesionales

### Requirement: Kali Linux como Base

El programa DEBE utilizar Kali Linux como distribución base para laboratorios.

#### Scenario: Inclusión de Kali Linux

- GIVEN El programa de capacitación
- WHEN Se configura el ambiente de laboratorio
- THEN Kali Linux DEBE ser la distribución base recomendada
- AND Se DEBE proporcionar guía de instalación
- AND Se DEBEN incluir instrucciones para ambientes virtualizados

### Requirement: Documentación de Instalación

Cada herramienta DEBE tener documentación clara de instalación.

#### Scenario: Guía de instalación por herramienta

- GIVEN Una herramienta recomendada
- WHEN Un estudiante la necesita instalar
- THEN DEBE haber instrucciones paso a paso
- AND Se DEBE documentar compatibilidad con Kali Linux, Ubuntu, Debian, macOS
- AND Se DEBEN incluir troubleshooting de problemas comunes

### Requirement: Alternativas para Recursos Limitados

El programa DEBE proporcionar alternativas para estudiantes con hardware limitado.

#### Scenario: Herramientas livianas

- GIVEN Un estudiante con recursos limitados
- WHEN Necesita un laboratorio completo
- THEN DEBE haber opciones "lightweight"
- AND Se DEBEN documentar equivalentes más ligeros
- AND Se DEBEN proporcionar ejemplos con máquinas virtuales minimales

### Requirement: Configuración Reproducible

Las configuraciones de herramientas DEBEN ser reproducibles en cualquier máquina.

#### Scenario: Docker para herramientas complejas

- GIVEN Una herramienta con múltiples dependencias
- WHEN Se necesita reproducibilidad
- THEN DEBE haber Dockerfile disponible
- AND Se DEBEN proporcionar docker-compose.yml para setups complejos
- AND Se DEBE documentar la versión de herramientas en containers

### Requirement: Versioning de Herramientas

El programa DEBE especificar versiones recomendadas para cada herramienta.

#### Scenario: Control de versiones

- GIVEN El año 2026
- WHEN Se recomiendan herramientas
- THEN Se DEBE especificar versión mínima recomendada
- AND Se DEBE documentar compatibilidad con versiones más nuevas
- AND Se DEBE proporcionar plan de actualización anual

## MODIFIED Requirements

### Requirement: Compatibilidad Multiplataforma

Las herramientas recomendadas DEBEN funcionar en Windows, macOS y Linux.

#### Scenario: Desarrollo multiplataforma

- GIVEN Un estudiante en cualquier OS
- WHEN Necesita completar un laboratorio
- THEN Las herramientas DEBEN estar disponibles en su plataforma
- AND Se DEBEN proporcionar alternativas si hay limitaciones
- AND Se DEBEN documentar diferencias de comportamiento entre plataformas

## Bibliography Format

- Enlaces a repositorios GitHub oficiales
- Enlaces a documentación oficial de proyectos
- Versiones pinned cuando sea crítico
- Licencias documentadas (GPL, MIT, BSD, etc.)
- Fechas de última actualización verificadas

## Considerations

- **Mantenimiento**: Las herramientas evolucionan rápidamente, requiere revisión semestral
- **Seguridad**: Algunos proyectos abandonados deben ser reemplazados
- **Costo**: Aunque gratuitas, requieren tiempo de configuración
- **Curva de aprendizaje**: Las herramientas complejas requieren tutorials adicionales
- **Ética**: Se debe asumir uso responsable y legal de todas las herramientas
