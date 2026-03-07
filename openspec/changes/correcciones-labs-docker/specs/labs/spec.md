# Delta for Labs Docker (Correcciones)

## Related Prior Specs

Prior spec: `openspec/specs/labs/spec.md` — Defines overall labs structure requirements, Docker architecture, health checks, resource management, cross-platform compatibility.

Learning from prior spec:
- Labs MUST have clear learning objectives, prerequisites, architecture diagrams, quick start, detailed exercises, troubleshooting
- Each lab SHOULD have health checks for multi-service setups
- Resource limits (memory) MUST be specified to prevent system overload
- Services MUST start within 10 seconds for good UX
- All labs SHOULD be testable on Linux, macOS (Intel + ARM), Windows (WSL2)
- docker-compose.yml files MUST validate without errors
- Image versions SHOULD be pinned (not `latest`) to ensure reproducibility

Engram search for "docker labs fix OR deprecated images": No prior corrections found.

---

## ADDED Requirements

### Requirement: Lab-Specific Learning Objectives & Expected Behavior

Each lab MUST explicitly define what services run, on which ports, and what students should see after successful execution.

#### Scenario: Lab 1 — Network Reconnaissance

- GIVEN Lab 1 README describes network reconnaissance with Nmap
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab1-kali` container (172.18.1.10) ready for interactive bash
  - `lab1-metasploitable2` container (172.18.1.20) with vulnerable services
- AND Ports accessible from within kali:
  - 21 (FTP), 22 (SSH), 23 (Telnet), 25 (SMTP), 80 (HTTP)
  - 139/445 (SMB), 3306 (MySQL), 8080 (Tomcat)
- AND Student can ping metasploitable2: `ping 172.18.1.20` returns 0% packet loss
- AND Student can nmap scan: `nmap 172.18.1.20` returns open ports matching exposed list

#### Scenario: Lab 2 — Web Application Testing Tools

- GIVEN Lab 2 README is created (currently missing) describing web app testing
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab2-dvwa` container (172.18.2.10) accessible on port 80
  - `lab2-db` container (172.18.2.20) with MySQL initialized
  - `lab2-kali` container (172.18.2.30) with web testing tools
- AND Web app accessible: `curl http://172.18.2.10` returns HTTP 200 with DVWA login page
- AND Database ready: `docker compose logs db | grep "ready for connections"`
- AND Student can run security tools from kali: `docker compose exec lab2-kali bash -c "which sqlmap burpsuite zap"`

#### Scenario: Lab 3 — Vulnerability Scanning (OWASP WebGoat)

- GIVEN Lab 3 README describes vulnerability scanning concepts
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab3-webgoat` container accessible on port 8080
  - Port 8080 ready: `curl http://172.18.3.10:8080` returns HTTP 200
- AND WebGoat lessons load: Student can browse lessons in browser
- AND Student can verify in kali: `docker compose exec lab3-kali nmap -p 8080 172.18.3.10` shows open

#### Scenario: Lab 4 — Windows Active Directory Exploitation (Fixed)

- GIVEN Lab 4 README describes Windows AD exploitation, Kerberoasting, Pass-the-Hash
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab4-dc01` Windows Server Domain Controller (172.18.4.10, port 389, 636, 3389)
  - `lab4-kali` container (172.18.4.20) with AD tools (impacket, Kerberoasting scripts)
  - `lab4-member-server` optional member server for testing (172.18.4.30)
- AND Active Directory responding:
  - LDAP connectivity: `ldapsearch -x -H ldap://172.18.4.10 -b "dc=lab,dc=local" | head`
  - Kerberos: `nslookup -type=SRV _kerberos._tcp.dc._msdcs.lab.local 172.18.4.10`
- AND Kali can enumerate: `docker compose exec lab4-kali impacket-GetNPUsers lab.local/ -no-pass`
- AND docker-compose.yml uses Windows Server image (e.g., mcr.microsoft.com/windows/servercore with AD-DS role)

#### Scenario: Lab 5 — Linux Privilege Escalation (Vulnerable Box)

- GIVEN Lab 5 README describes Linux privilege escalation techniques
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab5-target` vulnerable Linux container (172.18.5.10) with priv-esc vulnerabilities
  - `lab5-kali` container (172.18.5.20) with exploitation tools
- AND Target vulnerable services running:
  - SSH open on port 22 (weak credentials or priv-esc paths)
  - HTTP service on port 80 or 8080
  - Misconfigured sudo, SUID binaries, or kernel vulnerabilities documented in README
- AND Student can SSH in: `docker compose exec lab5-kali ssh -o StrictHostKeyChecking=no user@172.18.5.10` (credentials in README)
- AND Documented priv-esc path: "User 'user' can escalate via sudo -l, find binaries, or kernel CVE XXXX"

#### Scenario: Lab 6 — Social Engineering & Phishing Tools

- GIVEN Lab 6 README describes social engineering techniques (Gophish, evilginx2, etc.)
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab6-gophish` phishing server (172.18.6.10, port 3333 admin, 80 for phishing page)
  - `lab6-kali` container (172.18.6.20) with social engineering tools
  - `lab6-apache` landing page server (172.18.6.30, port 80) optional
