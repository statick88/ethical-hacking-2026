# Tasks: Propuesta Modernización Ethical Hacking 2026

## Phase 1: Create Supporting Data Files (JSON Structures)

- [ ] 1.1 Create `openspec/design/data-modules.json` with all 8 modules (Module 1-8, 15-20 hours each, totaling 150 hours), including: `id`, `number`, `title`, `hours`, `description`, `objectives[]`, `tools[]`, `labs{}` (tryhackme, hackthebox, overthewire), `certifications[]`, and `content_topics[]`
- [ ] 1.2 Create `openspec/design/data-tools.json` with 20+ tools (Nmap, Metasploit, Burp Suite, Shodan, LangChain, OpenClaw, etc.), including: `id`, `name`, `type` (reconnaissance/exploitation/ai/industrial), `modules[]` (which modules use it), `platform` (Linux/macOS/Windows/Kali), `license` (Open Source/Commercial), `url`, and `description`
- [ ] 1.3 Create `openspec/design/data-certifications.json` with certification mapping: `id`, `name` (OSCP+, CEH v13, eJPTv2, PNPT, CRTP), `provider`, and `module_coverage[]` with coverage level (`core`, `related`, `none`)
- [ ] 1.4 Validate JSON syntax for all three data files (ensure valid JSON, no missing commas/brackets)

## Phase 2: Create CSS Styles Document

