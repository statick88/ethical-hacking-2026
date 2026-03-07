# Design: Correcciones Labs Docker

## Technical Approach

This design addresses the 8 critical Docker lab issues identified in the proposal by specifying exact implementations for each lab's docker-compose.yml, README.md structure, and health checks. The approach follows a **standardized template for all READMEs** while accommodating **lab-specific technical choices** for the three most critical fixes (Lab 4: Windows AD, Lab 7: OpenPLC, Lab 8: REST API).

Each lab will:
1. Use a standard README.md template (sections: Title, Objectives, Prerequisites, Architecture, Quick Start, Expected Output, Exercises, Troubleshooting, Testing Checklist, Cleanup, Resources)
2. Pin all Docker image versions (no `latest` tags)
3. Include health checks for multi-service labs
4. Use isolated Docker networks (172.18.X.0/24 subnets, no host port conflicts)
5. Be tested locally to document actual startup times and expected outputs

---

## Architecture Decisions

### Decision: Lab 4 Application — Windows Server AD or Docker-based AD Alternative

**Choice**: Use `mcr.microsoft.com/windows/servercore:ltsc2022` with Active Directory Domain Services role enabled

**Alternatives considered**:
- Docker-based AD simulation (e.g., Samba): Would be lighter weight but less realistic for enterprise AD exploitation labs
- Deprecated Windows versions: ltsc2019 is outdated; ltsc2022 is current stable release

**Rationale**: Students need to learn real Windows AD exploitation (Kerberoasting, Pass-the-Hash, Delegation). Samba simulates AD but lacks Windows-specific features like Kerberos ticket handling and RDP access. Using official Microsoft Windows Server image ensures students interact with actual AD behavior. ltsc2022 is the current long-term support release. The larger image size (~3GB) is acceptable for lab purposes.

**Technical Details**:
- Image: `mcr.microsoft.com/windows/servercore:ltsc2022`
- Domain: `lab.local` (documented in README)
- Admin user: `Administrator` with strong password (generated per lab run or environment variable)
- Services exposed to kali container:
  - LDAP: Port 389 (internal container network, not host)
  - LDAPS: Port 636 (optional, not required for basic labs)
  - Kerberos: Port 88 (internal)
  - RDP: Port 3389 (optional for debugging)
- Startup time: **60 seconds** (Windows takes longer to boot; document this in README)
- Health check: LDAP bind test: `ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local" -D "cn=Administrator,cn=Users,dc=lab,dc=local" -w PASSWORD`

---

### Decision: Lab 7 Application — OpenPLC or Codesys

**Choice**: Use `openplcproject/openplc-v3` Docker image for ICS/SCADA simulation

**Alternatives considered**:
- Codesys: More advanced but commercial; would require licensing
- Snap7: Simulates Siemens S7 PLCs but lacks full ICS environment
- MQTT/Modbus simulator: Too minimal for meaningful lab exercises

**Rationale**: OpenPLC is open-source, widely used in ICS security training, and supports Modbus TCP (industry standard protocol). Students can learn real ICS attack vectors: Modbus scanning, protocol fuzzing, coil/register manipulation. The web UI (port 8080) allows students to upload PLC programs and monitor I/O, making it excellent for teaching SCADA security.

**Technical Details**:
- Image: `openplcproject/openplc-v3:latest` (pinned to specific date tag when available, e.g., `openplcproject/openplc-v3:2024.11`)
- Ports exposed internally to kali:
  - 8080: OpenPLC web UI
  - 502: Modbus TCP (industry-standard ICS protocol)
  - 1102: OPC-UA (optional, for advanced labs)
- Volume persistence: `/root/OpenPLC_v3/projects:/opt/openplc/projects` (allows uploading and saving PLC programs)
- Startup time: **15 seconds** (OpenPLC runtime initialization; document in README)
- Health check: HTTP GET to `http://localhost:8080` should return 200; also verify Modbus port 502 is listening

---

### Decision: Lab 8 REST API Service — Flask Custom App or httpbin

**Choice**: Use a lightweight custom Flask REST API with intentional vulnerabilities, hosted in a dedicated container

**Alternatives considered**:
- httpbin (public API testing service): Too simple; no real vulnerabilities to exploit
- JSONPlaceholder (mock API): Lack of realistic vulnerabilities
- Pre-built vulnerable API (e.g., DVWA with API endpoint): Adding to DVWA is complex; better to separate concerns

