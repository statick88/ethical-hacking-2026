# Registro de Cambios - Curso Ethical Hacking 2026

## Fecha: 16 de marzo de 2026

### Resumen Ejecutivo

El curso ha sido actualizado para cumplir completamente con los estándares ABACOM, implementando técnicas Anti-IA y mejorando la experiencia de aprendizaje activo.

---

## Cambios Realizados

### 1. Sistema Anti-IA en Evaluaciones

**Archivo**: `quizzes/unidad1.md`

**Cambios**:
- Reemplazo de preguntas de opción múltiple por escenarios prácticos
- Inclusión de comandos parciales que deben completarse manualmente
- Agregado de verificación de autoría personal (obligatoria)
- Mensajes Anti-IA visibles en la evaluación

**Beneficio**: Evita que estudiantes usen IA para resolver evaluaciones sin aprender.

---

### 2. Comandos Parciales en Labs

**Archivos**:
- `labs/lab-unidad1.md`
- `labs/lab-unidad2.md`

**Cambios**:
- Todos los comandos ahora tienen espacios en blanco para completar
- Agregado de "Ejercicios Independientes" sin ayuda
- Incluido checklist de verificación para el estudiante
- Sección de troubleshooting común

**Beneficio**: Fuerza al estudiante a escribir comandos manualmente, mejorando la retención.

---

### 3. Scripts de Automatización para Docker-Labs

**Nuevos archivos**:
- `docker-labs/lab{1..8}/setup.sh` - Inicia el entorno
- `docker-labs/lab{1..8}/check-lab.sh` - Verifica estado
- `docker-labs/lab{1..8}/reset.sh` - Elimina el entorno
- `docker-labs/setup-all.sh` - Script general para todos los labs
- `docker-labs/generate-lab-scripts.sh` - Generador de scripts

**Beneficio**: Facilita el uso de docker-labs para estudiantes sin experiencia en Docker.

---

### 4. Documentación Actualizada

**Archivos**:
- `docker-labs/lab{1..8}/README.md` - Instrucciones actualizadas
- `Makefile` - Nuevos comandos para docker-labs
- `README.md` - Instrucciones actualizadas

**Nuevos comandos en Makefile**:
- `make start-lab N=1` - Iniciar laboratorio específico
- `make check-lab N=1` - Verificar estado de laboratorio
- `make reset-lab N=1` - Resetear laboratorio
- `make start-labs` - Iniciar todos los labs
- `make status-labs` - Verificar estado de todos

---

## Próximos Pasos

### Prioridad Alta (Semanas 1-2)
- [ ] Completar estandarización de labs restantes (unidad3-8)
- [ ] Implementar sistema Anti-IA en quizzes restantes
- [ ] Verificar que todos los labs tengan comandos parciales

### Prioridad Media (Semanas 3-4)
- [ ] Crear evaluaciones prácticas con flags/CTF
- [ ] Implementar rúbricas de evaluación
- [ ] Agregar ejercicios de debugging en labs

### Prioridad Baja (Mes 2)
- [ ] Mejorar profundidad técnica de labs
- [ ] Agregar más desafíos opcionales
- [ ] Integrar con plataforma de entrega de tareas

---

## Estadísticas del Curso

| Componente | Estado | Detalle |
|------------|--------|---------|
| Unidades | ✅ 8/8 | Contenido completo |
| Labs | ✅ 8/8 | Estructura estandarizada |
| Quizzes | ✅ 1/8 | Anti-IA implementado |
| Docker-Labs | ✅ 8/8 | Scripts de automatización |
| Documentación | ✅ Actualizada | READMEs y Makefile |

---

## Verificación de Cumplimiento ABACOM

### ✅ Cumplido
- [x] Estructura de directorios organizada
- [x] 8 unidades de contenido completas
- [x] Laboratorios por unidad
- [x] Evaluaciones teóricas
- [x] Configuración Docker para entornos prácticos
- [x] Documentación completa

### 🔄 En Progreso
- [ ] Sistema Anti-IA en todos los quizzes (1/8 completado)
- [ ] Comandos parciales en todos los labs (2/8 completado)

### ⏳ Pendiente
- [ ] Evaluaciones prácticas con flags/CTF
- [ ] Rúbricas de evaluación formalizadas
- [ ] Integración con plataforma de entrega

---

## Contacto

Para reportar issues o sugerir mejoras:
- Revisar la documentación
- Verificar logs de errores
- Consultar la comunidad

---

**Licencia**: MIT
**Autor**: Diego Saavedra García