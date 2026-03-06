# Delta Spec: Laboratorios Recomendados

## Purpose

Esta especificación define los laboratorios prácticos y plataformas que DEBEN estar integrados en el programa, enfocándose en plataformas CTF gratuitas y laboratorios técnicos.

## ADDED Requirements

### Requirement: Integración de Plataformas CTF Gratuitas

El programa DEBE incluir al menos 3 plataformas CTF reconocidas internacionalmente.

#### Scenario: TryHackMe como plataforma principal

- GIVEN El programa de capacitación
- WHEN Se planifica el aprendizaje práctico
- THEN TryHackMe (Free Tier) DEBE ser plataforma principal
- AND Se DEBEN seleccionar rutas de aprendizaje (learning paths) específicas
- AND Los módulos DEBEN mapear a la progresión de los 8 módulos
- AND Se DEBEN documentar ejercicios específicos para cada módulo

#### Scenario: Rutas de aprendizaje en TryHackMe

- GIVEN Un estudiante en el módulo 3 (Explotación Web)
- WHEN Busca laboratorios prácticos
- THEN DEBE haber una lista de laboratorios TryHackMe recomendados
- AND Los laboratorios DEBEN progresionar de fácil a difícil
- AND Se DEBE incluir estimado de tiempo por laboratorio
- AND Se DEBEN documentar conceptos cubiertos por cada laboratorio

#### Scenario: Hack The Box como plataforma avanzada

- GIVEN Un estudiante avanzado en módulo 5-7
- WHEN Busca desafíos más complejos
- THEN Hack The Box (Free Tier) DEBE ser accesible
- AND Se DEBEN proporcionar "write-ups" o hints para máquinas específicas
- AND Se DEBE documentar dificultad de cada máquina
- AND Se DEBEN sugerir máquinas alineadas con módulos

#### Scenario: OverTheWire para desafíos tipo wargame

- GIVEN Un estudiante que quiere desafíos puntuales
- WHEN Busca ejercicios de seguridad específicos
- THEN OverTheWire DEBE estar recomendado como alternativa
- AND Se DEBE documentar qué "Bandit", "Natas", "Leviathan" cubren
- AND Los desafíos DEBEN ser recomendados para módulos específicos

### Requirement: Laboratorios Locales con Docker

El programa DEBE incluir laboratorios que puedan ejecutarse localmente con Docker.

#### Scenario: Docker Compose para ambientes de laboratorio

- GIVEN Un estudiante que quiere practicar offline
- WHEN Necesita un ambiente aislado
- THEN Se DEBEN proporcionar docker-compose.yml para laboratorios
- AND Cada laboratorio DEBE ser reproducible en cualquier máquina
- AND Se DEBEN documentar vulnerabilidades intencionadas en cada container

#### Scenario: Laboratorio vulnerable para Módulo 3 (Web)

- GIVEN El módulo de explotación web
- WHEN Se prepara práctica local
- THEN Se DEBE incluir DVWA (Damn Vulnerable Web Application) en Docker
- AND Se DEBEN proporcionar ejercicios específicos en DVWA
- AND Se DEBE documentar cada vulnerabilidad a explotar
- AND Se DEBEN incluir soluciones paso a paso

#### Scenario: Laboratorio vulnerable para Módulo 4 (AD)

- GIVEN El módulo de Active Directory
- WHEN Se práctica hacking de identidad
- THEN Se DEBE incluir ambiente AD vulnerable en Docker
- AND Alternativa: Máquina virtual con Windows Server (Vulnerable-AD project)
- AND Se DEBEN proporcionar escenarios de ataque realistas
- AND Se DEBE documentar path completo de ataque

#### Scenario: Laboratorio vulnerable para Módulo 6 (Evasión)

- GIVEN El módulo de evasión de defensas
- WHEN Se práctica bypass de defensas
- THEN Se DEBE incluir ambiente con Firewall, WAF, EDR simulados
- AND Se DEBEN proporcionar ejercicios progresivos
- AND Se DEBEN documentar técnicas de detección vs evasión

### Requirement: Laboratorios de Ciberseguridad Industrial

El programa DEBE incluir ambiente simulado para OT/IT.

#### Scenario: Simulador de sistemas industriales

