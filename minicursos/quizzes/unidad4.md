# Quiz Unidad 4: Hacking de Identidad y AD

**Puntaje mínimo**: 7/10 (70%)

---

## Preguntas de Opción Múltiple

### Pregunta 1 (Básica)

¿Qué protocolo usa Kerberos por defecto en Active Directory?

a) LDAP
b) SMB
c) Kerberos
d) NTLM

**Respuesta correcta**: c

---

### Pregunta 2 (Básica)

¿Qué es Kerberoasting?

a) Atacar el KDC
b) Crackear tickets TGS offline
c) Robar credenciales
d) Enumerar usuarios

**Respuesta correcta**: b

---

### Pregunta 3 (Intermedia)

¿Cuál es el puerto default de LDAP?

a) 389
b) 445
c) 636
d) 88

**Respuesta correcta**: a

---

### Pregunta 4 (Intermedia)

¿Qué herramienta se usa para visualizar relaciones en AD?

a) Mimikatz
b) BloodHound
c) CrackMapExec
d) Rubeus

**Respuesta correcta**: b

---

### Pregunta 5 (Avanzada)

¿Qué técnica permite moverse lateralmente usando hashes NTLM?

a) Kerberoasting
b) Pass-the-Hash
c) Golden Ticket
d) DCSync

**Respuesta correcta**: b

---

### Pregunta 6 (Básica)

¿Qué cuenta es el "krbtgt"?

a) Cuenta de administrador
b) Cuenta de servicio Kerberos
c) Cuenta de dominio
d) Cuenta guest

**Respuesta correcta**: b

---

### Pregunta 7 (Intermedia)

¿Qué es DCSync?

a) Sincronización de directorio
b) Simular ser un DC para obtener hashes
c) Un tipo de replicación
d) Servicio de DNS

**Respuesta correcta**: b

---

### Pregunta 8 (Avanzada)

Para un Golden Ticket, ¿qué hash se necesita?

a) Hash NTLM del usuario
b) Hash NTLM del krbtgt
c) Hash LM del dominio
d) Cualquier hash

**Respuesta correcta**: b

---

### Pregunta 9 (Básica)

¿Qué herramienta de Impacket permite ejecutar comandos?

a) secretsdump.py
b) psexec.py
c) getTGT.py
d) samrdump.py

**Respuesta correcta**: b

---

### Pregunta 10 (Intermedia)

¿Qué es un trust en Active Directory?

a) Relación entre dominios
b) Tipo de usuario
c) Grupo de seguridad
d) Politica de dominio

**Respuesta correcta**: a

---

## Escenarios Prácticos

### Escenario 1

**Situación**: Tienes un hash NTLM de un usuario pero no la contraseña.

**Pregunta**: ¿Qué técnica puedes usar?

a) Kerberoasting
b) Pass-the-Hash
c) AS-REP Roasting
d) Golden Ticket

**Respuesta esperada**: Pass-the-Hash

---

### Escenario 2

**Situación**: Necesitas extraer todos los hashes de usuarios del dominio.

**Pregunta**: ¿Qué técnica?

a) Kerberoasting
b) Pass-the-Hash
c) DCSync
d) SMB enumeration

**Respuesta esperada**: DCSync