- AND Gophish accessible: `curl http://172.18.6.10:3333` returns login or admin page
- AND Student can create phishing campaigns from kali: `docker compose exec lab6-kali bash` → use gophish API/CLI
- AND Example phishing emails and templates documented in README

#### Scenario: Lab 7 — ICS/SCADA with OpenPLC (Fixed)

- GIVEN Lab 7 README describes ICS/SCADA security, PLC control, Modbus/OPC-UA protocols
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab7-openplc` OpenPLC runtime (172.18.7.10, port 8080 web, 502 Modbus, 1102 OPC-UA)
  - `lab7-kali` container (172.18.7.20) with ICS tools (s7scan, modbus-cli, nessus plugins)
  - `lab7-plc-simulator` optional PLC ladder logic simulator
- AND OpenPLC web UI accessible: `curl http://172.18.7.10:8080` returns login page
- AND Modbus service open: `docker compose exec lab7-kali nc -zv 172.18.7.10 502` shows "succeeded"
- AND Student can scan with s7scan or modbus tools: `docker compose exec lab7-kali modbus-cli 172.18.7.10 502`
- AND docker-compose.yml uses openplcproject/openplc-v3 image

#### Scenario: Lab 8 — REST API Security Testing (Fixed)

- GIVEN Lab 8 README describes REST API security, authentication bypass, injection in APIs
- WHEN Student runs `docker compose up -d`
- THEN Services visible:
  - `lab8-dvwa` web app (172.18.8.10, port 80)
  - `lab8-db` MySQL database (172.18.8.20)
  - `lab8-api` REST API service (172.18.8.30, port 5000 or 3000) — NEW requirement
  - `lab8-kali` container (172.18.8.40) with API testing tools
- AND All services responding:
  - DVWA: `curl http://172.18.8.10` returns HTTP 200
  - API: `curl http://172.18.8.30:5000/api/health` or `curl http://172.18.8.30:3000/api/status` returns 200
  - Database: `docker compose logs db | grep "ready"`
- AND API endpoints documented in README:
  - Example: GET /api/users, POST /api/login, GET /api/products
  - Vulnerable endpoints listed: missing auth, SQL injection, insecure deserialization, etc.
- AND Student can test from kali: `docker compose exec lab8-kali curl -s http://lab8-api:5000/api/users | jq`

---

### Requirement: README.md Structure with Clear Learning Objectives

Each lab README MUST follow a standardized structure with explicit learning objectives, prerequisites, expected behavior, and troubleshooting.

#### Scenario: Lab README sections

- GIVEN `docker-labs/labN/README.md`
- WHEN Student reads the file
- THEN MUST contain sections in order:
  1. `# Lab N: {Clear Title}` — e.g., "Lab 1: Network Reconnaissance with Nmap"
  2. `## Learning Objectives` — 3-5 bullet points: "After completing this lab, you will..."
  3. `## Prerequisites` — Docker version, ports available, 16GB RAM, etc.
  4. `## Architecture` — Text description of containers and network (e.g., "Three containers: Kali attacker, Metasploitable target, network 172.18.1.0/24")
  5. `## Quick Start` — Exact commands:
     ```bash
     cd docker-labs/labN
     docker compose up -d
     docker compose ps
     ```
  6. `## Expected Output` — What success looks like (list of containers RUNNING, exact port numbers)
  7. `## Detailed Exercises` — 4-8 step-by-step exercises with exact commands and expected output
  8. `## Troubleshooting` — 5+ common errors (image not found, port conflict, container exits) with solutions
  9. `## Testing Checklist` — Verify all objectives:
     - [ ] All containers running: `docker compose ps`
     - [ ] Network connectivity: [specific commands per lab]
     - [ ] Services responsive: [specific port/service checks]
  10. `## Cleanup` — Commands to teardown:
      ```bash
      docker compose down
      docker compose down -v  # with volumes
      ```
  11. `## Resources` — Links to docs, writeups, CVE references

#### Scenario: Lab 1 README expected output example

