# Tasks: Correcciones Labs Docker

**Change**: correcciones-labs-docker  
**Total Tasks**: 72  
**Total Complexity**: 165 points (⚡)  
**Estimated Duration**: 3–4 developer-days (if working solo)  
**Work Phases**: 5  
**Critical Path**: Lab 2 (missing README) → Lab 4 (Windows AD) → Lab 7 (OpenPLC) → Lab 8 (REST API)

---

## Overview

This task breakdown organizes 72 concrete work items across 5 phases:

1. **Phase 1: Foundation** (Labs 1, 2, 3 — low-risk setup) — 8 tasks, 28 points
2. **Phase 2: Critical Replacements** (Labs 4, 7, 8 — major changes) — 20 tasks, 62 points
3. **Phase 3: Infrastructure Updates** (Labs 5, 6 — image/resource updates) — 12 tasks, 35 points
4. **Phase 4: Testing & Verification** (All labs — functional validation) — 20 tasks, 25 points
5. **Phase 5: Documentation & Delivery** (Cleanup, final review) — 12 tasks, 15 points

**Parallelization Opportunity**: After Phase 1 completes, Labs 4, 7, 8 can be worked in parallel (each ~6 hours). Labs 5, 6 can follow independently.

---

## Phase 1: Foundation — Template Setup & Audit (28 points)

**Goal**: Establish the standard README template and audit existing Labs 1–3 before major changes.

**Completion Time**: ~2 hours  
**Parallelizable**: No (Labs 2 depends on Lab 1 template; others sequential for learning)

### Lab 1: Network Reconnaissance (Kali + Metasploitable)

- [ ] **1.1** Audit `labs/lab1/docker-compose.yml` against current design spec ⚡2
  - **Depends On**: None (audit task)
  - **Acceptance Criteria**:
    1. Read current file; check image tags, network definition, resource limits
    2. Compare against `design/labs.md` § Lab 1 interfaces
    3. Document findings: current Kali version? Metasploitable version? Network name?
    4. Create checklist of required changes (pinned versions, resource limits, health checks)
  - **Implementation Notes**:
    - Current file: `labs/lab1/docker-compose.yml`
    - Look for: `kalilinux` image tag, `metasploitable` image tag, network definition, resource limits section
    - Test command: `docker compose config` (validates syntax)

- [ ] **1.2** Create standard README template (reusable across all 8 labs) ⚡3
  - **Depends On**: None
  - **Blocks**: 1.3, 2.1 (other labs reuse this template)
  - **Acceptance Criteria**:
    1. Create template file: `labs/lab1/README.md` with 11 standard sections
    2. Sections: Title, Learning Objectives, Prerequisites, Architecture, Quick Start, Expected Output, Exercises, Troubleshooting, Testing Checklist, Cleanup, Resources
    3. Include placeholder text and comments for Lab 1 context
    4. Verify markdown syntax (no broken links, valid code blocks)
  - **Implementation Notes**:
    - Template source: `design/labs.md` § "README.md Template"
    - Each section should have guidance comments: `<!-- Customize for Lab 1: ... -->`
    - Save as Lab 1's README; Labs 2–8 will customize this template

- [ ] **1.3** Update Lab 1 `docker-compose.yml` to match design spec ⚡3
  - **Depends On**: 1.1, 1.2
  - **Blocks**: 1.4, 4.1 (testing)
  - **Acceptance Criteria**:
    1. Update image versions: Kali to `kalilinux/kali-rolling:2025.1`, Metasploitable to `vulnerables/metasploitable2` (pinned)
    2. Add network definition: `lab1-net` with subnet `172.18.1.0/24`
    3. Add resource limits: Kali 1GB limit/512MB reserved; Metasploitable 1GB limit/512MB reserved
    4. Verify file validates: `docker compose -f labs/lab1/docker-compose.yml config` (no errors)
    5. No health checks needed (simple lab)
  - **Implementation Notes**:
    - Reference: `design/labs.md` § Lab 1 Interfaces + Resource Limits
    - Command to validate: `docker compose -f labs/lab1/docker-compose.yml config`
    - Expected network CIDR: `172.18.1.0/24`

- [ ] **1.4** Fill Lab 1 README with concrete content ⚡3
  - **Depends On**: 1.3
  - **Blocks**: 4.1 (testing)
  - **Acceptance Criteria**:
    1. Complete all sections: Learning Objectives (5 bullets), Prerequisites, Architecture (with ASCII diagram), Quick Start (copy-paste commands), Expected Output, 4 Exercises, 5+ Troubleshooting entries, Testing Checklist, Cleanup, Resources
    2. Include actual lab objectives: "Learn network reconnaissance tools", "Identify open ports", "Practice Metasploit payload delivery"
    3. Add ASCII diagram showing Kali and Metasploitable containers, network connections
    4. Expected Output: actual `docker compose ps` output showing both containers running
    5. Verify no markdown errors: `markdownlint labs/lab1/README.md` (if available, or manual check)
  - **Implementation Notes**:
    - Objectives from design: Network reconnaissance, Metasploit familiarization
    - Ports: 21, 22, 23, 25, 80, 139, 445, 3306, 8080 (all internal to lab1-net)
    - ASCII diagram: 2 containers, lab1-net, services between them

### Lab 2: Web Application Testing (DVWA + MySQL + Kali)

- [ ] **2.1** Create Lab 2 README.md from scratch (currently missing!) ⚡4
  - **Depends On**: 1.2 (template exists)
  - **Blocks**: 2.2, 4.2 (testing)
  - **Acceptance Criteria**:
    1. Create new file: `labs/lab2/README.md` using the template from Lab 1
    2. Complete all 11 sections tailored to DVWA + MySQL web application security
    3. Learning Objectives: "Exploit DVWA vulnerabilities", "Practice SQL injection", "Understand web app authentication"
    4. Expected Output: actual startup sequence, database initialization messages
    5. Include 5+ exercises with step-by-step commands
    6. Troubleshooting: MySQL startup delays, DVWA not loading, connection timeouts
  - **Implementation Notes**:
    - This is the MISSING README — critical fix
    - Services: DVWA (web), MySQL (database), Kali (attacker)
    - Expected startup time: ~40 seconds (MySQL init is slow)
    - Verify: Check `labs/lab2/docker-compose.yml` exists; check if README exists (should not)

