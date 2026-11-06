# AGENTS.md — Regras comuns e como cada CLI lê os skills

## Regras Comuns

- **Conventional Commits** — Todos os commits devem seguir o formato `type(scope): description` (ex: `feat(auth): add login endpoint`).
- **US com BDD** — Tudo deve ser em inglês, usando estrutura BDD (Dado/Quando/Então) para descrições de funcionalidade.
- **PRD/SPEC** — Cada projeto deve ter um `projeto.md` que documenta:
  - `platform` (github | gitlab | ado)
  - `repo` (ex: `myorg/my-repo`)
  - `branch_strategy` (main | homolog-main)
  - `current_sprint` (ex: "Sprint 3")
  - `test_command` (ex: `npm test`)
  - `architecture` (link para arquitetura ou regras curtas)
  - `us_template_path` (caminho para templates US)
- **DoD** — Todo item deve passar:
  - Code review (dev ou reviewer)
  - Testes unitários e de integração
  - Documentação atualizada
  - Deploy em `homolog` validado

## Como cada CLI lê os skills

### Claude Code
- Skills são arquivos Markdown no diretório raiz do projeto.
- O agente **não** lê `AGENTS.md` automaticamente; ele lê o `SKILL.md` de cada skill.
- `AGENTS.md` serve como **documentação** das regras comuns e como cada CLI deve interpretar os skills.
- Se o `projeto.md` não existir, o skill pergunta e oferece criar a partir do `projeto.model.md`.

### Gemini CLI
- Skills são arquivos Markdown no diretório raiz do projeto.
- O agente **não** lê `AGENTS.md` automaticamente; ele lê o `SKILL.md` de cada skill.
- `AGENTS.md` serve como **documentação** das regras comuns e como cada CLI deve interpretar os skills.
- Se o `projeto.md` não existir, o skill pergunta e oferece criar a partir do `projeto.model.md`.

## Ordem de Precedência para Regras do Projeto

1. `projeto.md` (no raiz do projeto) — o mais específico e recente.
2. `AGENTS.md` — regras comuns que se sobrepõem a qualquer skill.
3. Skill específico (ex: `issue` skill) — a lógica de execução do skill.

## Skill Interface

Cada skill deve ter um `SKILL.md` com:
- `name` (lowercase, no hífens consecutivos)
- `description` (o que o skill faz e quando usar)
- `user-invocable: true` (se pode ser chamado diretamente)
- `platforms` (lista de plataformas suportadas: github, gitlab, ado)

## Plataformas

| Conceito | GitHub | GitLab | Azure DevOps |
|----------|--------|--------|--------------|
| Item de trabalho | issue | issue | work item (PBI/Bug) |
| Sprint | milestone | milestone | iteration path |
| Criar item | `gh issue create` | `glab issue create` | MCP ADO ou `az boards work-item create` |
| Abrir PR | `gh pr create` | `glab mr create` | MCP ADO ou `az repos pr create` |
| Vincular | `Closes #N` | `Closes #N` | `AB#N` |
| Aprovação | review formal | approval da MR | voto do reviewer |

## Mapeamento MCP (ADO)

- **Default**: MCP ADO (leve apenas nos projetos ADO)
- **Fallback**: `az boards work-item create` (quando MCP não está disponível)
- O skill `issue` e `pr` usam o mapeamento acima para criar/abrir itens na plataforma correta.

## Notas

- `AGENTS.md` não é carregado automaticamente pelo Pi; é apenas uma referência para o modelo.
- Se um skill não encontrar a plataforma no `projeto.md`, ele deve falhar com uma mensagem clara.
- Skills devem ser **portáteis** — funcionam em qualquer projeto que tenha o `projeto.md` correto.