- [ ] 2.1 Create `openspec/design/css-styles.md` with complete CSS architecture including:
  - Color scheme variables (primary blue: #003366, secondary blue: #0066CC, accent orange: #FF6600, text colors, backgrounds)
  - Typography hierarchy (h1-h3 sizes, weights, colors; body font-family: 'Segoe UI')
  - Box model for sections, articles, and modules with proper margins, padding, and borders
  - Table styling with header backgrounds, row hovering, alternating colors
  - `<details>` expandable module cards with open/closed states
  - Print/PDF-specific styles (`page-break-inside: avoid`, page sizing for A4)
- [ ] 2.2 Include CSS for responsive layouts (if needed for web version) or note PDF-only constraints
- [ ] 2.3 Add CSS for interactive elements: tooltips, search bar styling, TOC link styling
- [ ] 2.4 Test CSS document: verify all color codes are valid hex, all font-family declarations are readable

## Phase 3: Create HTML Sections Reference Document

- [ ] 3.1 Create `openspec/design/html-sections.md` documenting semantic structure:
  - Cover page structure (logo, title, metadata, date, author)
  - Table of Contents section (with ID anchors for auto-generation via JS)
  - Executive Summary section (1 page: problem, solution, value proposition)
  - 9 main sections (Introduction, Current Analysis, Diagnostics, Modernization Proposal, Key Skills, Evaluation Methodology, Certifications, Infrastructure, Bibliography, Annex)
  - 8 module article templates (header, overview, objectives, content topics table, tools, labs, certifications, hours)
- [ ] 3.2 Document all HTML semantic elements: `<section>`, `<article>`, `<header>`, `<footer>`, `<details>`, `<summary>`, `<nav>`
- [ ] 3.3 Document ID naming convention: `#modulo-1`, `#modulo-2`, etc. for cross-references
- [ ] 3.4 Include expandable module card template with `<details>` + `<summary>` structure
- [ ] 3.5 Document table structures for modules, tools, and certification matrices

## Phase 4: Generate Final HTML Document

- [ ] 4.1 Create `openspec/informe_final.html` base structure with:
  - HTML5 DOCTYPE, proper `<head>` metadata (UTF-8, viewport, title, author)
  - Embedded CSS from Phase 2 within `<style>` tag in `<head>`
  - Semantic body structure with `<header>`, `<main>`, `<footer>`
- [ ] 4.2 Populate Cover Page section (1 page): ABACOM logo (reference ./abacom-logo.png), title "Propuesta de Modernización Ethical Hacking 2026", date, author name
- [ ] 4.3 Generate Table of Contents section with JavaScript snippet that auto-generates from `<h1>`, `<h2>`, `<h3>` headings
- [ ] 4.4 Populate Executive Summary section (1 page): problem statement, 3 core solutions (8 modules + 150h + AI agentic), value proposition
- [ ] 4.5 Create main sections (Sections 1-9) with proper hierarchy:
  - Section 1: Introduction and Context (2 pages: landscape 2026, emerging threats, IA/agentic paradigm)
  - Section 2: Current Curriculum Analysis (2 pages: existing modules review, gaps identified)
  - Section 3: Diagnostics (1 page: gaps matrix, threat analysis)
  - Section 4: Modernization Proposal (overview of 8 modules, 150 hours structure)
  - Section 5: Key Skills (cross-cutting competencies)
  - Section 6: Evaluation Methodology (assessment strategies)
  - Section 7: Certification Alignment (mapping to OSCP+, CEH, etc.)
  - Section 8: Infrastructure & Tools (tools, platforms, CTF labs)
  - Section 9: Bibliography & Annex
- [ ] 4.6 Populate 8 Module articles (Section 4.1-4.8 or separate articles) using data-modules.json:
  - For each module: create `<article class="module" id="modulo-N">` with header (title, hours), overview, learning objectives, content topics table, tools section (with cross-links to tools), labs (TryHackMe, HTB, OverTheWire), certifications aligned
  - Wrap module content in `<details>` for expandable cards
- [ ] 4.7 Create Tools section (Annex A) with tables from data-tools.json:
  - Tool-to-Module cross-reference table (Tool | Type | Modules | Platform | License)
  - Organized by category: Reconnaissance, Exploitation, AI/Agentic, Industrial
- [ ] 4.8 Create Certification Alignment Matrix (Section 7 / Table):
  - Rows: 8 modules; Columns: 5 certifications (OSCP+, CEH v13, eJPTv2, PNPT, CRTP)
  - Use symbols: `✓` (core), `●` (related), empty (not covered)
  - Add Coverage % column per module
- [ ] 4.9 Embed Table of Contents auto-generation JavaScript at the end of `<body>`
- [ ] 4.10 Verify total hours: sum hours from all 8 modules = 150 hours exactly
- [ ] 4.11 Test internal cross-references: all `href="#modulo-X"` and tool links are valid IDs

## Phase 5: PDF Generation & Verification

- [ ] 5.1 Install WeasyPrint (if not already installed): `pip install weasyprint` or `pip install -r requirements.txt` if file exists
- [ ] 5.2 Create Python script `generate_pdf.py` to:
  - Read `informe_final.html`
  - Apply print CSS and page formatting (A4 size, margins, headers/footers with page numbers)
  - Generate `informe_modernizacion_ethical_hacking_2026.pdf` in project root
  - Handle font embedding if needed
- [ ] 5.3 Run PDF generation: `python generate_pdf.py`
- [ ] 5.4 Verify PDF output:
  - PDF exists and file size > 500KB
  - PDF opens without errors in Adobe Reader and web browsers
  - Table of Contents displays correctly with page numbers (if dynamic)
  - Color scheme preserved (blue headers, orange module titles)
- [ ] 5.5 Check PDF paging: verify no content is cut off, page breaks occur at appropriate section boundaries
- [ ] 5.6 Test PDF on multiple viewers (Adobe Acrobat, macOS Preview, Firefox PDF reader, Chrome)

## Phase 6: Content Validation & Testing

- [ ] 6.1 Verify HTML structure: run informe_final.html through W3C HTML Validator (https://validator.w3.org) — fix any errors (no critical issues allowed)
- [ ] 6.2 Validate CSS: check for undefined color variables, missing font declarations, syntax errors
- [ ] 6.3 Spelling & Grammar check: proofread all 150+ pages for Spanish typos, grammar, consistency
  - Check module titles for consistency (Module N format)
  - Verify all acronyms are properly capitalized (OSCP+, CEH v13, eJPTv2, PNPT, CRTP, AD, ICS/OT, TLS, etc.)
- [ ] 6.4 Content accuracy audit:
  - Total hours: 8 modules sum to exactly 150 hours
  - Module descriptions align with specs
  - 8 modules covered: Foundational, AI/LLM, Web/API, Identity/AD, Autonomous PT, Evasion, Industrial, Post-Exploitation
- [ ] 6.5 Cross-reference validation:
  - All internal anchors (module IDs, section IDs) are consistent
  - All tool references in modules link to corresponding tool definitions
  - All certification references are consistent across sections
- [ ] 6.6 Lab & Certification verification:
  - TryHackMe rooms/paths listed are valid and publicly available
  - HTB labs/machines are accessible (Tier 0 for beginner content)
  - OverTheWire wargames are active
  - Certification names match official offerings (OSCP+, CEH v13, etc.)
- [ ] 6.7 Bibliography verification: spot-check 5+ URLs for active links (use `curl -I` or manual browser test)
- [ ] 6.8 Visual regression testing (manual): compare PDF output with design mockup expectations
  - Header styles match color palette
  - Module cards are properly formatted with borders and backgrounds
  - Tables render correctly with header backgrounds and row borders
  - Page margins and spacing match specifications

## Phase 7: Packaging & Deliverables

- [ ] 7.1 Verify final file structure in `/Users/statick/apps/Ethical_Hacking/`:
  - `informe_final.html` ✓
  - `informe_modernizacion_ethical_hacking_2026.pdf` ✓
  - `abacom-logo.png` (should already exist)
  - `openspec/changes/informe-modernizacion-ethical-hacking/tasks.md` ✓
- [ ] 7.2 Create `DELIVERABLES.md` in project root documenting:
  - File locations and formats
  - How to regenerate HTML from data files
  - How to regenerate PDF using `generate_pdf.py`
  - Versioning info (date generated, based on design v1.0)
- [ ] 7.3 Package deliverables for distribution:
  - Option A: Create `informe_modernizacion_2026.zip` containing both HTML and PDF
  - Option B: Publish HTML to web server (if applicable)
  - Option C: Both HTML and PDF in project root for direct access
- [ ] 7.4 Create `README.md` in `openspec/design/` documenting:
  - How to modify modules: edit `data-modules.json`, regenerate HTML
  - How to modify tools: edit `data-tools.json`, regenerate HTML
  - How to modify certifications: edit `data-certifications.json`, regenerate matrices
  - CSS customization instructions
- [ ] 7.5 Document any open questions (from design.md):
  - Decide: JavaScript interactivity in PDF or HTML-only?
  - Decide: Page limits per module (PDF constraints) or flexible?
  - Decide: QR codes to labs or just URLs?
  - Decide: Publish web version or PDF/HTML only?
- [ ] 7.6 Archive complete SDD change:
  - All spec files complete in `openspec/specs/`
  - All design files complete in `openspec/design/`
  - Tasks marked complete in `tasks.md`
  - Ready for sdd-archive phase

---

## Summary

| Phase | Task Count | Focus |
|-------|-----------|-------|
| Phase 1: Data Files | 4 | JSON structures for modules, tools, certifications |
| Phase 2: CSS Styles | 4 | Complete stylesheet documentation |
| Phase 3: HTML Sections | 5 | Semantic markup reference |
| Phase 4: HTML Generation | 11 | Assemble informe_final.html from components |
| Phase 5: PDF Generation | 6 | WeasyPrint conversion and verification |
| Phase 6: Content Validation | 8 | Quality checks, cross-references, accuracy |
| Phase 7: Packaging | 6 | Final deliverables and documentation |
| **TOTAL** | **44** | |

## Implementation Order

1. **Phases 1-3 (Foundation)**: Create data files and documentation. These are independent and provide input for Phase 4.
2. **Phase 4 (Generation)**: Assemble the HTML document using data from Phase 1 and styling from Phase 2.
3. **Phase 5 (PDF)**: Generate PDF from the completed HTML.
4. **Phase 6 (Validation)**: Verify all content, links, and formatting against specs.
5. **Phase 7 (Delivery)**: Package final outputs and document maintenance procedures.

## Next Step

Ready for **sdd-apply** phase to implement all tasks and create the final deliverables.