**Rationale**: Students need to practice **REST API security testing** — authentication bypass, injection, insecure deserialization, broken access control. A purpose-built vulnerable Flask app provides realistic endpoints like `/api/users`, `/api/login`, `/api/admin` with intentional flaws (SQL injection, missing auth, weak JWT, etc.). Separating the API from DVWA allows students to understand that APIs are independent attack vectors.

**Technical Details**:
- **Framework**: Flask (Python lightweight framework)
- **Port**: 5000 (Flask default; documented in docker-compose.yml)
- **Container image**: Custom Dockerfile (`docker-labs/lab8/api/Dockerfile`)
  - Base: `python:3.11-slim`
  - Install: Flask, requests, python-dotenv
  - Endpoints:
    - `GET /api/health` — Returns `{"status": "ok"}` (for health checks)
    - `GET /api/users` — Returns JSON user list (no auth; vulnerable to scraping)
    - `POST /api/login` — Simple username/password login (vulnerable to SQL injection in query)
    - `GET /api/admin` — Admin panel (missing auth check; should require token)
    - `POST /api/products` — Create product (vulnerable to insecure deserialization via pickle)
- **Database connection**: Connects to `lab8-db` (MySQL) on port 3306
- **Environment variables**: Database credentials, secret key (documented in README as `.env.example`)
- **Startup time**: **10 seconds** (Python app startup)
- **Health check**: HTTP GET to `http://localhost:5000/api/health` should return 200

**Implementation note**: This Flask app will be provided as source code in `docker-labs/lab8/api/app.py`, allowing students to review the vulnerabilities and understand the security flaws.

---

### Decision: README.md Template — Standardized Structure Across All Labs

**Choice**: Create a consistent template with 11 sections that applies to all labs with minimal customization per lab

**Template Structure**:

1. **Title** — Lab N: {Clear Title}
2. **Learning Objectives** — 3-5 bullet points
3. **Prerequisites** — Docker version, RAM, disk, ports
4. **Architecture** — Text + ASCII diagram (containers, networks, ports)
5. **Quick Start** — Copy-paste commands
6. **Expected Output** — Actual output from `docker compose ps`, service checks
7. **Detailed Exercises** — 4-8 step-by-step exercises with exact commands and expected output
8. **Troubleshooting** — 5+ common errors with solutions
9. **Testing Checklist** — Verify all objectives met
10. **Cleanup** — Teardown commands
11. **Resources** — Links to docs, CVE references, writeups

**Rationale**: Standardization ensures students know where to find information (consistent navigation) and allows for scalability (easy to add new labs). Customization is minimal—each lab changes content but keeps the same structure.

---

### Decision: Health Checks — Which Services Need Them

**Choice**: Implement health checks for **multi-service labs with dependencies** (Labs 2, 4, 8) and basic readiness for single-service labs

**Details**:
- **Lab 1** (Kali + Metasploitable): No health check (both are simple containers; startup is fast)
- **Lab 2** (DVWA + MySQL + Kali): Health check on MySQL; DVWA depends_on: `db` with `condition: service_healthy`
  ```yaml
  db:
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 40s
  dvwa:
    depends_on:
      db:
        condition: service_healthy
  ```
- **Lab 3** (WebGoat): No health check (single service, startup <5 seconds)
- **Lab 4** (Windows AD + Kali): Health check on DC; Kali depends_on DC
  ```yaml
  dc01:
    healthcheck:
      test: ["CMD", "powershell", "-Command", "Test-NetConnection -ComputerName localhost -Port 389"]
      interval: 15s
      timeout: 10s
      retries: 3
      start_period: 60s
  kali:
    depends_on:
      dc01:
        condition: service_healthy
  ```
- **Lab 5** (Target + Kali): No health check (both simple Linux containers)
- **Lab 6** (Gophish + Kali): No health check (Gophish starts quickly)
- **Lab 7** (OpenPLC + Kali): Health check on OpenPLC
  ```yaml
  openplc:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/"]
      interval: 15s
      timeout: 5s
      retries: 3
      start_period: 15s
  kali:
    depends_on:
      openplc:
        condition: service_healthy
  ```