- GIVEN Lab 1 README, "Expected Output" section
- WHEN Student runs `docker compose ps`
- THEN Output shows:
  ```
  CONTAINER ID  IMAGE                           NAMES            STATUS
  <id>          kalilinux/kali-rolling          lab1-kali        Up 2 seconds
  <id>          tutum/metasploitable:latest     lab1-metasploitable  Up 2 seconds
  ```
- AND README explicitly states: "Both containers should be running. If either shows 'Exited', check troubleshooting section."

---

### Requirement: Accurate Service Definitions & Image Versions

Each docker-compose.yml MUST define correct services with current, stable image versions (not `latest` tag).

#### Scenario: Lab 4 docker-compose.yml uses Windows AD (not Juice Shop)

- GIVEN Lab 4 proposal says "Fix Lab 4 to use Windows AD, not Juice Shop"
- WHEN docker-compose.yml is reviewed
- THEN MUST include service definitions:
  - `dc01` — Windows Server DC (image: mcr.microsoft.com/windows/servercore:ltsc2022)
    - Port 389 (LDAP), 636 (LDAPS), 3389 (RDP)
    - Env: AD domain name, admin password
    - Exposed to kali container only (no host port mapping)
  - `kali` — Kali Linux with AD tools (impacket, BloodHound, Kerberoasting)
  - REMOVED: `juice-shop` service (no longer present)
- AND Services verified: `docker compose config` shows no errors
- AND Start command: `docker compose up -d` brings up DC and Kali without hanging

#### Scenario: Lab 7 docker-compose.yml uses OpenPLC (not Mutillidae)

- GIVEN Lab 7 proposal says "Fix Lab 7 to use OpenPLC for ICS/SCADA, not Mutillidae"
- WHEN docker-compose.yml is reviewed
- THEN MUST include:
  - `openplc` — OpenPLC runtime (image: openplcproject/openplc-v3)
    - Port 8080 (web UI)
    - Port 502 (Modbus TCP)
    - Port 1102 (OPC-UA)
    - Volume: `/root/OpenPLC_v3/projects` for persistence
  - `kali` — Kali with ICS tools (s7scan, modbus-cli, etc.)
  - REMOVED: `mutillidae` service (no longer present)

#### Scenario: Lab 8 docker-compose.yml includes REST API service

- GIVEN Lab 8 proposal says "Add REST API service to Lab 8"
- WHEN docker-compose.yml is reviewed
- THEN MUST include new service:
  - `api` — REST API (image: e.g., `nlohmann/json_server`, custom Flask app, or `kennethreitz/httpbin`)
    - Port 5000 or 3000 (depending on image choice)
    - Network: `lab8-net` at 172.18.8.30
    - Environment: API keys, database connection string
    - Example endpoints: GET /api/users, POST /api/login, GET /api/products
  - Existing services (dvwa, db, kali) remain but updated
  - docker-compose.yml documents: "API service added to teach REST security concepts"

#### Scenario: Image versions pinned (not `latest`)

- GIVEN Labs 1, 3, 5, 6 docker-compose.yml files
- WHEN Images are reviewed
- THEN MUST NOT use `latest` tag; instead:
  - Lab 1 kali: `kalilinux/kali-rolling` (or specific date tag `2025.1`)
  - Lab 1 metasploitable: Pin to `tutum/metasploitable:latest` → `tutum/metasploitable:v2`
  - Lab 3 webgoat: `webgoat/webgoat-8.0:latest` → specific version
  - Lab 5 target: Use specific vulnerable Linux version
  - Lab 6 gophish: Pin Gophish version (e.g., `gophish:0.12.1`)

---

### Requirement: Health Checks for Multi-Service Labs

Labs with database or dependent services MUST include health checks.

#### Scenario: Lab 2 database health check

- GIVEN Lab 2 docker-compose.yml with `db` service
- WHEN docker-compose.yml is reviewed
- THEN `db` service includes:
  ```yaml
  healthcheck:
    test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
    interval: 10s
    timeout: 5s
    retries: 3
    start_period: 40s
  ```
- AND DVWA service depends_on: `db` with `condition: service_healthy`
- AND README documents: "Database takes ~40 seconds to initialize on first run"

#### Scenario: Lab 8 API health check

- GIVEN Lab 8 docker-compose.yml with `api` service
- WHEN docker-compose.yml is reviewed
- THEN `api` service includes:
  ```yaml
  healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost:5000/api/health"]
    interval: 15s
    timeout: 5s
    retries: 3
    start_period: 30s
  ```
- AND Kali service depends_on: `api` with `condition: service_healthy`

---

### Requirement: Test Scenarios with Expected Behavior

Each lab MUST include a detailed "Test Scenario" in README showing step-by-step verification.

#### Scenario: Lab 1 test scenario documented in README