- GIVEN El módulo 7 (Ciberseguridad Industrial)
- WHEN Se práctica pentesting de ICS
- THEN Se DEBE incluir simulador de SCADA (industrial-cyber-security)
- AND Se DEBEN proporcionar máquinas con Modbus, Profibus configurados
- AND Se DEBEN documentar ataques específicos en ICS
- AND Se DEBEN incluir PLCs virtuales para testing

### Requirement: Laboratorios de IA y Prompt Injection

El programa DEBE incluir laboratorios para seguridad de LLMs.

#### Scenario: Entorno de prueba de Prompt Injection

- GIVEN El módulo 2 (Vulnerabilidades en IA)
- WHEN Se práctica prompt injection
- THEN Se DEBEN proporcionar accesos a LLMs gratuitos (ChatGPT Free, Claude Free, Gemini Free)
- AND Se DEBEN documentar técnicas de jailbreaking éticas y legales
- AND Se DEBEN incluir sandbox locales con LLMs open source (Ollama, LlamaCPP)
- AND Se DEBE documentar detection de prompt injection

### Requirement: Mapeo de Laboratorios a Módulos

Cada módulo DEBE tener list clara de laboratorios recomendados.

#### Scenario: Tabla de laboratorios por módulo

- GIVEN Un módulo completado
- WHEN Se buscan prácticas
- THEN DEBE haber tabla que mapee:
  - Plataforma (TryHackMe/HTB/OTW/Docker)
  - Nombre del laboratorio
  - Dificultad (Fácil/Medio/Difícil)
  - Tiempo estimado
  - Conceptos cubiertos
  - Herramientas utilizadas

### Requirement: Laboratorios Progresivos

Los laboratorios DEBEN progresionar en dificultad dentro de cada módulo.

#### Scenario: Progresión de laboratorios en Módulo 3

- GIVEN El módulo de explotación web
- WHEN Se selecciona laboratorio
- THEN Primer laboratorio DEBE cubrir conceptos básicos (SQL Injection simple)
- AND Segundo laboratorio DEBE agregar complejidad (SSTI, XXE)
- AND Tercer laboratorio DEBE ser integración (exploits encadenados)
- AND Cuarto laboratorio DEBE ser desafío sin guía

### Requirement: Estimaciones de Tiempo

Cada laboratorio DEBE tener estimado de tiempo realista.

#### Scenario: Documentación de tiempo

- GIVEN Un laboratorio recomendado
- WHEN Un estudiante lo empieza
- THEN DEBE haber estimado de tiempo: "30 minutos - 2 horas"
- AND Se DEBE documentar si es "guided" o "challenge" (sin instrucciones)
- AND Se DEBE indicar prerequisitos

### Requirement: Soluciones y Write-ups

Se DEBEN proporcionar soluciones para laboratorios.

#### Scenario: Disponibilidad de soluciones

- GIVEN Un laboratorio completado sin éxito
- WHEN Un estudiante busca ayuda
- THEN DEBE haber acceso a solución o hint
- AND Write-ups DEBEN estar en formato paso-a-paso
- AND Se DEBEN explicar conceptos detrás de cada paso
- AND Se DEBEN incluir alternativas de solución (si existen)

## MODIFIED Requirements

### Requirement: Acceso Gratuito Verificado

Todos los laboratorios recomendados DEBEN tener acceso gratuito verificado.

#### Scenario: Auditoría de acceso

- GIVEN La lista de laboratorios
- WHEN Se publica el informe
- THEN TODOS deben ser accesibles sin pago
- AND Se DEBEN documentar cambios en pricing (si aplica)
- AND Se DEBEN incluir fechas de verificación

## Bibliography Format

- Enlaces verificados a plataformas
- URLs a laboratorios específicos (si son linkables)
- Documentación oficial de plataformas
- Community write-ups citados apropiadamente
- Versiones de laboratorios pinned cuando sea posible

## Considerations

- **Rotación de laboratorios**: HTB y THM actualizan frecuentemente
- **Prerequisitos técnicos**: Algunos laboratorios requieren conexión rápida
- **Soporte comunitario**: La comunidad es fuente de ayuda principal
- **Validación de soluciones**: Las write-ups pueden tener errores o deprecated
- **Ética**: Se debe asumir uso educativo responsable de todos los laboratorios
- **Carga de trabajo**: 150 horas requiere selección cuidadosa de laboratorios clave