- **Lab 8** (DVWA + MySQL + API + Kali): Health checks on MySQL and API
  ```yaml
  db:
    healthcheck:
      test: ["CMD", "mysqladmin", "ping"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 40s
  api:
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/api/health"]
      interval: 15s
      timeout: 5s
      retries: 3
      start_period: 10s
  dvwa:
    depends_on:
      db:
        condition: service_healthy
      api:
        condition: service_healthy
  ```

---

### Decision: Image Versions — Pinning Strategy

**Choice**: Pin all images to specific version tags; use date-based or semantic versioning. Never use `latest` tag in docker-compose.yml.

**Rationale**: Reproducibility. If students use `latest` and a new version breaks the lab, they can't debug. Pinned versions ensure consistent behavior across all runs and students.

**Version Strategy by Lab**:

| Lab | Service | Pinned Image | Rationale |
|-----|---------|--------------|-----------|
| 1 | kali | `kalilinux/kali-rolling:2025.1` | Rolling release with regular updates; pin to known working version |
| 1 | metasploitable | `tophusna/metasploitable2:latest` OR `vulnerables/metasploitable2` | Official Metasploitable2 image (tutum/metasploitable is deprecated); pin to latest stable |
| 2 | dvwa | `vulnerables/web-dvwa:1.12.4` | Pin to stable DVWA version |
| 2 | mysql | `mariadb:10.5` | MariaDB LTS; pin major.minor version |
| 3 | webgoat | `webgoat/webgoat-8.0:2025.1` | WebGoat 8.x stable; pin to date-based release |
| 4 | windows server | `mcr.microsoft.com/windows/servercore:ltsc2022` | ltsc2022 is current LTS; always specific, never `latest` |
| 5 | vulnerable linux | `vulnerables/ubuntu-linux` OR custom build pinned to specific commit | Depends on which vuln distro is chosen |
| 6 | gophish | `gophish:0.12.1` OR custom container | Pin to known version (0.12.1 is current stable) |
| 7 | openplc | `openplcproject/openplc-v3:2024.11` (or latest stable available) | OpenPLC stable version; pin when available |
| 8 | api | Custom Flask image built from `labs/lab8/api/Dockerfile` | Custom app; version controlled in git |

---

### Decision: Docker Network Design — Isolated Networks Per Lab

**Choice**: Each lab gets its own isolated Docker network with a unique subnet (172.18.X.0/24). NO host port mappings except for optional web UI access (documented in README).

**Design**:
- Lab 1: Network `lab1-net` (172.18.1.0/24)
- Lab 2: Network `lab2-net` (172.18.2.0/24)
- Lab 3: Network `lab3-net` (172.18.3.0/24)
- Lab 4: Network `lab4-net` (172.18.4.0/24)
- Lab 5: Network `lab5-net` (172.18.5.0/24)
- Lab 6: Network `lab6-net` (172.18.6.0/24)
- Lab 7: Network `lab7-net` (172.18.7.0/24)
- Lab 8: Network `lab8-net` (172.18.8.0/24)

**Rationale**: Isolation prevents port conflicts. If multiple labs run simultaneously, they won't collide. Container-to-container communication uses internal DNS (container name), so students learn realistic networking.

**Optional Host Mappings** (documented but not enabled by default):
- Lab 3: If browser access to WebGoat desired, uncomment `ports: ["8080:8080"]` in docker-compose.yml
- Lab 4: RDP access optional for Windows debugging; `ports: ["3389:3389"]` commented out
- Lab 7: OpenPLC web UI optional; `ports: ["8080:8080"]` commented out
- Lab 8: API testing optional; `ports: ["5000:5000"]` commented out

---

### Decision: Resource Limits — Prevent System Overload

**Choice**: Each service has explicit memory limits (both hard limit and reservation) to prevent host system freezing.

**Limits by Lab**:

| Lab | Total RAM (limits) | Details |
|-----|--------------------|---------|
| 1   | 2GB | Kali: 1GB limit / 512MB reserved; Metasploitable: 1GB / 512MB |
| 2   | 2.5GB | DVWA: 512MB; MySQL: 1GB; Kali: 1GB |
| 3   | 1.5GB | WebGoat: 1GB; Kali: 512MB |
| 4   | 3GB | Windows DC: 2GB (Windows needs more); Kali: 1GB |
| 5   | 1.5GB | Target: 512MB; Kali: 1GB |
| 6   | 2GB | Gophish: 512MB; Kali: 1.5GB |
| 7   | 1.5GB | OpenPLC: 1GB; Kali: 512MB |
| 8   | 3GB | DVWA: 512MB; MySQL: 1GB; API: 512MB; Kali: 1GB |

