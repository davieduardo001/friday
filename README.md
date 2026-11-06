# friday

A portable, single-repo toolkit of **generic agents** and **platform-agnostic skills** that run the full pipeline:

```
issue → PR → review → DoD
```

Works on **GitHub, GitLab, Azure DevOps** — configured per-project in one file: `project.md`.

---

## Why friday?

- **No duplicated rules** — Conventional Commits, US/BDD, PRD/SPEC, DoD live once in `AGENTS.md`.
- **Platform-agnostic skills** — `issue` and `pr` work the same way on all three platforms.
- **One config per project** — Copy `project.model.md` → `project.md`, fill it, done.
- **Global install, per-project config** — Install once, use everywhere.
- **MIT licensed, public, clean** — No org names, no client data.

---

## Structure

```
friday/
├── AGENTS.md              # Common rules (Conventional Commits, BDD, DoD, etc.)
├── project.model.md       # Template for project.md
├── instalar.sh            # Global installer (symlinks to ~/.claude, ~/.gemini, ~/.agents/skills)
├── skills/
│   ├── issue/
│   │   ├── SKILL.md
│   │   └── plataformas/
│   │       ├── github.md
│   │       ├── gitlab.md
│   │       └── ado.md
│   └── pr/
│       ├── SKILL.md
│       └── plataformas/
│           ├── github.md
│           ├── gitlab.md
│           └── ado.md
├── agents/
│   ├── dev.md
│   ├── tester.md
│   ├── reviewer.md
│   ├── redator.md
│   └── analista.md
├── CHANGELOG.md
├── VERSION
└── LICENSE
```

---

## Quick Start

### 1. Install globally (once)

```bash
git clone https://github.com/davidsouzas/friday.git ~/.friday
cd ~/.friday
./instalar.sh
```

This creates symlinks in:
- `~/.claude/skills/` and `~/.claude/agents/`
- `~/.gemini/skills/` and `~/.gemini/agents/`
- `~/.agents/skills/` (for Pi, etc.)

### 2. Start a new project

```bash
cd meu-projeto-novo
~/.friday/instalar.sh --init-project
# → copies project.model.md → project.md
# → opens it in $EDITOR
```

Edit `project.md` with your project details:

```yaml
platform: github | gitlab | ado
repo: myorg/my-repo
fluxo_branch: main | homolog-main
current_sprint: "Sprint 3"
teste: npm run test:ci
arquitetura: docs/ARCH.md
templates_us: .friday/templates/us.md
```

### 3. Use it

```bash
# Create an issue
issue "Add login" "Implement JWT authentication" --type feature --sprint "Sprint 3"

# Open a PR
pr "Add login" "Implement JWT authentication" --type feature --sprint "Sprint 3"

# Run agents
dev "implement the login endpoint"
tester "validate the login endpoint"
reviewer "review PR #42"
redator "write PRD for the new auth module"
analista "write US for user registration"
```

---

## How It Works

### The Contract: `project.md`

Every project has a `project.md` at its root. Skills read this file to know:
- Which platform (`github`, `gitlab`, `ado`)
- Repository identifier
- Branch strategy
- Current sprint
- Test command
- Architecture docs location
- US template path

### Skills

| Skill | Purpose | Platforms |
|-------|---------|-----------|
| `issue` | Create work items (issues, PBIs) | GitHub (`gh`), GitLab (`glab`), ADO (MCP/`az`) |
| `pr` | Open PR/MR linked to issue | GitHub (`gh pr`), GitLab (`glab mr`), ADO (MCP/`az`) |

Each skill has a `SKILL.md` (rules, CLI args, common behavior) + platform-specific files in `plataformas/`.

### Agents

Five generic agents, each with a specific role:

| Agent | Role |
|-------|------|
| `dev` | Implements issues, opens PRs |
| `tester` | Writes/runs tests, validates DoD |
| `reviewer` | Reviews PRs, approves/rejects |
| `redator` | Writes PRDs, SPECs, documentation |
| `analista` | Writes US (BDD), defines acceptance criteria |

All agents read `AGENTS.md` + `project.md` before acting.

---

## Platform Mapping

| Concept | GitHub | GitLab | Azure DevOps |
|---------|--------|--------|--------------|
| Work item | issue | issue | work item (PBI/Bug) |
| Sprint | milestone | milestone | iteration path |
| Create item | `gh issue create` | `glab issue create` | MCP ADO / `az boards` |
| Open PR | `gh pr create` | `glab mr create` | MCP ADO / `az repos pr` |
| Link | `Closes #N` | `Closes #N` | `AB#N` |
| Approval | formal review | MR approval | reviewer vote |

---

## Installer Options

```bash
./instalar.sh              # Install (idempotent)
./instalar.sh --force      # Overwrite existing files/symlinks
./instalar.sh --remover    # Remove all friday symlinks
./instalar.sh --init-project  # Copy project.model.md → project.md in cwd
```

---

## Requirements

- **Claude Code** or **Gemini CLI** (v1)
- Platform CLIs: `gh` (GitHub), `glab` (GitLab), `az` (ADO fallback) or MCP ADO
- Git, bash

---

## Roadmap

| Version | Features |
|---------|----------|
| **v1.0** | ✅ Core: `issue`, `pr`, 5 agents, installer, 3 platforms |
| **v1.1** | Skills: `sprint`, `vincular`, `commits` |
| **v1.2** | Support: pi, hermes, opencode, deepseek, codex |
| **v2.0** | Auto-diagram generation, AI-assisted spec writing |

---

## Contributing

1. Fork & clone
2. Create a branch: `feature/short-description`
3. Follow Conventional Commits
4. Open PR with `Closes #<issue>`
5. All tests must pass

---

## License

MIT © 2025 Davi

---

## Related

- [Agent Skills Spec](https://agentskills.io/specification)
- [Keep a Changelog](https://keepachangelog.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)