- [ ] **2.2** Verify Lab 2 docker-compose.yml structure and add health checks ⚡3
  - **Depends On**: 2.1
  - **Blocks**: 2.3, 4.2 (testing)
  - **Acceptance Criteria**:
    1. Audit current `labs/lab2/docker-compose.yml`: images, network, health checks
    2. Add health check for MySQL: `mysqladmin ping -h localhost` every 10s, start_period 40s
    3. Add depends_on with condition: DVWA depends on MySQL being healthy
    4. Pin image versions: DVWA to `vulnerables/web-dvwa:1.12.4`, MySQL to `mariadb:10.5`
    5. Validate: `docker compose -f labs/lab2/docker-compose.yml config` (no errors)
  - **Implementation Notes**:
    - Reference: `design/labs.md` § Health Checks (Lab 2 section)
    - Health check test: `["CMD", "mysqladmin", "ping", "-h", "localhost"]`
    - DVWA depends_on: `db: {condition: service_healthy}`

- [ ] **2.3** Add resource limits and network to Lab 2 docker-compose.yml ⚡2
  - **Depends On**: 2.2
  - **Blocks**: 4.2 (testing)
  - **Acceptance Criteria**:
    1. Add network definition: `lab2-net` (172.18.2.0/24)
    2. Add resource limits: DVWA 512MB, MySQL 1GB, Kali 1GB
    3. Assign IPs: DVWA ~172.18.2.10, MySQL ~172.18.2.20, Kali ~172.18.2.30
    4. Verify: `docker compose -f labs/lab2/docker-compose.yml config` (no errors)
  - **Implementation Notes**:
    - Network CIDR: `172.18.2.0/24`
    - Resource format: `deploy.resources.limits.memory`, `deploy.resources.reservations.memory`

### Lab 3: Web Application Security (WebGoat)

- [ ] **3.1** Audit Lab 3 docker-compose.yml and update image versions ⚡2
  - **Depends On**: None
  - **Blocks**: 3.2, 4.3 (testing)
  - **Acceptance Criteria**:
    1. Check current `labs/lab3/docker-compose.yml`: current WebGoat image tag?
    2. Update WebGoat to `webgoat/webgoat-8.0:2025.1` (pinned version)
    3. Add network: `lab3-net` (172.18.3.0/24)
    4. Add resource limits: WebGoat 1GB, Kali 512MB
    5. No health checks needed
    6. Validate: `docker compose config`
  - **Implementation Notes**:
    - Reference: `design/labs.md` § Image Versions (Lab 3)
    - No deprecated image issues expected; mainly update to pinned version

- [ ] **3.2** Create/update Lab 3 README.md ⚡3
  - **Depends On**: 1.2, 3.1
  - **Blocks**: 4.3 (testing)
  - **Acceptance Criteria**:
    1. Create/update `labs/lab3/README.md` using template
    2. Learning Objectives: "Learn WebGoat security lessons", "Practice web vulnerability identification"
    3. Expected Output section: Show WebGoat startup, expected listening port
    4. Include 4 exercises from WebGoat (e.g., "SQL Injection Lesson", "Authentication Flaws")
    5. Troubleshooting: WebGoat not accessible, logs not showing (check Kali network connection)
  - **Implementation Notes**:
    - WebGoat is single-service (no database), so simpler than Lab 2
    - Startup time: <5 seconds
    - Expected port (internal): 8080 (not exposed by default)

---

## Phase 2: Critical Replacements — Major Changes (62 points)

**Goal**: Implement the three high-impact fixes: Lab 2 missing README (done in Phase 1), Lab 4 Windows AD, Lab 7 OpenPLC, Lab 8 REST API.

**Completion Time**: ~4–5 hours  
**Parallelizable**: After completion of Phase 1, Labs 4, 7, 8 can be worked in parallel

### Lab 4: Windows AD Exploitation (CRITICAL — Replace Juice Shop)

- [ ] **4.1** Audit current Lab 4 docker-compose.yml (identify Juice Shop references) ⚡2
  - **Depends On**: None
  - **Blocks**: 4.2, 4.3
  - **Acceptance Criteria**:
    1. Read `labs/lab4/docker-compose.yml`: find Juice Shop service definition
    2. Document: current image name, ports, volumes, environment variables
    3. Create list of what to replace (Juice Shop service → Windows AD DC service)
    4. Verify Kali container exists in the file
  - **Implementation Notes**:
    - Current lab likely has: `juice-shop`, `kali` services
    - Look for: image tag, port mappings (typically 3000 for Juice Shop)
    - This is a "before" documentation task

- [ ] **4.2** Replace Juice Shop service with Windows Server AD Domain Controller ⚡5
  - **Depends On**: 4.1
  - **Blocks**: 4.3, 4.4
  - **Acceptance Criteria**:
    1. Remove Juice Shop service entirely from `labs/lab4/docker-compose.yml`
    2. Add Windows AD service (dc01):
       - Image: `mcr.microsoft.com/windows/servercore:ltsc2022`
       - Environment: `ADMIN_PASSWORD`, `DOMAIN_NAME=lab.local`, `NETBIOS_NAME=LAB`
       - Ports: 389 (LDAP), 636 (LDAPS), 88 (Kerberos) — internal to network
       - Optional RDP 3389 (commented out)
    3. Add health check: LDAP connectivity test with 60-second start_period
    4. Add network: `lab4-net` (172.18.4.0/24)
    5. Kali depends_on DC with condition `service_healthy`
    6. Resource limits: DC 2GB, Kali 1GB
    7. Validate: `docker compose -f labs/lab4/docker-compose.yml config` (no errors)
  - **Implementation Notes**:
    - Reference: `design/labs.md` § Lab 4 Application (Windows AD)
    - Health check: `["CMD", "powershell", "-Command", "Test-NetConnection -ComputerName localhost -Port 389"]`
    - Startup time: 60 seconds (documented!)
    - Image size: ~3–4 GB (expected, document in README)
    - DC IP: 172.18.4.10, Kali IP: 172.18.4.20

- [ ] **4.3** Create Lab 4 README.md — Windows AD exploitation guide ⚡4
  - **Depends On**: 4.2, 1.2 (template)
  - **Blocks**: 4.4, 5.1 (testing)
  - **Acceptance Criteria**:
    1. Create `labs/lab4/README.md` using template (replace Juice Shop content entirely)
    2. Learning Objectives: "Exploit Windows Active Directory", "Kerberoasting attacks", "LDAP enumeration", "Pass-the-Hash", "Delegation abuse"
    3. Prerequisites: Mention 60-second startup time, 2GB RAM for DC
    4. Architecture: ASCII diagram with DC (172.18.4.10) and Kali (172.18.4.20)
    5. Expected Output: Show DC startup logs, LDAP service confirmation
    6. Exercises (4+): LDAP query, Kerberoasting, user enum, SPN discovery
    7. Troubleshooting: "DC stuck in starting", "Kerberoasting returns no results", "LDAP timeout"
    8. Include reference links: Impacket tools, AD attack documentation
  - **Implementation Notes**:
    - This replaces the old Juice Shop README entirely (not an update)
    - Domain: `lab.local`, Admin: `Administrator`, Password: environment variable
    - Tools in Kali: `impacket`, `ldapsearch`, `crackmapexec`
    - Exercises should demonstrate real AD attacks (Kerberoasting, LDAP enum, etc.)