- GIVEN Lab 1 README, "Testing Checklist" section
- WHEN Student follows the checklist
- THEN Steps verify:
  1. All containers running:
     ```bash
     docker compose ps
     # Expected: lab1-kali and lab1-metasploitable both "Up X seconds"
     ```
  2. Network connectivity within containers:
     ```bash
     docker compose exec kali ping 172.18.1.20
     # Expected: "64 bytes from 172.18.1.20: icmp_seq=1 ttl=64 time=0.XXX ms"
     ```
  3. Nmap finds open ports:
     ```bash
     docker compose exec kali nmap -sS -F 172.18.1.20
     # Expected: "PORT    STATE SERVICE"
     #           "21/tcp  open  ftp"
     #           "22/tcp  open  ssh"
     ```
  4. Success criteria met:
     - [ ] Ping succeeds
     - [ ] Nmap finds ≥5 open ports (21, 22, 23, 25, 80, 139, 445, 3306, 8080)
     - [ ] No container exits unexpectedly

---

### Requirement: Comprehensive Troubleshooting Guides

Each README MUST include troubleshooting section with solutions for common errors.

#### Scenario: Lab 1 troubleshooting examples

- GIVEN Lab 1 README, "Troubleshooting" section
- WHEN Student encounters error X
- THEN README lists:
  1. **Error**: "docker compose up hangs or containers exit immediately"
     - Cause: Image not found, insufficient disk space, or Docker daemon issues
     - Solution: Run `docker pull tutum/metasploitable:latest kalilinux/kali-rolling`, verify `docker ps`, restart Docker
  2. **Error**: "Cannot ping between containers (no route to host)"
     - Cause: Network not created or misconfigured
     - Solution: `docker network inspect lab1-net` should show both containers; if not, run `docker compose down && docker compose up -d`
  3. **Error**: "Nmap reports all ports closed"
     - Cause: Metasploitable not fully started or listening
     - Solution: Wait 10-15 seconds after `docker compose up`, then retry nmap
  4. **Error**: "Permission denied running nmap"
     - Cause: Kali container not run with proper privileges
     - Solution: Verify docker-compose.yml has `privileged: true` for kali service
  5. **Error**: "Cannot access from host, only container-to-container works"
     - Cause: Docker internal network doesn't expose to host by default (correct behavior)
     - Solution: "This is expected—kali and metasploitable communicate internally. To access from host, add port mappings or use `docker compose exec`"

#### Scenario: Lab 4 troubleshooting for Windows AD

- GIVEN Lab 4 README with Windows AD services
- WHEN Student encounters issues
- THEN Troubleshooting includes:
  1. **Error**: "Domain controller container won't start"
     - Solution: Check Docker Windows integration enabled, check event logs: `docker compose logs dc01`
  2. **Error**: "Kali cannot connect to DC on port 389"
     - Solution: Verify DC is listening: `docker compose exec dc01 netstat -ano | find "389"`, verify network: `docker network inspect lab4-net`
  3. **Error**: "Kerberoasting returns no results"
     - Solution: Domain may not be fully initialized; wait 60-90 seconds after `docker compose up`, verify DC booted: `docker compose logs dc01 | grep "ready"`

---

### Requirement: Port & Resource Specification

Each lab MUST document port usage, resource requirements, and startup time.

#### Scenario: Lab ports explicitly mapped or exposed

- GIVEN Lab README "Architecture" or "Ports" section
- WHEN Listing what ports are used
- THEN Clearly state:
  - Lab 1: Ports 21, 22, 23, 25, 80, 139, 445, 3306, 8080 **internal only** (container-to-container)
  - Lab 2: Port 80 **internal** (DVWA), port 3306 **internal** (MySQL)
  - Lab 3: Port 8080 **can be mapped to host** for browser access (e.g., `-p 8080:8080` if needed)
  - Lab 4: Ports 389, 636, 3389 **internal** (AD); student accesses via RDP from kali
  - Lab 7: Port 8080 **can be mapped to host** for OpenPLC web UI
  - Lab 8: Port 5000/3000 **internal** (API); port 80 **internal** (DVWA); optionally map to host for testing

#### Scenario: Lab resource requirements documented

- GIVEN Lab README "Prerequisites" section
- WHEN Student reviews requirements
- THEN MUST specify:
  - Lab 1: 3GB RAM, 5GB disk (Kali + Metasploitable images ~2-3GB)
  - Lab 2: 3GB RAM, 4GB disk (DVWA + MySQL)
  - Lab 3: 2.5GB RAM, 2.5GB disk (WebGoat)
  - Lab 4: 4-6GB RAM, 6-8GB disk (Windows Server image is large)
  - Lab 5: 2GB RAM, 3GB disk (Linux target + Kali)
  - Lab 6: 3GB RAM, 2GB disk (Phishing tools)
  - Lab 7: 2.5GB RAM, 3GB disk (OpenPLC)
  - Lab 8: 3.5GB RAM, 5GB disk (DVWA + MySQL + API + Kali)
  - Total across all labs: ~27GB disk, ~25GB RAM if all running simultaneously

