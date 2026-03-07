# Proposal: Correcciones Labs Docker

## Intent

The 8 Docker labs have critical documentation and configuration issues that break the student learning experience. Students follow outdated or missing instructions, encounter wrong applications, and cannot verify if their setup is correct. This change audits, fixes, and validates all labs so students can reliably follow README → run lab → see expected behavior.

## Related Prior Work

No similar patterns found in Engram (novel for this project).

## Scope

### In Scope

- **Lab 1-8 README.md files**: Audit descriptions, objectives, prerequisites, expected behavior
- **Lab 1-8 docker-compose.yml files**: Verify service definitions, image versions, port mappings
- **Missing README**: Create Lab 2 README.md from scratch (currently missing entirely)
- **Incorrect applications**: Fix Lab 4 (replace Juice Shop with Windows AD) and Lab 7 (replace Mutillidae with OpenPLC)
- **Missing service definitions**: Add REST API service to Lab 8 docker-compose.yml
- **Deprecated images**: Update Labs 1, 3, 5, 6 with current, stable images
- **Test each lab locally**: Run `docker compose up` → verify all services start → document expected output
- **Troubleshooting guides**: Add common issues and solutions to each README

### Out of Scope

- Refactoring lab structure or renaming directories
- Creating new labs beyond the 8 existing ones
- Automated CI/CD testing (can be added in future enhancement)
- Student assignment/grading system integration
- Video tutorials or supplementary content

## Approach

1. **Audit Phase** (2 hours):
   - Review each `labs/labN/docker-compose.yml` against `labs/labN/README.md`
   - Cross-check application names, ports, environment variables, volumes
   - Identify mismatches: wrong app, missing services, deprecated images

2. **Fix Phase** (3-4 hours):
   - Create/update README.md for each lab with: title, learning objectives, prerequisites, instructions, expected output, troubleshooting
   - Update docker-compose.yml to use correct applications and current image versions
   - Resolve specific issues:
     - Lab 2: Write README.md describing what the lab teaches
     - Lab 4: Switch Juice Shop image to Windows AD (specify correct image/port)
     - Lab 7: Switch Mutillidae to OpenPLC (specify correct image/port)
     - Lab 8: Add REST API service definition
     - Labs 1,3,5,6: Verify/update image versions to stable releases

3. **Test Phase** (3-4 hours):
   - For each lab: `cd labs/labN && docker compose up`
   - Verify all services start without errors
   - Document actual output: running services, accessible ports, health checks
   - Note any expected startup delays or log patterns

4. **Documentation Phase** (1-2 hours):
   - Add "Expected Output" section to each README showing what successful lab run looks like
   - Document troubleshooting: common errors, how to debug, how to reset
   - Add section: "What Students Should See" with screenshots/log examples if applicable

## Affected Areas

| Area | Impact | Description |
|------|--------|-------------|
| `labs/lab1/README.md` | Modified | Verify, update deprecated images, add expected output |
| `labs/lab1/docker-compose.yml` | Modified | Update image versions to stable releases |
| `labs/lab2/README.md` | New | Create from scratch, define learning objectives |
| `labs/lab2/docker-compose.yml` | Verified | Audit services, document expectations |
| `labs/lab3/README.md` | Modified | Verify, add expected output, troubleshooting |
| `labs/lab3/docker-compose.yml` | Modified | Update image versions |
| `labs/lab4/README.md` | Modified | Update to describe Windows AD setup (not Juice Shop) |
| `labs/lab4/docker-compose.yml` | Modified | Replace Juice Shop with Windows AD image |
| `labs/lab5/README.md` | Modified | Verify, add expected output, troubleshooting |
| `labs/lab5/docker-compose.yml` | Modified | Update image versions |
| `labs/lab6/README.md` | Modified | Verify, add expected output, troubleshooting |
| `labs/lab6/docker-compose.yml` | Modified | Update image versions |
| `labs/lab7/README.md` | Modified | Update to describe OpenPLC setup (not Mutillidae) |
| `labs/lab7/docker-compose.yml` | Modified | Replace Mutillidae with OpenPLC image |
| `labs/lab8/README.md` | Modified | Add REST API service to instructions, expected output |
| `labs/lab8/docker-compose.yml` | Modified | Add REST API service definition |

## Risks

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| Labs don't run locally (Docker/network issues) | Medium | Test on clean Docker install, document environment requirements |
| Images are stale/no longer available | Medium | Use official registry images, pin specific versions (not `latest`) |
| Students have different OS/Docker versions | Medium | Document minimum requirements, test on Linux/Mac/Windows |
| Lab order/dependencies not clear | Low | Add prerequisites section to each README |
| Wrong applications still in docker-compose.yml | Low | Double-check app names, ports, env vars against README intent |

## Rollback Plan

If a lab breaks after changes:

1. **Identify the broken lab** (e.g., Lab 4)
2. **Revert files** (git checkout for that lab):
   ```bash
   git checkout HEAD -- labs/lab4/README.md labs/lab4/docker-compose.yml
   ```
3. **Verify rollback** (run lab again):
   ```bash
   docker compose down -v
   docker compose up
   ```
4. **Investigate** what changed that broke it (diff the files before/after)
5. **Re-fix carefully** (may need to test on different Docker version or OS)

## Dependencies

- Docker Engine 20.10+ (or Docker Desktop equivalent)
- docker-compose v2.0+
- Network connectivity to pull images from registries
- Sufficient disk space for images (estimate: 8-10 GB for all 8 labs)

## Success Criteria

- [ ] All 8 labs have current, passing README.md files (verified by reading)
- [ ] Lab 2 README.md created (was missing)
- [ ] Lab 4 uses Windows AD (not Juice Shop)
- [ ] Lab 7 uses OpenPLC (not Mutillidae)
- [ ] Lab 8 docker-compose.yml includes REST API service
- [ ] Labs 1, 3, 5, 6 have verified/updated image versions
- [ ] Each lab tested: `docker compose up` runs without critical errors
- [ ] Each README includes "Expected Output" section matching actual test results
- [ ] Each README includes troubleshooting guide
- [ ] Students can follow README → run lab → see expected behavior without confusion
- [ ] No breaking changes to existing lab structure (directories, file names unchanged)

---

## Notes

**Key Findings to Address**:
- Lab 2 is broken (missing README.md) — blocks students immediately
- Lab 4 and 7 have wrong applications — students will be confused about learning objectives
- Lab 8 missing REST API — incomplete setup for API security concepts
- Labs 1,3,5,6 may fail due to deprecated images — students get errors instead of learning

**Testing Strategy**:
1. Test on single OS first (recommend Linux or Docker Desktop on Mac)
2. Document exact output so students know what "success" looks like
3. Note any manual setup steps (e.g., "wait 30 seconds for DB to initialize")
4. Include log examples in troubleshooting section

**Delivery Quality**:
- Each README should be self-contained (student doesn't need to hunt for info)
- Each README should include: What? Why? How? What should I see? What if it breaks?
- docker-compose.yml should have inline comments for non-obvious settings
