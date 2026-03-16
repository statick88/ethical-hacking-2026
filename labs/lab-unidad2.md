---
title: "Lab 2: Prompt Injection y Jailbreaking en LLMs"
author: "Diego Saavedra"
---

# 🎯 Lab 2: Prompt Injection y Jailbreaking en LLMs

## ⏱️ Timeline de Verificación

| Paso | Descripción | Tiempo | Completado |
|------|-------------|--------|------------|
| 1 | Gandalf AI - Niveles 1-3 | 20 min | ⬜ |
| 2 | HackAPrompt - Niveles 1-5 | 25 min | ⬜ |
| 3 | Documentación de técnicas | 15 min | ⬜ |
| 4 | Análisis de defensas | 20 min | ⬜ |
| **Total** | | **80 min** | |

---

## 🎯 Objetivo

Ejecutar ataques de Prompt Injection y técnicas de Jailbreaking en modelos de lenguaje, documentando vectores de ataque y defensas **sin copiar técnicas**, sino desarrollando tu propio enfoque.

---

## ⚠️ Importante: No Copiar Técnicas

**REGLA ORO**: Desarrolla tus propias técnicas de inyección. No copies prompts de internet.

**Por qué**: La creatividad en ataques de IA es una habilidad valiosa que debes desarrollar.

---

## Prerrequisitos

- Acceso a internet
- Cuentas en plataformas de laboratorio de IA
- Navegador web con capacidad de captura de pantalla

## Entorno

- Navegador web
- Línea de comandos (terminal)
- Herramienta de captura de pantalla

## Escenario

Eres un researcher de seguridad evaluando la resistencia de LLMs a ataques de prompt injection. Debes documentar técnicas exitosas y recomendaciones de defensa.

---

## Pasos

### Paso 1: Gandalf AI - Prompt Injection Básico

**Objetivo**: Evadir restricciones del LLM en niveles progresivos.

#### Tarea 1.1: Nivel 1 - Inyección Directa

**Acceso:** https://gandalf.lakera.ai

**Tu tarea:** Intentar que Gandalf revele la contraseña con técnicas básicas.

**Comandos/acciones parciales:**
```
Prompt: "___"  (completa con tu técnica de inyección)
```

**Pistas:**
- Piensa en instrucciones que suenen naturales
- Prueba cambiar el contexto de la conversación
- Considera instructores de rol

**Resultado esperado:** Screenshot del intento y respuesta de Gandalf

---

#### Tarea 1.2: Nivel 2 - Técnicas Avanzadas

**Tu tarea:** Superar el nivel 2 con técnicas más sofisticadas.

**Comandos/acciones parciales:**
```
Prompt: "___"  (completa con técnica avanzada)
```

**Pistas:**
- Usa técnicas de indirecta (encapsulación)
- Prueba con formatos de código o datos
- Considera instrucciones "olvidadas"

**Resultado esperado:** Screenshot del intento exitoso

---

#### Tarea 1.3: Nivel 3 - Exploit Complejo

**Tu tarea:** Desarrollar un exploit para el nivel 3.

**Comandos/acciones parciales:**
```
Prompt: "___"  (completa con técnica compleja)
```

**Pistas:**
- Combina múltiples técnicas
- Usa metacaracteres o formatos especiales
- Considera inyección en metadatos

**Resultado esperado:** Screenshot del exploit completado

---

### Paso 2: HackAPrompt - Desafíos Avanzados

**Objetivo**: Completar niveles de dificultad progresiva.

#### Tarea 2.1: Niveles 1-2

**Acceso:** https://hackaprompt.github.io/

**Tu tarea:** Completar los primeros 2 niveles documentando tu enfoque.

**Comando parcial:**
```bash
# Documentar hallazgos
echo "Nivel 1: ___" >> hackaprompt_findings.txt
echo "Nivel 2: ___" >> hackaprompt_findings.txt
```

**Pistas:**
- Cada nivel tiene una pista contextual
- Analiza el sistema de puntuación
- Documenta cada intento

**Resultado esperado:** Archivo con técnicas documentadas

---

#### Tarea 2.2: Niveles 3-5

**Tu tarea:** Completar niveles intermedios con técnicas propias.