**docker-compose.yml syntax** (example):
```yaml
services:
  lab1-kali:
    image: kalilinux/kali-rolling:2025.1
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
```

---

### Decision: Troubleshooting Sections — Category-Based Approach

**Choice**: Organize troubleshooting by **common categories** that apply across labs:

1. **Image Pull Issues** — Image not found, network timeout, authentication
2. **Container Exit/Crash** — Service exits immediately; check logs with `docker compose logs <service>`
3. **Network Connectivity** — Ping between containers fails; check `docker network inspect`
4. **Port Conflicts** — Port already in use; check with `lsof -i :PORT`
5. **Health Check Failures** — Multi-service setup hangs; verify with `docker compose ps` (watch for "starting" status)
6. **Startup Delays** — Container seems stuck; is it normal? (e.g., Windows AD takes 60 seconds)
7. **Lab-Specific Issues** — (Custom per lab, e.g., "AD domain not initialized" for Lab 4)

**Example** (Lab 4):
```markdown
## Troubleshooting

### Error: Domain Controller won't start / stuck in "starting"

**Cause**: Windows Server images take 60+ seconds to boot; DC role initialization is slow.

**Solution**:
- Wait 60-90 seconds after `docker compose up -d`
- Check logs: `docker compose logs dc01 | tail -50`
- Look for: "Active Directory services started" or similar message
- If DC still hasn't started after 2 minutes, restart: `docker compose down && docker compose up -d`

### Error: Kali cannot connect to DC on port 389 (LDAP timeout)

**Cause**: DC not fully initialized or LDAP service not listening.

**Solution**:
- Verify DC is running: `docker compose ps` (should show "Up" for dc01)
- Check DC logs for LDAP service: `docker compose logs dc01 | grep LDAP`
- Test connectivity from host: `docker compose exec kali ldapsearch -x -H ldap://dc01 -b "dc=lab,dc=local" -v`
- If timeout, DC may still be booting; wait another 30 seconds and retry

### Error: Kerberoasting returns no results

**Cause**: Domain may not be fully initialized; no users/SPN registered yet.