#### Scenario: Lab startup time documented

- GIVEN Lab README "Quick Start" section
- WHEN Student runs `docker compose up -d`
- THEN README states:
  - Lab 1: ~3 seconds to start, services ready immediately
  - Lab 2: ~5-10 seconds (MySQL needs init time), documented: "Wait 10 seconds after `docker compose up` before testing database"
  - Lab 3: ~5 seconds
  - Lab 4: ~30-60 seconds (Windows AD DC takes longer to boot)
  - Lab 5: ~3-5 seconds
  - Lab 6: ~5 seconds
  - Lab 7: ~10-15 seconds (OpenPLC initializes PLC runtime)
  - Lab 8: ~15-20 seconds (multiple services: DVWA, MySQL, API, Kali)

---

### Requirement: Non-Functional: Cross-Platform Compatibility

Labs MUST be verified to work on macOS, Linux, and Windows (WSL2).

#### Scenario: Labs work on macOS (Intel & ARM)

- GIVEN Lab docker-compose.yml
- WHEN Pulled and run on macOS (Intel or Apple Silicon)
- THEN All containers start and services work
- AND README notes any platform-specific issues: "Note: On Apple Silicon, use Docker Desktop with appropriate image architecture"

#### Scenario: Labs work on Linux

- GIVEN Lab docker-compose.yml
- WHEN Run on Ubuntu 20.04+ with Docker 20.10+
- THEN All containers start without issue
- AND Port mappings work correctly
- AND Volume mounts have correct permissions

#### Scenario: Labs work on Windows with WSL2

- GIVEN Lab docker-compose.yml
- WHEN Run on Windows 10/11 with Docker Desktop + WSL2
- THEN All containers start
- AND README notes: "Ensure Docker Desktop is configured with WSL2 backend"
- AND Volume paths use WSL2 conventions (may need `/mnt/c/...` for Windows paths)

---

### Requirement: Documentation Completeness Check

README.md files MUST pass completeness validation.

#### Scenario: README completeness validation

- GIVEN Lab README.md
- WHEN Validation script checks
- THEN MUST contain all sections:
  - ✅ Title with lab number
  - ✅ Learning objectives (3-5 items)
  - ✅ Prerequisites
  - ✅ Architecture
  - ✅ Quick start with commands
  - ✅ Expected output
  - ✅ Detailed exercises (4-8 steps)
  - ✅ Troubleshooting (5+ issues)
  - ✅ Testing checklist
  - ✅ Cleanup commands
  - ✅ Resources/references
- AND No section is empty or placeholder text only
- AND Code blocks use proper markdown syntax with language identifier (```bash, ```yaml, etc.)

---

## MODIFIED Requirements

### Requirement: Lab 1 README.md (Previously Existed, Needs Update)

The existing Lab 1 README is mostly functional but needs:
- Verification that image versions are current
- Addition of "Expected Output" section with actual test results
- Expanded troubleshooting section
- Addition of "Testing Checklist" section

(Previously: General structure exists but missing specific output examples)

#### Scenario: Lab 1 README updated with expected output

- GIVEN Existing Lab 1 README
- WHEN Updated with test results
- THEN Adds new sections:
  - Expected output from `docker compose ps`
  - Sample nmap output showing open ports
  - Sample `docker compose logs` output for verification

### Requirement: Lab 2 README.md (Currently Missing, Now Added)

Lab 2 did not have a README.md file. This requirement specifies creation from scratch.

(Previously: File did not exist)

#### Scenario: Lab 2 README created

- GIVEN No Lab 2 README currently exists
- WHEN Created following standard template
- THEN New file includes all standard sections per "README.md Structure" requirement above

### Requirement: Lab 3 README.md (Updated)

Lab 3 README needs verification of WebGoat version and expected output documentation.

#### Scenario: Lab 3 WebGoat version verified and documented

- GIVEN Lab 3 docker-compose.yml and README
- WHEN Reviewed
- THEN Updates:
  - Confirm image version (e.g., `webgoat/webgoat-8.0:2025.1`)
  - Document how to access WebGoat from browser
  - Add expected output: "WebGoat login page should load on http://172.18.3.10:8080 within 5 seconds"

### Requirement: Lab 4 Applications Replaced (Juice Shop → Windows AD)

Lab 4 currently uses OWASP Juice Shop (wrong application for Active Directory lab). This requirement replaces it with proper Windows AD setup.

