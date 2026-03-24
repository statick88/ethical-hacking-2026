#!/bin/bash
# Script para actualizar READMEs de docker-labs
# Author: Diego Saavedra
# Fecha: 2026-03-16

echo "=== Actualizando READMEs de docker-labs ==="
echo ""

for i in {1..8}; do
    echo "=== Actualizando lab$i ==="
    file="/Users/statick/apps/Ethical_Hacking/docker-labs/lab$i/README.md"
    
    # Verificar si el archivo existe
    if [ -f "$file" ]; then
        # Verificar si ya tiene la sección de scripts
        if grep -q "Opción 1: Usar scripts de automatización" "$file"; then
            echo "  Ya actualizado: $file"
        else
            # Buscar la primera ocurrencia de un patrón de sección de instalación
            # y reemplazar todo después de esa línea hasta la siguiente sección
            
            # Crear temporal
            temp_file="/tmp/readme_temp_$i.md"
            
            # Usar awk para insertar la sección en el lugar correcto
            awk '
                # Buscar patrones de sección de instalación o fin de arquitectura
                /^(## Setup|### Paso 1:|## 🚀 INSTRUCCIONES|### INSTRUCCIONES|## 🛑 Limpieza|## 🚀 Quick Start|## 🧹 Cleanup)/ && !inserted {
                    print $0
                    # Si es "Limpieza", insertar antes
                    if (/## 🛑 Limpieza/) {
                        print ""
                        print "### Opción 1: Usar scripts de automatización (Recomendado)"
                        print ""
                        print "```bash"
                        print "cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab'$i'"
                        print ""
                        print "# Iniciar el lab"
                        print "./setup.sh"
                        print ""
                        print "# Verificar estado"
                        print "./check-lab.sh"
                        print ""
                        print "# Resetear el lab (eliminar todo)"
                        print "./reset.sh"
                        print "```"
                        print ""
                        print "### Opción 2: Manual con Docker Compose"
                        print ""
                        next
                    }
                    print ""
                    print "### Opción 1: Usar scripts de automatización (Recomendado)"
                    print ""
                    print "```bash"
                    print "cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab'$i'"
                    print ""
                    print "# Iniciar el lab"
                    print "./setup.sh"
                    print ""
                    print "# Verificar estado"
                    print "./check-lab.sh"
                    print ""
                    print "# Resetear el lab (eliminar todo)"
                    print "./reset.sh"
                    print "```"
                    print ""
                    print "### Opción 2: Manual con Docker Compose"
                    print ""
                    inserted = 1
                    next
                }
                { print }
            ' "$file" > "$temp_file"
            
            # Reemplazar original con temporal
            mv "$temp_file" "$file"
            echo "  Actualizado: $file"
        fi
    else
        echo "  No existe: $file"
    fi
done

echo ""
echo "=== Actualización completada ==="