**Solution**:
- Ensure DC has been running for ≥90 seconds
- Manually add test users to AD (document in README or provide setup script)
- Verify with: `docker compose exec kali impacket-GetNPUsers lab.local/ -no-pass -dc-ip dc01`
```

---

## File Changes

| File | Action | Description |
|------|--------|-------------|
| `docker-labs/lab1/README.md` | Update | Add Expected Output, expand troubleshooting, add Testing Checklist |
| `docker-labs/lab1/docker-compose.yml` | Update | Pin Kali + Metasploitable image versions, add resource limits, health checks |
| `docker-labs/lab2/README.md` | Create | New file; follows standard template; covers DVWA + MySQL + web testing |
| `docker-labs/lab2/docker-compose.yml` | Verify | Audit existing; add health checks for MySQL; pin image versions |
| `docker-labs/lab3/README.md` | Update | Add Expected Output, verify WebGoat version, add Testing Checklist |
| `docker-labs/lab3/docker-compose.yml` | Update | Pin WebGoat version, add resource limits |
| `docker-labs/lab4/README.md` | Replace | **Remove Juice Shop content**; write new AD exploitation guide |
| `docker-labs/lab4/docker-compose.yml` | Replace | **Remove Juice Shop service**; add Windows AD DC (mcr.microsoft.com/windows/servercore:ltsc2022) with 60-second startup documented |
| `docker-labs/lab5/README.md` | Update | Verify vulnerable target, document priv-esc path, add Testing Checklist |
| `docker-labs/lab5/docker-compose.yml` | Update | Pin image versions, add resource limits |
| `docker-labs/lab6/README.md` | Update | Clarify phishing tools (Gophish/evilginx2), add Testing Checklist |
| `docker-labs/lab6/docker-compose.yml` | Update | Pin Gophish version, add resource limits, health checks |
| `docker-labs/lab7/README.md` | Replace | **Remove Mutillidae content**; write new ICS/SCADA + OpenPLC guide |
| `docker-labs/lab7/docker-compose.yml` | Replace | **Remove Mutillidae service**; add OpenPLC (openplcproject/openplc-v3) with Modbus port 502, volume persistence |
| `docker-labs/lab8/README.md` | Update | Add REST API service documentation, API endpoints, security testing exercises |
| `docker-labs/lab8/docker-compose.yml` | Update | **ADD new `api` service** (Flask custom app on port 5000); add health checks for db + api; update Kali depends_on |
| `docker-labs/lab8/api/Dockerfile` | Create | Custom Flask API image; vulnerable endpoints for security testing |
| `docker-labs/lab8/api/app.py` | Create | Flask REST API with intentional vulnerabilities; endpoints: /api/health, /api/users, /api/login, /api/admin, /api/products |
| `docker-labs/lab8/api/.env.example` | Create | Example environment file (database credentials, secret key) |

---

## Interfaces / Contracts

### Lab 1 (Network Reconnaissance)

**Expected Container Instances**:
```
CONTAINER                  IMAGE                          NETWORK      IP
lab1-kali                  kalilinux/kali-rolling:2025.1  lab1-net     172.18.1.10
lab1-metasploitable       vulnerables/metasploitable2    lab1-net     172.18.1.20
```

**Ports (internal to lab1-net, not exposed to host)**:
- 21/tcp (FTP)
- 22/tcp (SSH)
- 23/tcp (Telnet)
- 25/tcp (SMTP)
- 80/tcp (HTTP)
- 139/tcp (NetBIOS)
- 445/tcp (SMB)
- 3306/tcp (MySQL)
- 8080/tcp (Tomcat)

---

### Lab 4 (Windows AD Exploitation)

**Expected Container Instances**:
```
CONTAINER                  IMAGE                                          NETWORK      IP
lab4-dc01                  mcr.microsoft.com/windows/servercore:ltsc2022  lab4-net     172.18.4.10
lab4-kali                  kalilinux/kali-rolling:2025.1                 lab4-net     172.18.4.20
```

**Ports (internal to lab4-net)**:
- 389/tcp (LDAP)
- 636/tcp (LDAPS)
- 88/tcp (Kerberos)
- 3389/tcp (RDP) — optional host mapping for debugging

**Environment Variables (set in docker-compose.yml)**:
```yaml
dc01:
  environment:
    - ADMIN_PASSWORD: YourP@ssw0rd123  # Or fetch from .env
    - DOMAIN_NAME: lab.local
    - NETBIOS_NAME: LAB
```

**Health Check Endpoint**:
- LDAP query: `ldapsearch -x -H ldap://172.18.4.10 -b "dc=lab,dc=local"`

---

### Lab 7 (ICS/SCADA with OpenPLC)

**Expected Container Instances**:
```
CONTAINER                  IMAGE                                      NETWORK      IP
lab7-openplc              openplcproject/openplc-v3:2024.11          lab7-net     172.18.7.10
lab7-kali                 kalilinux/kali-rolling:2025.1              lab7-net     172.18.7.20
```

**Ports (internal to lab7-net)**:
- 8080/tcp (OpenPLC web UI) — optional host mapping for browser access
- 502/tcp (Modbus TCP)
- 1102/tcp (OPC-UA) — optional

**Volumes**:
- OpenPLC projects: `/root/OpenPLC_v3/projects` ↔ `./projects:/opt/openplc/projects`

**Health Check Endpoint**:
- HTTP GET: `curl http://172.18.7.10:8080/` (returns 200)
- Modbus port: `nc -zv 172.18.7.10 502` (succeeds)

---

### Lab 8 (REST API Security)

**Expected Container Instances**:
```
CONTAINER                  IMAGE                                      NETWORK      IP
lab8-dvwa                  vulnerables/web-dvwa:1.12.4               lab8-net     172.18.8.10
lab8-db                    mariadb:10.5                              lab8-net     172.18.8.20
lab8-api                   lab8-api:latest (custom Flask)            lab8-net     172.18.8.30
lab8-kali                  kalilinux/kali-rolling:2025.1             lab8-net     172.18.8.40
```