(Previously: Lab 4 defined incorrect application)

#### Scenario: Lab 4 uses Windows AD, not Juice Shop

- GIVEN Current Lab 4 docker-compose.yml uses `bkimminich/juice-shop`
- WHEN Updated per proposal
- THEN Changes:
  - Remove: `juice-shop` service entirely
  - Add: `dc01` Windows Server Domain Controller
  - Add: Appropriate AD configuration (domain name, admin credentials, OUs)
  - Update README: Describe AD exploitation, not web app security
  - Update objectives: Kerberoasting, Pass-the-Hash, etc.

### Requirement: Lab 5 README.md (Updated)

Lab 5 needs verification of vulnerable target image and privilege escalation paths.

#### Scenario: Lab 5 vulnerable target verified

- GIVEN Lab 5 docker-compose.yml with vulnerable Linux target
- WHEN Reviewed
- THEN README specifies:
  - Exact vulnerabilities available: "User can escalate via CVE-XXXX in Apache" or "SUID binary misconfiguration in /opt/bin"
  - Documented priv-esc path: "Login as 'user' with password 'user123', then: find / -perm -4000 2>/dev/null"
  - Expected result: "Privilege escalation to root"

### Requirement: Lab 6 README.md (Updated)

Lab 6 needs clarification of phishing tools and expected behavior.

#### Scenario: Lab 6 phishing tools documented

- GIVEN Lab 6 README
- WHEN Updated
- THEN Specifies:
  - Which phishing tool is installed (Gophish, evilginx2, etc.)
  - How to create phishing campaign: "docker compose exec lab6-gophish bash → gophish commands..."
  - Where phishing pages are served
  - How to track clicks/submissions

### Requirement: Lab 7 Applications Replaced (Mutillidae → OpenPLC)

Lab 7 currently uses Mutillidae (web app, wrong for ICS/SCADA). This requirement replaces with OpenPLC.

(Previously: Lab 7 defined incorrect application)

#### Scenario: Lab 7 uses OpenPLC, not Mutillidae

- GIVEN Current Lab 7 docker-compose.yml uses `vulnerables/mutillidae`
- WHEN Updated per proposal
- THEN Changes:
  - Remove: `mutillidae` service entirely
  - Add: `openplc` service (openplcproject/openplc-v3)
  - Add: Ports 8080 (web), 502 (Modbus), 1102 (OPC-UA)
  - Update README: Describe ICS/SCADA concepts, PLC control, Modbus protocol
  - Update objectives: Scan PLCs, Modbus attacks, SCADA security

### Requirement: Lab 8 Services Updated (Missing API Service Added)

Lab 8 currently has DVWA + MySQL + Kali. This requirement adds a REST API service for API security testing.

(Previously: Lab 8 incomplete, missing API component)

#### Scenario: Lab 8 includes REST API service

- GIVEN Current Lab 8 docker-compose.yml with DVWA, MySQL, Kali
- WHEN Updated per proposal
- THEN Changes:
  - Add new service: `api` (REST API container)
  - API service on port 5000 or 3000
  - API includes example endpoints with vulnerabilities
  - Update README: Add API security exercises
  - Update objectives: Include API testing, authentication bypass, injection in APIs

---

## REMOVED Requirements

(None — this change only adds/modifies labs, does not remove any existing requirements)

---

## Test Scenarios by Lab

### TEST: Lab 1 Network Reconnaissance

```
PRECONDITION: Docker Compose installed, 3GB RAM available, 5GB disk

1. RUN: cd docker-labs/lab1 && docker compose up -d
   Expected: Terminal shows no errors, returns to prompt

2. WAIT: 3 seconds

3. CHECK: docker compose ps
   Expected Output:
   CONTAINER ID  IMAGE                           NAMES            STATUS
   <id>          kalilinux/kali-rolling          lab1-kali        Up 3 seconds
   <id>          tutum/metasploitable:latest     lab1-metasploitable  Up 3 seconds

4. VERIFY NETWORK: docker compose exec kali ping -c 2 172.18.1.20
   Expected Output:
   PING 172.18.1.20 (172.18.1.20) 56(84) bytes of data.
   64 bytes from 172.18.1.20: icmp_seq=1 ttl=64 time=0.123 ms
   64 bytes from 172.18.1.20: icmp_seq=2 ttl=64 time=0.098 ms
   --- 172.18.1.20 statistics ---
   2 packets transmitted, 2 received, 0% packet loss

5. VERIFY NMAP: docker compose exec kali nmap -sS -F 172.18.1.20
   Expected Output:
   Starting Nmap 7.94 ( https://nmap.org )
   Nmap scan report for metasploitable2 (172.18.1.20)
   Host is up (0.00012s latency).
   Not shown: 96 closed tcp ports (reset)
   PORT    STATE SERVICE
   21/tcp  open  ftp
   22/tcp  open  ssh
   23/tcp  open  telnet
   25/tcp  open  smtp
   ...

6. SUCCESS CRITERIA:
   ✅ Both containers running (docker compose ps shows 2 running)
   ✅ Network connectivity: 0% packet loss
   ✅ Nmap finds ≥5 open ports
   ✅ No container exits unexpectedly

7. CLEANUP: docker compose down
```