- [ ] **4.4** Add Windows AD domain initialization (users, SPNs, groups) to README ⚡2
  - **Depends On**: 4.3
  - **Blocks**: 5.1 (testing)
  - **Acceptance Criteria**:
    1. Document in README: How to initialize test users in AD (manual commands or setup script)
    2. Create or reference setup script: `labs/lab4/setup_ad.sh` or `labs/lab4/setup_ad.ps1` (PowerShell)
    3. Script adds: test users (e.g., `testuser1`), service accounts (for SPN setup), groups
    4. README includes: "After first `docker compose up`, run setup script to populate AD"
    5. Verify script syntax (if bash: `bash -n`, if PS: `powershell -NoProfile -Command { & "script.ps1" }`
  - **Implementation Notes**:
    - Script target: Windows DC inside container
    - Example: Run `docker compose exec dc01 powershell "Add-ADUser -Name testuser1 ..."`
    - Or: Mount setup script, run on DC startup
    - This ensures Kerberoasting/attacks have data to work with

### Lab 7: ICS/SCADA with OpenPLC (CRITICAL — Replace Mutillidae)

- [ ] **5.1** Audit Lab 7 docker-compose.yml (identify Mutillidae references) ⚡2
  - **Depends On**: None (can run parallel to Lab 4)
  - **Blocks**: 5.2, 5.3
  - **Acceptance Criteria**:
    1. Read `labs/lab7/docker-compose.yml`: find Mutillidae service definition
    2. Document: current image, ports, volumes, environment
    3. List what to remove and what to add (Mutillidae → OpenPLC)
    4. Verify Kali container exists
  - **Implementation Notes**:
    - Current likely has: `mutillidae`, `kali`
    - Mutillidae typical port: 80 or 8080
    - This is a "before" documentation task

- [ ] **5.2** Replace Mutillidae with OpenPLC SCADA platform ⚡4
  - **Depends On**: 5.1
  - **Blocks**: 5.3, 5.4
  - **Acceptance Criteria**:
    1. Remove Mutillidae service entirely from `labs/lab7/docker-compose.yml`
    2. Add OpenPLC service (openplc):
       - Image: `openplcproject/openplc-v3:2024.11` (pinned version, not latest)
       - Ports: 8080 (web UI), 502 (Modbus TCP) — internal to network
       - Optional: 1102 (OPC-UA, commented out)
       - Volume: persist projects at `/opt/openplc/projects`
    3. Add health check: HTTP GET to `http://localhost:8080/` with 15-second start_period
    4. Add network: `lab7-net` (172.18.7.0/24)
    5. Kali depends_on OpenPLC with condition `service_healthy`
    6. Resource limits: OpenPLC 1GB, Kali 512MB
    7. Validate: `docker compose config` (no errors)
  - **Implementation Notes**:
    - Reference: `design/labs.md` § Lab 7 Application (OpenPLC)
    - Startup time: 15 seconds
    - Image: `openplcproject/openplc-v3:2024.11` (confirm this tag exists; may need adjustment)
    - Volume: `./projects:/opt/openplc/projects` (relative path, creates local projects dir)
    - Health check: `["CMD", "curl", "-f", "http://localhost:8080/"]`
    - OpenPLC IP: 172.18.7.10, Kali IP: 172.18.7.20

- [ ] **5.3** Create Lab 7 README.md — ICS/SCADA and Modbus security guide ⚡4
  - **Depends On**: 5.2, 1.2 (template)
  - **Blocks**: 5.4, 6.1 (testing)
  - **Acceptance Criteria**:
    1. Create `labs/lab7/README.md` using template (replace Mutillidae content entirely)
    2. Learning Objectives: "Understand ICS/SCADA systems", "Modbus TCP attacks", "PLC program injection", "SCADA security testing"
    3. Prerequisites: Mention 15-second startup, OpenPLC web UI access
    4. Architecture: OpenPLC and Kali on lab7-net, ports 8080 (UI) and 502 (Modbus)
    5. Expected Output: OpenPLC web UI startup, Modbus service listening
    6. Exercises (4+): Modbus scanning, register enumeration, coil manipulation, PLC program upload
    7. Troubleshooting: "OpenPLC web UI not loading", "Modbus port not responding", "Health check timeout"
    8. Include references: NIST ICS security, Modbus protocol docs, OpenPLC documentation
  - **Implementation Notes**:
    - Exercises use tools: `nmap`, `pymodbus`, custom Modbus client
    - Attack vectors: Port 502 (Modbus), web UI (8080) for program manipulation
    - Security focus: Lack of authentication, unencrypted protocols, PLCs accepting arbitrary commands

- [ ] **5.4** Create sample PLC program and upload instructions for Lab 7 ⚡3
  - **Depends On**: 5.3
  - **Blocks**: 6.1 (testing)
  - **Acceptance Criteria**:
    1. Create sample PLC program file: `labs/lab7/projects/sample_program.st` (Structured Text format)
    2. Document in README: "How to upload program to OpenPLC web UI" with screenshots or step-by-step
    3. Program should do something visible: toggle outputs, read/write registers, demonstrate Modbus functionality
    4. Provide curl/pymodbus examples to read/write PLC registers
    5. Verify file is valid syntax (basic check, may need OpenPLC validation)
  - **Implementation Notes**:
    - PLC program format: IEC 61131-3 Structured Text (.st)
    - Sample program: Simple counter, timer, or I/O toggle
    - File: `labs/lab7/projects/sample_program.st`
    - Upload instructions: Via web UI or direct file placement in volume
    - Modbus client examples: Python `pymodbus` library commands

### Lab 8: REST API Security (CRITICAL — Add REST API Service)

- [ ] **6.1** Audit Lab 8 docker-compose.yml (identify missing API service) ⚡2
  - **Depends On**: None (can run parallel to Labs 4, 7)
  - **Blocks**: 6.2, 6.3
  - **Acceptance Criteria**:
    1. Read `labs/lab8/docker-compose.yml`: confirm current services (DVWA, MySQL, Kali)
    2. Verify no API service exists (expected)
    3. Document: network, health checks, resource limits (if any)
    4. Identify locations to add API service
  - **Implementation Notes**:
    - Current services: probably `dvwa`, `db` (MySQL), `kali`
    - This audit confirms the missing API service

- [ ] **6.2** Create Flask REST API application (vulnerable by design) ⚡5
  - **Depends On**: 6.1
  - **Blocks**: 6.3, 6.4
  - **Acceptance Criteria**:
    1. Create Flask app file: `labs/lab8/api/app.py`
    2. Implement endpoints per design spec:
       - `GET /api/health` → `{"status": "ok"}` (no auth)
       - `GET /api/users` → JSON user list (no auth, vulnerable to scraping)
       - `POST /api/login` → Token response (vulnerable to SQL injection in query)
       - `GET /api/admin` → Admin data (missing auth check, vulnerable)
       - `POST /api/products` → Product creation (insecure deserialization via pickle)
    3. Connect to MySQL database (`lab8-db:3306`)
    4. Use environment variables for database credentials
    5. Test locally: Start Flask app, verify endpoints respond
    6. Verify endpoints have intentional vulnerabilities (documented in code comments)
  - **Implementation Notes**:
    - Framework: Flask (lightweight Python)
    - Database: MySQL (mariadb image), connection via `MySQLdb` or `sqlalchemy`
    - Vulnerabilities: SQL injection, missing auth, insecure pickle deserialization
    - File structure: `labs/lab8/api/app.py`
    - Testing: `curl http://localhost:5000/api/health` → `{"status": "ok"}`

- [ ] **6.3** Create Dockerfile for Lab 8 API container ⚡3
  - **Depends On**: 6.2
  - **Blocks**: 6.4, 6.5
  - **Acceptance Criteria**:
    1. Create `labs/lab8/api/Dockerfile`
    2. Base image: `python:3.11-slim`
    3. Install dependencies: Flask, requests, python-dotenv, MySQLdb (or sqlalchemy)
    4. Copy app.py and .env.example into container
    5. Expose port 5000
    6. CMD: `flask run --host=0.0.0.0`
    7. Verify Dockerfile builds: `docker build -f labs/lab8/api/Dockerfile -t lab8-api:latest labs/lab8/api/`
  - **Implementation Notes**:
    - Dockerfile location: `labs/lab8/api/Dockerfile`
    - Image name: `lab8-api:latest` (can be pinned to specific build later)
    - Dependencies: Flask, python-dotenv, MySQLdb or sqlalchemy
    - Exposed port: 5000 (internal to lab8-net)

- [ ] **6.4** Create .env.example file for Lab 8 API configuration ⚡2
  - **Depends On**: 6.2
  - **Blocks**: 6.5
  - **Acceptance Criteria**:
    1. Create `labs/lab8/api/.env.example`
    2. Include variables: `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `FLASK_SECRET_KEY`, `API_PORT`
    3. Example values: `DB_HOST=lab8-db`, `DB_USER=root`, `DB_PASSWORD=rootpass`, `API_PORT=5000`
    4. Document in README: "Copy .env.example to .env, modify as needed"
    5. Verify syntax: `cat labs/lab8/api/.env.example` (readable, valid key=value pairs)
  - **Implementation Notes**:
    - Format: KEY=VALUE (one per line), no spaces around `=`
    - Example: `DB_HOST=lab8-db` (use container network name)
    - Secret key: Generate with `python -c "import secrets; print(secrets.token_hex(32))"`

- [ ] **6.5** Add API service to Lab 8 docker-compose.yml with health checks ⚡4
  - **Depends On**: 6.2, 6.3
  - **Blocks**: 6.6, 7.1 (testing)
  - **Acceptance Criteria**:
    1. Update `labs/lab8/docker-compose.yml`: add `api` service
    2. Service definition:
       - Image: `lab8-api:latest` (built from `labs/lab8/api/Dockerfile`)
       - Container name: `lab8-api`
       - Ports: 5000 (internal only, no host mapping)
       - Network: `lab8-net`, IP ~172.18.8.30
       - Environment: Load from `.env` or hardcode for testing
       - Depends_on: `db` with condition `service_healthy`
       - Health check: HTTP GET to `http://localhost:5000/api/health` (200 status), 15-second start_period
    3. Update database service: Add health check (if not already present)
    4. Update DVWA/Kali depends_on: Add `api` as dependency with health condition
    5. Add resource limits: API 512MB
    6. Validate: `docker compose -f labs/lab8/docker-compose.yml config` (no errors)
  - **Implementation Notes**:
    - Health check: `["CMD", "curl", "-f", "http://localhost:5000/api/health"]`
    - Resource limit: `512M` (Flask is lightweight)
    - Startup delay: ~10 seconds (Python app initialization)
    - Database healthcheck (if not present): `["CMD", "mysqladmin", "ping", "-h", "localhost"]`

- [ ] **6.6** Update Lab 8 README.md to document REST API endpoints and exercises ⚡4
  - **Depends On**: 6.5, 1.2 (template)
  - **Blocks**: 7.1 (testing)
  - **Acceptance Criteria**:
    1. Create/update `labs/lab8/README.md` using template
    2. Learning Objectives: "REST API security testing", "SQL injection in APIs", "Authentication bypass", "Insecure deserialization"
    3. Architecture: DVWA, MySQL, API, Kali on lab8-net; API on port 5000
    4. Expected Output: All 4 services running, API health check passing
    5. API Endpoints section: Document each endpoint (method, path, parameters, vulnerability)
    6. Exercises (5+): Query users endpoint, test login for SQL injection, access admin without auth, exploit pickle deserialization
    7. Troubleshooting: "API not responding", "Health check timeout", "Database connection error"
    8. Include curl/curl examples for testing each endpoint
  - **Implementation Notes**:
    - Endpoint documentation: Include actual curl commands
    - Exercises: Step-by-step exploitation walkthrough
    - Expected startup time: ~20 seconds total (MySQL + Flask)
    - Vulnerability focus: SQL injection, broken authentication, insecure deserialization

---

## Phase 3: Infrastructure Updates — Remaining Labs (35 points)

**Goal**: Update Labs 5 and 6 with current image versions, resource limits, and documentation.

**Completion Time**: ~2 hours  
**Parallelizable**: Labs 5 and 6 can run in parallel (independent)

### Lab 5: Linux Privilege Escalation

- [ ] **7.1** Audit Lab 5 docker-compose.yml (image versions, network, health checks) ⚡2
  - **Depends On**: None
  - **Blocks**: 7.2, 7.3
  - **Acceptance Criteria**:
    1. Read `labs/lab5/docker-compose.yml`: current vulnerable Linux image?
    2. Check network definition, resource limits, Kali service
    3. Document current state: image name, image tag, ports, network
    4. Identify what needs updating (versions, resource limits, network)
  - **Implementation Notes**:
    - Likely image: `vulnerables/ubuntu-linux` or similar
    - Expected services: vulnerable target, Kali

- [ ] **7.2** Update Lab 5 docker-compose.yml — pin images and add infrastructure ⚡3
  - **Depends On**: 7.1
  - **Blocks**: 7.3, 8.1 (testing)
  - **Acceptance Criteria**:
    1. Pin vulnerable Linux image to stable version (check available tags on Docker Hub)
    2. Update Kali to `kalilinux/kali-rolling:2025.1`
    3. Add network: `lab5-net` (172.18.5.0/24)
    4. Add resource limits: Target 512MB, Kali 1GB
    5. Assign IPs: Target ~172.18.5.10, Kali ~172.18.5.20
    6. Verify: `docker compose config` (no errors)
  - **Implementation Notes**:
    - Reference: `design/labs.md` § Lab 5 Image Versions
    - Network CIDR: `172.18.5.0/24`
    - No health checks needed (simple lab)

- [ ] **7.3** Create/update Lab 5 README.md — Linux privesc exercises ⚡3
  - **Depends On**: 7.2, 1.2 (template)
  - **Blocks**: 8.1 (testing)
  - **Acceptance Criteria**:
    1. Create/update `labs/lab5/README.md` using template
    2. Learning Objectives: "Linux privilege escalation", "Exploit kernel/service vulnerabilities", "Practice post-exploitation"
    3. Architecture: Vulnerable Linux and Kali on lab5-net
    4. Expected Output: Both containers running, vulnerable services exposed on internal network
    5. Exercises (4+): Scan for vulnerabilities, exploit kernel bug, escalate to root, capture flag
    6. Troubleshooting: "Target not responding", "Exploit fails", "Shell drops"
    7. Include specific CVEs or exploits relevant to the vulnerable distro
  - **Implementation Notes**:
    - Objective: Practice post-exploitation and privilege escalation
    - Exercises should reference specific exploits (kernel CVE, service vuln)
    - Expected startup time: <5 seconds

### Lab 6: Social Engineering & Phishing (Gophish)

- [ ] **8.1** Audit Lab 6 docker-compose.yml (Gophish or evilginx2, image versions) ⚡2
  - **Depends On**: None (can run parallel to Lab 5)
  - **Blocks**: 8.2, 8.3
  - **Acceptance Criteria**:
    1. Read `labs/lab6/docker-compose.yml`: current phishing tool (Gophish or evilginx2)?
    2. Document current image, ports (admin panel, phishing server), environment
    3. Check network definition, resource limits
    4. Identify updates needed (image version, ports, network, resource limits)
  - **Implementation Notes**:
    - Likely tool: Gophish or evilginx2
    - Typical ports: 3333 (Gophish admin), 80/443 (phishing pages)
    - Network/resource limits may be missing

- [ ] **8.2** Update Lab 6 docker-compose.yml — pin images and add infrastructure ⚡3
  - **Depends On**: 8.1
  - **Blocks**: 8.3, 8.4, 9.1 (testing)
  - **Acceptance Criteria**:
    1. Pin phishing tool image: `gophish:0.12.1` (if Gophish) or latest stable evilginx2
    2. Update Kali to `kalilinux/kali-rolling:2025.1`
    3. Add network: `lab6-net` (172.18.6.0/24)
    4. Add resource limits: Gophish 512MB, Kali 1.5GB
    5. Assign IPs: Gophish ~172.18.6.10, Kali ~172.18.6.20
    6. Verify: `docker compose config` (no errors)
  - **Implementation Notes**:
    - Reference: `design/labs.md` § Lab 6 Image Versions
    - Network CIDR: `172.18.6.0/24`
    - No health checks needed (single service)
    - Gophish admin typically port 3333 (internal), phishing server 80/443

- [ ] **8.3** Create/update Lab 6 README.md — phishing campaign exercises ⚡3
  - **Depends On**: 8.2, 1.2 (template)
  - **Blocks**: 8.4, 9.1 (testing)
  - **Acceptance Criteria**:
    1. Create/update `labs/lab6/README.md` using template
    2. Learning Objectives: "Phishing campaign setup", "Social engineering", "Credential harvesting", "OPSEC considerations"
    3. Architecture: Gophish and Kali on lab6-net, admin panel (3333), phishing server (80)
    4. Expected Output: Gophish running, admin UI accessible, phishing campaigns ready
    5. Exercises (4+): Create phishing template, launch campaign, harvest credentials, cover tracks
    6. Troubleshooting: "Admin panel not accessible", "Phishing pages not loading", "Credential capture failing"
    7. Include ethical warnings: "For authorized testing only"
  - **Implementation Notes**:
    - Tool: Gophish (or evilginx2)
    - Exercises: Create campaign, send phishing email, capture creds
    - Expected startup time: <5 seconds
    - Admin port: 3333 (internal to lab6-net only)

- [ ] **8.4** Add Gophish configuration example and phishing templates to Lab 6 ⚡2
  - **Depends On**: 8.3
  - **Blocks**: 9.1 (testing)
  - **Acceptance Criteria**:
    1. Create sample Gophish config: `labs/lab6/config.json` (if needed)
    2. Create sample phishing template: `labs/lab6/templates/sample_phishing.html`
    3. Document in README: "How to import templates" or "How to create campaigns"
    4. Verify files are valid JSON/HTML
  - **Implementation Notes**:
    - Gophish stores config in `config.json` or uses UI for templates
    - Sample phishing template: Simple HTML form mimicking login page
    - May not need custom files if Gophish UI handles templates; adjust as needed

---

## Phase 4: Testing & Verification (25 points)

**Goal**: Functional testing of each lab — startup verification, health check validation, and basic functionality checks.

**Completion Time**: ~3–4 hours  
**Parallelizable**: Can test multiple labs in parallel if Docker resources allow (careful with RAM)

### Lab 1 Testing

- [ ] **9.1** Test Lab 1 startup and container health ⚡2
  - **Depends On**: 1.4 (Lab 1 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab1 && docker compose up -d`
    2. Wait 5 seconds, then `docker compose ps` — all containers should show "Up"
    3. Verify network exists: `docker network ls | grep lab1-net`
    4. Ping Metasploitable from Kali: `docker compose exec kali ping -c 2 lab1-metasploitable`
    5. Document actual output (container IPs, port mappings, network info)
    6. Teardown: `docker compose down`
  - **Implementation Notes**:
    - Test commands: `docker compose ps`, `docker compose exec`, `docker network ls`
    - Expected: Both containers running, network lab1-net exists, Kali-to-Metasploitable connectivity works
    - Document: Save output for "Expected Output" section in README (if not already done)

### Lab 2 Testing

- [ ] **9.2** Test Lab 2 startup with health checks ⚡3
  - **Depends On**: 2.3 (Lab 2 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab2 && docker compose up -d`
    2. Wait 10 seconds, then `docker compose ps` — all containers should show "Up"
    3. Check health status: `docker compose ps` (health column should show "healthy" or "starting")
    4. Verify MySQL health check passes: Wait up to 60 seconds for DB to initialize
    5. Verify DVWA loads: `docker compose exec kali curl -s http://dvwa/setup.php | head -20`
    6. Test basic DVWA endpoint: `docker compose exec kali curl -s http://dvwa/login.php`
    7. Document startup time and health check progression
    8. Teardown: `docker compose down -v` (removes volumes)
  - **Implementation Notes**:
    - Critical: MySQL takes 40+ seconds to initialize (start_period configured for this)
    - Health check: should see "starting" for 40s, then "healthy"
    - DVWA depends_on MySQL with condition service_healthy, so DVWA won't start until DB is ready
    - Teardown: Use `-v` flag to clean up volumes

### Lab 3 Testing

- [ ] **9.3** Test Lab 3 startup ⚡2
  - **Depends On**: 3.2 (Lab 3 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab3 && docker compose up -d`
    2. Wait 5 seconds, then `docker compose ps` — WebGoat and Kali should show "Up"
    3. Verify WebGoat is listening: `docker compose exec kali nc -zv webgoat 8080`
    4. Test WebGoat endpoint: `docker compose exec kali curl -s http://webgoat:8080/ | head -20`
    5. Document output
    6. Teardown: `docker compose down`
  - **Implementation Notes**:
    - WebGoat starts quickly (<5 seconds)
    - Port 8080 is internal to lab3-net
    - Test: Verify connectivity from Kali to WebGoat

### Lab 4 Testing

- [ ] **9.4** Test Lab 4 startup with Windows AD (longest startup) ⚡3
  - **Depends On**: 4.4 (Lab 4 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab4 && docker compose up -d`
    2. **Wait 60+ seconds** for Windows DC to initialize (documented in README)
    3. Monitor logs: `docker compose logs dc01 | tail -20` (should see DC role initialization messages)
    4. Check health: `docker compose ps` (dc01 should show "healthy" after ~60 seconds)
    5. Verify LDAP connectivity: `docker compose exec kali ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local" -v` (should not timeout)
    6. Document: startup time, DC initialization completion time, LDAP accessibility
    7. Test Kerberos: Run basic `klist` or `krb5-config` check (optional, depends on setup)
    8. Teardown: `docker compose down`
  - **Implementation Notes**:
    - **Critical timing**: DC takes 60+ seconds; document this in README!
    - Health check: should see "starting" for 60s, then "healthy"
    - LDAP test: Confirm port 389 is responding from Kali container
    - Kerberos setup may require additional AD configuration (depends on setup_ad.sh)

### Lab 5 Testing

- [ ] **9.5** Test Lab 5 startup ⚡2
  - **Depends On**: 7.3 (Lab 5 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab5 && docker compose up -d`
    2. Wait 5 seconds, then `docker compose ps` — Target and Kali should show "Up"
    3. Scan for open ports: `docker compose exec kali nmap -p- target`
    4. Document: Open ports, services running, expected vulnerabilities
    5. Test SSH or other service: `docker compose exec kali ssh -v target` (or similar, depends on target)
    6. Teardown: `docker compose down`
  - **Implementation Notes**:
    - Target container: Vulnerable Linux distro
    - Expected services: SSH, HTTP, custom services (depends on image)
    - Nmap scan: Should reveal exploitable services

### Lab 6 Testing

- [ ] **9.6** Test Lab 6 startup (Gophish phishing tool) ⚡2
  - **Depends On**: 8.4 (Lab 6 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab6 && docker compose up -d`
    2. Wait 5 seconds, then `docker compose ps` — Gophish and Kali should show "Up"
    3. Test admin panel: `docker compose exec kali curl -s http://gophish:3333/admin/` (should return HTML)
    4. Test phishing server: `docker compose exec kali curl -s http://gophish:80/` (may return default page or redirect)
    5. Document: Admin panel accessible, phishing server running
    6. Teardown: `docker compose down`
  - **Implementation Notes**:
    - Gophish admin: port 3333 (internal)
    - Phishing pages: port 80/443 (internal)
    - Test: Verify both are accessible from Kali

### Lab 7 Testing

- [ ] **9.7** Test Lab 7 startup with OpenPLC (SCADA system) ⚡3
  - **Depends On**: 5.4 (Lab 7 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab7 && docker compose up -d`
    2. Wait 15 seconds, then check health: `docker compose ps` (OpenPLC should show "healthy")
    3. Monitor logs: `docker compose logs openplc | tail -20` (should show successful startup)
    4. Test web UI: `docker compose exec kali curl -s http://openplc:8080/ | head -20` (should return HTML)
    5. Test Modbus: `docker compose exec kali nmap -p 502 openplc` (port 502 should be open)
    6. Advanced: Use `pymodbus` to query PLC registers (optional advanced test)
    7. Document: OpenPLC startup time, web UI accessibility, Modbus port status
    8. Teardown: `docker compose down`
  - **Implementation Notes**:
    - OpenPLC startup: ~15 seconds
    - Health check: HTTP GET to port 8080
    - Modbus: Port 502 should be open/listening
    - Advanced test: `docker compose exec kali python3 -c "from pymodbus.client import ModbusTcpClient; c = ModbusTcpClient('openplc', port=502); print(c.connect())"`

### Lab 8 Testing

- [ ] **9.8** Test Lab 8 startup with all 4 services (REST API, DVWA, MySQL, Kali) ⚡4
  - **Depends On**: 6.6 (Lab 8 complete)
  - **Blocks**: 10.1 (documentation review)
  - **Acceptance Criteria**:
    1. Run `cd labs/lab8 && docker compose up -d`
    2. Wait 10 seconds, then `docker compose ps` — all containers "Up", health checks progressing
    3. Wait full 50 seconds (MySQL takes ~40s, API depends on DB)
    4. Verify health: `docker compose ps` (MySQL and API should show "healthy")
    5. Test API health endpoint: `docker compose exec kali curl http://api:5000/api/health` → `{"status": "ok"}`
    6. Test API users endpoint: `docker compose exec kali curl http://api:5000/api/users` → JSON array
    7. Test DVWA: `docker compose exec kali curl http://dvwa/login.php` (should load)
    8. Test API vulnerability: `docker compose exec kali curl "http://api:5000/api/login?user=admin' OR '1'='1"` (SQL injection test)
    9. Document: Startup time, health progression, endpoint responses, vulnerability confirmation
    10. Teardown: `docker compose down -v`
  - **Implementation Notes**:
    - Startup sequence: DB initializes (40s) → API connects to DB (10s) → DVWA ready (5s)
    - Total startup: ~50-60 seconds
    - Health checks: MySQL → API (depends on MySQL) → DVWA (depends on MySQL + API)
    - Vulnerability test: Confirm SQL injection or other vulnerability is present
    - Teardown: `-v` flag removes volumes

---

## Phase 5: Documentation & Delivery (15 points)

**Goal**: Final review, cross-platform testing spot-check, and delivery preparation.

**Completion Time**: ~1.5 hours  
**Parallelizable**: Spot-check tests can run in parallel on different platforms

### Documentation Review

- [ ] **10.1** Comprehensive documentation review — all 8 README.md files ⚡3
  - **Depends On**: 9.1–9.8 (all labs tested)
  - **Blocks**: 10.2 (cross-platform testing)
  - **Acceptance Criteria**:
    1. Read each README.md (Labs 1–8); verify all 11 template sections are complete
    2. Checklist per README:
       - Title is clear and descriptive ✓
       - Learning Objectives (3–5 bullets) present ✓
       - Prerequisites list Docker version, RAM, disk space ✓
       - Architecture section has ASCII diagram ✓
       - Quick Start section has copy-paste commands ✓
       - Expected Output section includes actual `docker compose ps` output ✓
       - Exercises (4+) include step-by-step commands ✓
       - Troubleshooting section (5+ entries) has solutions ✓
       - Testing Checklist section present ✓
       - Cleanup section with teardown commands ✓
       - Resources section has links to relevant docs ✓
    3. No broken links, valid markdown syntax
    4. No placeholder text remaining
    5. Tone is clear and student-friendly
  - **Implementation Notes**:
    - Checklist: Use the 11-section template as a guide
    - Markdown validation: `markdownlint` (if available) or manual check for `[link]` references, code blocks, etc.
    - Cross-check: Startup times documented match actual test times

- [ ] **10.2** Cross-platform spot-check — Test 2–3 labs on different OS ⚡2
  - **Depends On**: 10.1
  - **Blocks**: 10.3 (final delivery)
  - **Acceptance Criteria**:
    1. **If on macOS (Intel/Apple Silicon)**: Test Lab 1 and Lab 8 on current machine
       - Run: `cd labs/lab1 && docker compose up -d` → verify startup, verify connectivity → teardown
       - Run: `cd labs/lab8 && docker compose up -d` → verify startup with health checks → teardown
    2. **If access to Linux VM or WSL2**: Test Lab 4 (Windows AD) on Linux/WSL2
       - Run: `cd labs/lab4 && docker compose up -d` → wait 60 seconds → verify DC health → teardown
       - Note: Windows AD images may have platform-specific behavior
    3. Document any platform-specific issues or warnings
    4. Update README if needed: "Known Issues on Windows" or "Docker Desktop limitations"
  - **Implementation Notes**:
    - Spot-check: Not all labs on all platforms (time-consuming); just 2–3 labs on 1–2 platforms
    - Focus: Verify cross-platform compatibility doesn't break core functionality
    - Document: Any OS-specific issues for students (e.g., WSL2 network config)

- [ ] **10.3** Final commit and delivery verification ⚡2
  - **Depends On**: 10.2
  - **Blocks**: None (final task)
  - **Acceptance Criteria**:
    1. All files created/modified are ready for commit:
       - 8 README.md files (1 created, 7 updated)
       - 8 docker-compose.yml files (all updated)
       - Lab 4: setup_ad script (created or documented)
       - Lab 7: sample PLC program (labs/lab7/projects/sample_program.st)
       - Lab 8: app.py, Dockerfile, .env.example (3 new files)
    2. Verify git status: `git status` shows only expected files (no stray files)
    3. Quick syntax check on key files:
       - Each docker-compose.yml: `docker compose config` (no errors)
       - Each README.md: No obvious markdown errors
       - Lab 8 app.py: `python3 -m py_compile labs/lab8/api/app.py` (syntax OK)
       - Lab 8 Dockerfile: `docker build -f labs/lab8/api/Dockerfile --dry-run labs/lab8/api/` (if buildkit available)
    4. Create git commit: `git add labs/ && git commit -m "labs: correcciones-labs-docker — fix all 8 labs with current images, health checks, and documentation"`
    5. Verify commit: `git log -1 --stat` (shows all changes)
  - **Implementation Notes**:
    - Final commit: Summarize all changes in one commit message
    - Command: `git diff --cached` (review changes before commit)
    - Verify: No secrets in .env files, all sensitive data in .env.example format

- [ ] **10.4** Success criteria verification against proposal ⚡1
  - **Depends On**: 10.3
  - **Blocks**: None (final validation)
  - **Acceptance Criteria**:
    1. Cross-check against proposal success criteria (from proposal.md lines 115–127):
       - [ ] All 8 labs have current, passing README.md files — **VERIFIED** (10.1 confirms)
       - [ ] Lab 2 README.md created (was missing) — **VERIFIED** (2.1 completed)
       - [ ] Lab 4 uses Windows AD (not Juice Shop) — **VERIFIED** (4.2, 4.3 completed)
       - [ ] Lab 7 uses OpenPLC (not Mutillidae) — **VERIFIED** (5.2, 5.3 completed)
       - [ ] Lab 8 docker-compose.yml includes REST API service — **VERIFIED** (6.5 completed)
       - [ ] Labs 1, 3, 5, 6 have verified/updated image versions — **VERIFIED** (1.3, 3.1, 7.2, 8.2 completed)
       - [ ] Each lab tested: `docker compose up` runs without critical errors — **VERIFIED** (Phase 4 testing)
       - [ ] Each README includes "Expected Output" section — **VERIFIED** (10.1 checklist)
       - [ ] Each README includes troubleshooting guide — **VERIFIED** (10.1 checklist)
       - [ ] Students can follow README → run lab → see expected behavior — **VERIFIED** (testing + documentation review)
       - [ ] No breaking changes to existing lab structure — **VERIFIED** (only content/config changes, no directory/file renames)
    2. Check: All items in success criteria are marked VERIFIED
    3. If any criteria not met, identify which task(s) are missing and schedule them
  - **Implementation Notes**:
    - Proposal success criteria: Use as final validation checklist
    - If all items verified, change is ready for delivery

---

## Task Summary by Priority

### 🔴 CRITICAL (Tasks blocking overall delivery) — 20 tasks, 62 points

These tasks must be completed for the change to deliver value:

- **Lab 2 missing README** (2.1 — 4 points) — Blocks students immediately
- **Lab 4 Windows AD replacement** (4.1–4.4 — 13 points) — Major architectural change
- **Lab 7 OpenPLC SCADA replacement** (5.1–5.4 — 14 points) — Major architectural change
- **Lab 8 REST API service** (6.1–6.6 — 21 points) — New functionality, core to security testing
- **Testing for critical labs** (9.2, 9.4, 9.7, 9.8 — 10 points) — Verify critical labs work

**Priority**: Complete Phase 2 (Lab 4, 7, 8) and Phase 1 (Lab 2) first.

### 🟡 HIGH (Significantly improves student experience) — 8 tasks, 28 points

- **Lab 1, 3, 5, 6 image updates and documentation** (Phases 1 & 3)
- **Testing for standard labs** (Phase 4)

### 🟢 LOW (Nice-to-have, final polish) — 12 tasks, 15 points

- **Documentation review, cross-platform spot-check, final delivery** (Phase 5)

---

## Dependency Graph & Critical Path

```
Phase 1: Foundation (template setup)
  1.2 (README template) ─────┬─→ 1.4 (Lab 1 README)
                              ├─→ 2.1 (Lab 2 README — CRITICAL)
                              ├─→ 3.2 (Lab 3 README)
                              ├─→ 4.3 (Lab 4 README — CRITICAL)
                              ├─→ 5.3 (Lab 7 README — CRITICAL)
                              └─→ 6.6 (Lab 8 README — CRITICAL)

Phase 2: Critical Replacements (parallel after Phase 1)
  Lab 4 track: 4.1 → 4.2 → 4.3 → 4.4 ─┐
                                         ├─→ 9.4 (Lab 4 test) ─┐
  Lab 7 track: 5.1 → 5.2 → 5.3 → 5.4 ─┤                       │
                                         ├─→ 9.7 (Lab 7 test) ─┤
  Lab 8 track: 6.1 → 6.2 → 6.3 → 6.4 → 6.5 → 6.6             │
                                         ├─→ 9.8 (Lab 8 test) ─┤
                                                                 ├─→ 10.1 (Doc review) → 10.2 → 10.3 → 10.4
Phase 3: Infrastructure Updates (parallel)
  Lab 5: 7.1 → 7.2 → 7.3 ──→ 9.5 ────┤
  Lab 6: 8.1 → 8.2 → 8.3 → 8.4 → 9.6 ┤

Phase 4 & 5: Testing & Delivery
  All tests (9.1–9.8) → Documentation review (10.1–10.4)
```

**Critical Path (shortest sequential time)**:
```
1.2 [3pt] → 2.1 [4pt] → 4.1 [2pt] → 4.2 [5pt] → 4.3 [4pt] → 4.4 [2pt] → 9.4 [3pt] → 10.1 [3pt] → 10.3 [2pt] → 10.4 [1pt]
Total: 29 points, ~90 minutes sequential
```

**Parallelization Opportunity**:
- After Phase 1: Labs 4, 7, 8 can be worked in parallel (60 minutes each) → Combined: 60 minutes instead of 180
- Labs 5, 6 can follow independently (30 minutes combined)
- Testing can be parallelized (with Docker resource limits) → 60 minutes instead of 90

**Total Estimated Duration**:
- **Sequential (solo developer)**: ~3–4 hours (160–165 points ÷ 5–6 points/hour average)
- **Parallel (2 developers)**: ~2 hours (one works Lab 4 + 7, other works Lab 8 + others)

---

## Task Checklist Template

For each task, during implementation:

```markdown
## Task X.Y: [Title]

**Status**: ☐ Not Started | ⧐ In Progress | ✓ Complete

**Depends On**: [Task N.M]  
**Blocks**: [Task N.M, ...]  
**Estimated Time**: 20–30 min

### Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Implementation Notes
- **Where**: File path or directory
- **What**: Specific change or creation
- **Test Command**: Command to verify completion

### Verification
- [ ] Changes committed to git
- [ ] Test command passed
- [ ] Dependent tasks unblocked
```

---

## Resources & References

- **Design Document**: `openspec/changes/correcciones-labs-docker/design/labs.md`
- **Proposal**: `openspec/changes/correcciones-labs-docker/proposal.md`
- **Docker Docs**: https://docs.docker.com/compose/
- **Docker Health Checks**: https://docs.docker.com/compose/compose-file/compose-file-v3/#healthcheck
- **Image Registries**:
  - Kali: https://hub.docker.com/r/kalilinux/kali-rolling
  - DVWA: https://hub.docker.com/r/vulnerables/web-dvwa
  - OpenPLC: https://hub.docker.com/r/openplcproject/openplc-v3
  - Windows Server: https://hub.docker.com/_/microsoft-windows-servercore

---

## Summary

| Phase | Tasks | Points | Focus | Est. Time |
|-------|-------|--------|-------|-----------|
| **1: Foundation** | 8 | 28 | Lab 1–3 setup, template | 2 hr |
| **2: Critical Replacements** | 20 | 62 | Lab 4 AD, Lab 7 OpenPLC, Lab 8 API | 4–5 hr |
| **3: Infrastructure** | 12 | 35 | Lab 5–6 updates | 2 hr |
| **4: Testing** | 20 | 25 | Functional validation | 3–4 hr |
| **5: Delivery** | 12 | 15 | Review + commit | 1.5 hr |
| **TOTAL** | **72** | **165** | All 8 labs corrected | **3–4 days** |

**Next Step**: Ready for implementation (sdd-apply). Follow task phases in order; parallelize where possible to reduce wall-clock time.

---

**Generated**: 2026-03-06  
**Change**: correcciones-labs-docker  
**Document**: openspec/changes/correcciones-labs-docker/tasks.md
