---
title: Laboratorios OWASP Clásicos
---

# Laboratorios OWASP Clásicos

Este minicurso proporciona laboratorios Docker con aplicaciones web vulnerables reconocidos internacionalmente para practicar técnicas de penetration testing en un entorno seguro y controlado.

## Descripción

Los tres laboratorios incluidos son aplicaciones web vulnerables diseñadas específicamente para el aprendizaje de seguridad ofensiva:

- **WebGoat**: Plataforma de entrenamiento de OWASP con lecciones interactivas
- **DVWA (Damn Vulnerable Web Application)**: Aplicación web con vulnerabilidades deliberadas
- **OWASP Juice Shop**: tienda online vulnerable para practicar hacking ético

## Requisitos Previos

Antes de comenzar, asegúrate de tener:

- Docker Engine 24.0 o superior instalado
- Conexión a internet para descargar imágenes Docker
- Puertos disponibles: 8080, 3000

### Verificar Instalación de Docker

```bash
docker --version
docker-compose --version
```

## Labs Incluidos

| Lab | Descripción | Puerto |
|-----|-------------|--------|
| [Lab 1: WebGoat](webgoat.md) | Plataforma de aprendizaje de OWASP | 8080 |
| [Lab 2: DVWA](dvwa.md) | Aplicación web vulnerable | 80 |
| [Lab 3: Juice Shop](juice-shop.md) | Tienda online vulnerable | 3000 |

## Advertencia de Seguridad

> **IMPORTANTE**: Estos laboratorios CONTIENEN VULNERABILIDADES DELIBERADAS. 
> 
> - NO ejecutar en entornos de producción
> - NO exponer a redes públicas
> - Usar únicamente en redes privadas de laboratorio
> - Cambiar credenciales por defecto si se accede desde exterior

## Estructura de cada Lab

Cada laboratorio incluye:

1. Descripción de la herramienta
2. Vulnerabilidades que contiene
3. Credenciales por defecto
4. Instrucciones de instalación (Docker y Docker Compose)
5. Pasos de verificación
6. Ejercicios básicos de práctica

## Próximos Pasos

Comenzar con cualquier laboratorio:

- [Comenzar con WebGoat](webgoat.md)
- [Comenzar con DVWA](dvwa.md)
- [Comenzar con Juice Shop](juice-shop.md)