### TEST: Lab 2 Web Application Testing

```
PRECONDITION: Docker Compose, 3GB RAM, 4GB disk

1. RUN: cd docker-labs/lab2 && docker compose up -d
   Expected: No errors

2. WAIT: 10 seconds (MySQL initialization)

3. CHECK: docker compose ps
   Expected Output:
   CONTAINER ID  IMAGE              NAMES            STATUS
   <id>          vulnerables/web-dvwa  lab2-dvwa     Up 10 seconds (healthy)
   <id>          mariadb:10.5       lab2-db          Up 10 seconds (healthy)
   <id>          kalilinux/kali-rolling lab2-kali   Up 10 seconds

4. VERIFY WEB: docker compose exec kali curl -I http://lab2-dvwa:80
   Expected Output:
   HTTP/1.1 200 OK
   Content-Type: text/html; charset=UTF-8

5. VERIFY DB: docker compose logs db | grep "ready"
   Expected Output: "...ready for connections"

6. SUCCESS CRITERIA:
   ✅ All 3 containers running
   ✅ DVWA responds with HTTP 200
   ✅ Database is healthy
   ✅ Kali can access both services

7. CLEANUP: docker compose down
```

### TEST: Lab 3 Vulnerability Scanning

```
1. RUN: cd docker-labs/lab3 && docker compose up -d
2. WAIT: 5 seconds
3. CHECK: docker compose ps
   Expected: lab3-webgoat running, lab3-kali running
4. VERIFY: docker compose exec kali curl -I http://lab3-webgoat:8080
   Expected: HTTP 200
5. SUCCESS: All containers up, WebGoat responds
6. CLEANUP: docker compose down
```

### TEST: Lab 4 Windows AD Exploitation

```
1. RUN: cd docker-labs/lab4 && docker compose up -d
2. WAIT: 60 seconds (Windows DC initialization)
3. CHECK: docker compose ps
   Expected: lab4-dc01 (UP), lab4-kali (UP)
4. VERIFY AD: docker compose logs dc01 | grep "ready"
5. VERIFY LDAP: docker compose exec kali ldapsearch -x -H ldap://lab4-dc01
   Expected: LDAP connection succeeds
6. SUCCESS: DC initialized, Kali can connect to AD
7. CLEANUP: docker compose down
```

### TEST: Lab 5 Linux Privilege Escalation

```
1. RUN: cd docker-labs/lab5 && docker compose up -d
2. WAIT: 3 seconds
3. CHECK: docker compose ps
   Expected: lab5-target (UP), lab5-kali (UP)
4. VERIFY SSH: docker compose exec lab5-kali ssh -o StrictHostKeyChecking=no user@lab5-target -c "whoami"
   Expected: "user"
5. VERIFY PRIV-ESC: docker compose exec lab5-kali ssh -o StrictHostKeyChecking=no user@lab5-target -c "sudo -l"
   Expected: Output shows sudo access or SUID binaries
6. SUCCESS: User can SSH, privilege escalation path visible
7. CLEANUP: docker compose down
```

### TEST: Lab 6 Social Engineering

```
1. RUN: cd docker-labs/lab6 && docker compose up -d
2. WAIT: 5 seconds
3. CHECK: docker compose ps
   Expected: lab6-gophish (UP), lab6-kali (UP)
4. VERIFY GOPHISH: docker compose exec kali curl -I http://lab6-gophish:3333
   Expected: HTTP 200 or 302 (redirect to login)
5. SUCCESS: Gophish admin accessible
6. CLEANUP: docker compose down
```

### TEST: Lab 7 ICS/SCADA with OpenPLC

```
1. RUN: cd docker-labs/lab7 && docker compose up -d
2. WAIT: 15 seconds (OpenPLC initialization)
3. CHECK: docker compose ps
   Expected: lab7-openplc (UP), lab7-kali (UP)
4. VERIFY OPENPLC: docker compose exec kali curl -I http://lab7-openplc:8080
   Expected: HTTP 200
5. VERIFY MODBUS: docker compose exec kali nc -zv lab7-openplc 502
   Expected: "succeeded" or "Connection successful"
6. SUCCESS: OpenPLC web UI and Modbus port responding
7. CLEANUP: docker compose down
```