**REST API Endpoints** (at 172.18.8.30:5000 or lab8-api:5000):
```
GET /api/health                          → {"status": "ok"}                [No auth]
GET /api/users                           → [{"id": 1, "name": "..."}]     [No auth, vulnerable to scraping]
POST /api/login                          → {"token": "..."}               [SQL injection possible in query]
GET /api/admin                           → {"admin": true}                [Missing auth check, vulnerable]
POST /api/products                       → {"id": 1, "name": "..."}       [Insecure deserialization via pickle]
```

**Health Check Endpoints**:
- MySQL: `mysqladmin ping -h lab8-db`
- API: `curl http://lab8-api:5000/api/health`

**Database Connection** (from API container):
```
Host: lab8-db
Port: 3306
User: root
Password: rootpass (or from .env)
Database: lab8_security
```

---

## Testing Strategy

| Layer | What to Test | Approach |
|-------|-------------|----------|
| **Unit** | Docker Compose syntax | `docker compose config` on each lab (syntax validation only) |
| **Integration** | Multi-container startup | `docker compose up -d` → wait startup time → `docker compose ps` (all containers "Up") |
| **Service** | Health checks | Services reach configured endpoints; health checks report success |
| **Functional** | Lab-specific tests | Run test scenario from spec.md (e.g., Lab 1: nmap finds ports; Lab 4: LDAP connects; Lab 8: API endpoints respond) |
| **Cross-Platform** | macOS, Linux, WSL2 | Spot-check 2-3 labs on each platform to verify no platform-specific issues |

---

## Migration / Rollout

**No data migration required.**

**Rollout strategy**:
1. Update each lab's README + docker-compose.yml (can be done lab-by-lab, not all at once)
2. Test each lab locally after changes (before committing)
3. Commit changes with clear commit messages: "labs: fix Lab 4 — replace Juice Shop with Windows AD"
4. If a lab breaks after changes, roll back using git checkout (see proposal for rollback plan)
5. **Recommended order for fixing/testing** (dependency: later labs can be tested in parallel):
   - Lab 1: Simple, low risk, good test of template
   - Lab 2: Create missing README, verify existing compose
   - Lab 3: Update image versions (low risk)
   - Lab 4: **Major change** (replace Juice Shop); test thoroughly
   - Lab 5, 6: Update image versions (low risk)
   - Lab 7: **Major change** (replace Mutillidae); test thoroughly
   - Lab 8: Add API service; test all dependencies work

---

## Open Questions

- [ ] **Lab 8 API Framework**: Confirm custom Flask app vs. using existing vulnerable API image (e.g., DVWA API mode)? → **Decision**: Custom Flask (see above)
- [ ] **Windows AD Image Size**: OK to have Lab 4 image pull 3-4GB? → **Decision**: Yes; documented as prerequisite
- [ ] **OpenPLC Stability**: Latest stable version tag available? → **Action**: Verify during implementation; pin to known working version
- [ ] **Lab 2 Missing README**: Is current docker-compose.yml functionally correct, or does it also need fixes? → **Assumption**: Compose is fine; only README missing

---

## Summary

**Design Created**

| Aspect | Details |
|--------|---------|
| **Key Decisions** | 4 major: Lab 4 = Windows AD (mcr.microsoft.com/windows/servercore:ltsc2022), Lab 7 = OpenPLC (openplcproject/openplc-v3), Lab 8 API = custom Flask, all labs = pinned images + resource limits |
| **Files Affected** | 18 files: 8 READMEs (create Lab 2, update others) + 8 docker-compose.yml + 2 new API files (Dockerfile, app.py) |
| **Testing Strategy** | Syntax validation → integration (startup) → service health → functional (per-lab test scenarios) → cross-platform spot-check |
| **Startup Times** | Lab 1-3, 5-6: ≤5 seconds; Lab 4: 60 seconds; Lab 7: 15 seconds; Lab 8: 20 seconds |
| **Resource Limits** | All labs have memory limits (1-3GB per lab); prevents system overload when all run |
| **Cross-Platform** | All labs designed for macOS (Intel + ARM), Linux, Windows WSL2; no platform-specific hardcoding |

**Next Step**: Ready for **Tasks phase** (sdd-tasks). Sub-agent should break down into 60-80 concrete implementation work items (one per docker-compose.yml change, README section, etc.) and provide task checklist.