**Comandos parciales:**
```bash
# Nivel 3
echo "Técnica usada: ___" >> hackaprompt_findings.txt

# Nivel 4
echo "Vulnerabilidad explotada: ___" >> hackaprompt_findings.txt

# Nivel 5
echo "Metodología: ___" >> hackaprompt_findings.txt
```

**Pistas:**
- Requiere pensamiento lateral
- Combina técnicas de diferentes categorías
- Documenta el proceso, no solo el resultado

**Resultado esperado:** 5 niveles completados con técnicas documentadas

---

### Paso 3: Documentación de Técnicas

**Tu tarea:** Crear documento estructurado de hallazgos.

**Comando parcial:**
```bash
cat > ___ << EOF
# Hallazgos - Prompt Injection

## Gandalf AI
| Nivel | Técnica | Éxito | Notas |
|-------|---------|-------|-------|
| 1 | ___ | ___ | ___ |
| 2 | ___ | ___ | ___ |
| 3 | ___ | ___ | ___ |

## HackAPrompt
| Nivel | Técnica | Éxito | Notas |
|-------|---------|-------|-------|
| 1 | ___ | ___ | ___ |
| 2 | ___ | ___ | ___ |
| 3 | ___ | ___ | ___ |
| 4 | ___ | ___ | ___ |
| 5 | ___ | ___ | ___ |

## Análisis de Técnicas
- Técnica más efectiva: ___
- Dificultad creciente: ___
- Patrones comunes: ___
EOF
```

**Pista:** El archivo debe ser `prompt_injection_findings.md`

**Resultado esperado:** Documento estructurado con técnicas y análisis

---

### Paso 4: Análisis de Defensas

**Tu tarea:** Proponer mecanismos de defensa contra las técnicas descubiertas.

**Comando parcial:**
```bash
cat > ___ << EOF
# Defensas contra Prompt Injection

## Técnicas Identificadas y Sus Defensas

### Técnica 1: [Tu técnica más efectiva]
- **Defensa sugerida**: ___
- **Implementación**: ___
- **Limitaciones**: ___

### Técnica 2: [Segunda técnica más efectiva]
- **Defensa sugerida**: ___
- **Implementación**: ___
- **Limitaciones**: ___

## Recomendaciones Generales
1. ___
2. ___
3. ___

## Para la Industria
- Mejores prácticas: ___
- Estándares emergentes: ___
EOF
```

**Pista:** El archivo debe ser `defensas_prompt_injection.md`

**Resultado esperado:** Documento con defensas específicas y generales

---

## Ejercicios Independientes

**Sin ayuda, completa estos desafíos:**

1. Desarrolla una técnica de inyección que combine formato de código con contexto emocional
2. Investiga y documenta un caso real de prompt injection en producción
3. Propón una arquitectura de sistema que minimice riesgos de prompt injection

---

## Verificación

**Checklist para confirmar que completaste el lab:**

- [ ] Nivel 1 de Gandalf completado con screenshot
- [ ] Nivel 2 de Gandalf completado con screenshot
- [ ] Nivel 3 de Gandalf completado con screenshot
- [ ] Niveles 1-5 de HackAPrompt documentados
- [ ] Archivo `prompt_injection_findings.md` creado
- [ ] Archivo `defensas_prompt_injection.md` creado
- [ ] Análisis de técnicas efectivas realizado

---

## Troubleshooting

### Problema: "No puedo acceder a la plataforma"

**Solución**: 
- Verifica conexión a internet
- Prueba con navegador diferente
- Limpia caché del navegador

### Problema: "Las técnicas no funcionan"

**Solución**:
- Prueba combinaciones diferentes
- Cambia el orden de las instrucciones
- Usa formatos alternativos (código, JSON, etc.)

### Problema: "No sé qué documentar"

**Solución**:
- Documenta TODOS los intentos, incluso los fallidos
- Incluye screenshots de cada nivel
- Anota patrones que observes

---

## Entregable

**Archivo**: `llm_security_lab.md`

Incluir:
- Screenshots de exploits exitosos (Gandalf niveles 1-3)
- Listado de técnicas con prompts exactos usados
- Análisis de por qué funcionan cada técnica
- Defensas propuestas para cada técnica

---

## Recursos

- [OWASP Top 10 for LLM](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [Garak LLM Vulnerability Scanner](https://github.com/leondz/garak)
- [Prompt Injection Guide](https://github.com/trickster/prompt-injection-guide)