### TEST: Lab 8 REST API Security

```
1. RUN: cd docker-labs/lab8 && docker compose up -d
2. WAIT: 20 seconds (all services initialization)
3. CHECK: docker compose ps
   Expected: lab8-dvwa (UP), lab8-db (UP), lab8-api (UP), lab8-kali (UP)
   Expected: All show "(healthy)" or "Up XX seconds"
4. VERIFY API: docker compose exec lab8-kali curl -I http://lab8-api:5000/api/status
   Expected: HTTP 200 or similar
5. VERIFY WEB: docker compose exec lab8-kali curl -I http://lab8-dvwa:80
   Expected: HTTP 200
6. SUCCESS: DVWA, API, and database all responding
7. CLEANUP: docker compose down
```

---

## Non-Functional Requirements

### Requirement: Image Stability & Availability

**All Docker images MUST be available on public registries and have stable versions.**

- Official images preferred: kalilinux/kali-rolling, mariadb, webgoat/webgoat-8.0
- No deprecated or removed images
- Version tags pinned (not `latest` unless explicitly intended)
- Tested pulls before submission: `docker pull <image>` must succeed

### Requirement: Startup Time ≤ 20 seconds

**All labs MUST have all services ready within 20 seconds of `docker compose up`.**

- Lab 1-3, 5-6: ≤ 5 seconds
- Lab 4: ≤ 60 seconds (Windows AD is slower)
- Lab 7: ≤ 15 seconds
- Lab 8: ≤ 20 seconds

### Requirement: No Port Conflicts

**Labs MUST use isolated Docker networks (no host port mapping unless documented).**

- Each lab has unique network subnet (lab1-net: 172.18.1.0/24, lab2-net: 172.18.2.0/24, etc.)
- Internal container communication only (no `-p` host port mappings except optional for web UI access)
- If optional host mappings needed, documented in README

### Requirement: Cross-Platform Support

**Labs MUST work on:**

- ✅ Ubuntu 20.04+ (Docker Engine)
- ✅ macOS 11+ (Intel + Apple Silicon, Docker Desktop)
- ✅ Windows 10/11 (WSL2 + Docker Desktop)

No platform-specific hardcoding; use relative paths and Docker Compose variables.

### Requirement: Resource Boundaries

**Each lab MUST specify memory limits to prevent host system overload.**

- `deploy.resources.limits.memory` set for all services
- `deploy.resources.reservations.memory` set appropriately
- Total per lab ≤ 4GB (Lab 4 may be 6GB max for Windows)

### Requirement: Security (No Credentials in Code)

**Sensitive data MUST NOT be hardcoded in docker-compose.yml.**

- Default credentials documented in README, not in YAML
- Environment variables used (e.g., `${ADMIN_PASSWORD}`)
- .env files optional but .env.example provided

---

## Success Criteria Checklist

- [ ] All 8 labs have current, passing README.md files (verified by reading)
- [ ] Lab 2 README.md created (was missing)
- [ ] Lab 4 uses Windows AD (not Juice Shop); docker-compose.yml verified
- [ ] Lab 7 uses OpenPLC (not Mutillidae); docker-compose.yml verified
- [ ] Lab 8 docker-compose.yml includes REST API service
- [ ] Labs 1, 3, 5, 6 have verified/updated image versions
- [ ] All docker-compose.yml files pass `docker compose config` validation
- [ ] Each lab tested locally: `docker compose up` runs without critical errors
- [ ] Each README includes "Expected Output" section matching actual test results
- [ ] Each README includes troubleshooting guide (≥5 issues)
- [ ] Each README includes testing checklist
- [ ] Health checks configured for multi-service labs
- [ ] All labs work on macOS (Intel + ARM), Linux, Windows (WSL2)
- [ ] Resource limits configured for all services
- [ ] Startup times documented and meet requirements (≤20 seconds)
- [ ] No host port conflicts (isolated Docker networks)
- [ ] Students can follow README → run lab → see expected behavior without confusion
- [ ] No breaking changes to existing lab structure (directories, file names unchanged)

---

## Summary

This delta specification ensures that each of the 8 Docker labs is:
1. **Correctly configured** (right apps, services, images)
2. **Clearly documented** (learning objectives, prerequisites, expected output)
3. **Testable** (step-by-step test scenarios with expected results)
4. **Troubleshoot-friendly** (common errors + solutions)
5. **Cross-platform** (macOS, Linux, Windows)
6. **Reliable** (health checks, resource limits, startup guarantees)

Implementation will follow these specs exactly, validating each lab before marking complete.
