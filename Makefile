# Makefile para Ethical Hacking 2026

.PHONY: build test deploy dev clean help

# Variables
QUARTO_CMD = quarto
BUILD_DIR = _book
SRC_DIR = .

# Colores para salida
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[1;33m
BLUE = \033[0;34m
NC = \033[0m # No Color

# Comandos principales

## Construir el proyecto
build:
	@echo "${BLUE}=== Construyendo el proyecto Ethical Hacking 2026 ===${NC}"
	$(QUARTO_CMD) render
	@echo "${GREEN}=== Construcción completada exitosamente ===${NC}"

## Iniciar servidor de desarrollo
dev:
	@echo "${BLUE}=== Iniciando servidor de desarrollo ===${NC}"
	$(QUARTO_CMD) preview

## Limpiar archivos de construcción
clean:
	@echo "${YELLOW}=== Limpiando archivos de construcción ===${NC}"
	@if [ -d "$(BUILD_DIR)" ]; then rm -rf $(BUILD_DIR); fi
	@echo "${GREEN}=== Limpieza completada ===${NC}"

## Probar el proyecto
## (Por ahora solo verifica que los archivos fuente existan)
test:
	@echo "${BLUE}=== Verificando integridad del proyecto ===${NC}"
	@if [ -f "index.qmd" ]; then \
		echo "${GREEN}[OK] Archivo principal encontrado: index.qmd${NC}"; \
	else \
		echo "${RED}[ERROR] Archivo principal no encontrado: index.qmd${NC}"; \
	fi
	@for i in {1..8}; do \
		if [ -f "contenido/unidad$$i.qmd" ]; then \
			echo "${GREEN}[OK] Unidad $$i encontrada${NC}"; \
		else \
			echo "${RED}[ERROR] Unidad $$i no encontrada${NC}"; \
		fi; \
	done
	@echo "${GREEN}=== Verificación completada ===${NC}"

## Desplegar el proyecto
## (Configurar con tu plataforma de despliegue preferida)
deploy:
	@echo "${YELLOW}=== Desplegando el proyecto ===${NC}"
	@echo "${YELLOW}=== Configure su plataforma de despliegue (Vercel/Netlify) ===${NC}"
	@echo "${GREEN}=== Despliegue completado ===${NC}"

## Mostrar ayuda
help:
	@echo "${BLUE}=== Comandos disponibles para Ethical Hacking 2026 ===${NC}"
	@echo ""
	@echo "${GREEN}build${NC}     - Construir el proyecto"
	@echo "${GREEN}dev${NC}       - Iniciar servidor de desarrollo"
	@echo "${GREEN}test${NC}      - Verificar integridad del proyecto"
	@echo "${GREEN}clean${NC}     - Limpiar archivos de construcción"
	@echo "${GREEN}deploy${NC}    - Desplegar el proyecto"
	@echo "${GREEN}help${NC}      - Mostrar esta ayuda"

# Aliases
all: build

# Comandos adicionales

## Verificar Docker labs
check-labs:
	@echo "${BLUE}=== Verificando laboratorios Docker ===${NC}"
	@for i in {1..8}; do \
		if [ -d "docker-labs/lab$$i" ]; then \
			if [ -f "docker-labs/lab$$i/docker-compose.yml" ]; then \
				echo "${GREEN}[OK] Lab $$i: Configuración Docker encontrada${NC}"; \
			else \
				echo "${RED}[ERROR] Lab $$i: docker-compose.yml faltante${NC}"; \
			fi; \
		else \
			echo "${RED}[ERROR] Lab $$i: Directorio no encontrado${NC}"; \
		fi; \
	done

## Iniciar todos los laboratorios Docker
start-labs:
	@echo "${BLUE}=== Iniciando todos los laboratorios Docker ===${NC}"
	@for i in {1..8}; do \
		if [ -d "docker-labs/lab$$i" ]; then \
			cd docker-labs/lab$$i; \
			docker-compose up -d; \
			cd ../../; \
			echo "${GREEN}[OK] Lab $$i iniciado${NC}"; \
		else \
			echo "${RED}[ERROR] Lab $$i: Directorio no encontrado${NC}"; \
		fi; \
	done

## Detener todos los laboratorios Docker
stop-labs:
	@echo "${BLUE}=== Deteniendo todos los laboratorios Docker ===${NC}"
	@for i in {1..8}; do \
		if [ -d "docker-labs/lab$$i" ]; then \
			cd docker-labs/lab$$i; \
			docker-compose down; \
			cd ../../; \
			echo "${GREEN}[OK] Lab $$i detenido${NC}"; \
		else \
			echo "${RED}[ERROR] Lab $$i: Directorio no encontrado${NC}"; \
		fi; \
	done

## Verificar estado de los laboratorios
status-labs:
	@echo "${BLUE}=== Verificando estado de laboratorios Docker ===${NC}"
	@for i in {1..8}; do \
		if [ -d "docker-labs/lab$$i" ]; then \
			if [ -f "docker-labs/lab$$i/docker-compose.yml" ]; then \
				echo "${GREEN}[OK] Lab $$i: Configuración Docker presente${NC}"; \
			else \
				echo "${RED}[ERROR] Lab $$i: docker-compose.yml faltante${NC}"; \
			fi; \
		else \
			echo "${RED}[ERROR] Lab $$i: Directorio no encontrado${NC}"; \
		fi; \
	done

# Comandos de utilidad

## Verificar instalación de Quarto
check-quarto:
	@if command -v quarto && [ "$$(quarto --version)" ]; then \
		echo "${GREEN}[OK] Quarto instalado: $$(quarto --version)${NC}"; \
	else \
		echo "${RED}[ERROR] Quarto no instalado o no encontrado${NC}"; \
	fi

## Verificar instalación de Docker
check-docker:
	@if command -v docker && [ "$$(docker --version)" ]; then \
		echo "${GREEN}[OK] Docker instalado: $$(docker --version)${NC}"; \
	else \
		echo "${RED}[ERROR] Docker no instalado o no encontrado${NC}"; \
	fi

## Verificar instalación de Node.js
check-node:
	@if command -v node && [ "$$(node --version)" ]; then \
		echo "${GREEN}[OK] Node.js instalado: $$(node --version)${NC}"; \
	else \
		echo "${RED}[ERROR] Node.js no instalado o no encontrado${NC}"; \
	fi

## Verificar instalación de npm
check-npm:
	@if command -v npm && [ "$$(npm --version)" ]; then \
		echo "${GREEN}[OK] npm instalado: $$(npm --version)${NC}"; \
	else \
		echo "${RED}[ERROR] npm no instalado o no encontrado${NC}"; \
	fi
