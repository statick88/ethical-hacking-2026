# 🎓 Minicursos - Ethical Hacking 2026

Este directorio contiene contenido adicional que complementan el curso principal pero **no forman parte del libro principal**.

---

## 📁 Estructura

```
minicursos/
├── anexos/           # Tutoriales técnicos adicionales
│   ├── anexo-bash-scripting.qmd
│   ├── anexo-docker.qmd
│   └── anexo-maquinas-virtuales.qmd
├── presentaciones/   # Slides por unidad
│   ├── unidad0_intro.qmd
│   ├── unidad1.qmd
│   └── ...
├── quizzes/          # Evaluaciones por unidad
│   ├── unidad1.md
│   ├── unidad2.md
│   └── ...
└── docker-labs/      # Scripts de contenedores
    ├── lab1/
    ├── lab2/
    └── ...
```

---

## 🚀 Uso

### Presentaciones (Slides)

```bash
# Renderizar presentaciones
cd presentaciones
quarto render

# Servir slides localmente
quarto serve
```

### Quizzes (Evaluaciones)

Los quizzes son evaluaciones independientes que pueden usarse para evaluar el conocimiento de cada unidad.

### Docker Labs

```bash
# Configurar todos los labs
cd docker-labs
./setup-all.sh

# Lab específico
cd lab1
docker-compose up
```

---

## 📋 Relación con el Brochure

| Contenido | ¿En Brochure? | ¿Minicurso? |
|-----------|---------------|-------------|
| Unidades 1-9 (principal) | ✅ Sí | ❌ No |
| Labs 1-8 + OWASP | ✅ Sí | ❌ No |
| Anexos (Bash, Docker, VMs) | ❌ No | ✅ Sí |
| Presentaciones | ❌ No | ✅ Sí |
| Quizzes | ❌ No | ✅ Sí |
| Docker Labs | ❌ No | ✅ Sí |

---

## 🔄 Nota

Estos materiales fueron separados del libro principal para mantener el curso alineado con el brochure oficial. Puedes integrarlos de nuevo al libro si lo deseas editando `_quarto.yml`.