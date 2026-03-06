# Proposal: Desarrollo de Laboratorios Docker para Ethical Hacking 2026

## Intent

Los laboratorios actuales del curso (labs/lab-unidad{1-8}.md) dependen principalmente de máquinas virtuales (Kali Linux, Metasploitable) y plataformas online (TryHackMe, HackTheBox), lo que introduce complejidad en el setup y reproducebilidad. El objetivo de este cambio es **containerizar todos los laboratorios usando Docker Compose** para simplificar el deployment, garantizar consistencia y reducir los requisitos de hardware.

## Scope

### In Scope

- **Laboratorios Dockerizados**: Convertir 7 de los 8 laboratorios a Docker Compose (Lab 2 - LLM Security es web-based y no requiere Docker)
- **Infraestructura Unificada**: Crear una estructura de carpetas `docker-labs/` con subcarpetas por lab
- **Docker Compose Files**: Un archivo docker-compose.yml por laboratorio con servicios preconfigurados
- **Documentación Detallada**: README.md por lab con instrucciones de setup, ejecución y cleanup
- **Archivos Adicionales**: Dockerfiles, configuraciones custom y scripts de apoyo

### Out of Scope

- Modificar el contenido teórico de las unidades
- Modificar los quizzes o presentaciones
- Crear laboratorios para la Unidad 2 (LLM Security)
- Implementar infraestructura cloud (AWS, Azure, etc.)

## Approach

1. **Crear Estructura Base**: Directorio `docker-labs/` con subcarpetas para cada lab
2. **Containerizar Cada Lab**:
   - Lab 1: Metasploitable 2 + Kali Linux
   - Lab 3: OWASP WebGoat
   - Lab 4: BloodHound + Active Directory
   - Lab 5: AutoRecon + Metasploit
   - Lab 6: Kali Linux con herramientas de evasión
   - Lab 7: OpenPLC (OT/ICS)
   - Lab 8: Pentest Completo
3. **Documentar**: Escribir README.md detallado por cada lab
4. **Validar**: Probar cada lab para asegurar que funciona correctamente

## Affected Areas

| Área | Impact | Descripción |
|------|--------|-------------|
| `docker-labs/` | New | Directorio principal con todos los labs dockerizados |
| `docker-labs/lab1/` | New | Reconnaissance and Enumeration |
| `docker-labs/lab3/` | New | Web Security (OWASP WebGoat) |
| `docker-labs/lab4/` | New | Active Directory (BloodHound) |
| `docker-labs/lab5/` | New | Automated Pentesting |
| `docker-labs/lab6/` | New | Undetectable Payloads |
| `docker-labs/lab7/` | New | OT Security (OpenPLC) |
| `docker-labs/lab8/` | New | Final Project |
| `openspec/changes/desarrollo-labs-docker/` | New | Documentación SDD para el cambio |

## Risks

| Riesgo | Probabilidad | Mitigación |
|--------|-------------|------------|
| Contenedores con vulnerabilidades | Alta | Usar imágenes oficiales y mantenerlas actualizadas |
| Recursos de hardware insuficientes | Media | Optimizar imágenes Docker y limitar recursos |
| Redes Docker complejas | Media | Usar redes bridge personalizadas y documentar |
| Compatibilidad entre OS | Baja | Usar imágenes multi-arch (linux/amd64, linux/arm64) |

## Rollback Plan

- Los laboratorios originales (labs/lab-unidad{1-8}.md) permanecen intactos
- El directorio docker-labs/ es aditivo y se puede eliminar sin impacto
- Los estudiantes pueden seguir usando los labs originales si los Docker labs fallan

## Dependencies

- Docker Engine 24.0+
- Docker Compose 2.0+
- 8GB RAM mínimo (16GB recomendado)
- 20GB de almacenamiento disponible

## Success Criteria

- [ ] 7 labs dockerizados con docker-compose.yml
- [ ] README.md detallado por cada lab
- [ ] Docker Compose up ejecuta sin errores
- [ ] Laboratorios funcionales en Windows, macOS y Linux
- [ ] Documentación de troubleshooting y cleanup
