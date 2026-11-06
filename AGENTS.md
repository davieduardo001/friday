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
  - `prd_dir` (opcional, padrão `docs/prd`) e `spec_dir` (opcional, padrão `docs/specs`)
  - **Local e nomes:** PRDs e SPECs ficam fora de diretórios de harness (`.claude/`, `.gemini/`...). Nome do arquivo: `<issue>-<slug>.md` (ex: `docs/prd/42-login-jwt.md`, `docs/specs/42-login-jwt.md`); sem issue, use só `<slug>.md`.
- **DoD** — Todo item deve passar:
  - Code review (dev ou reviewer)
  - Testes unitários e de integração
  - Documentação atualizada
  - Deploy em `homolog` validado

## Delegação por Agente

Toda tarefa solicitada (comunicar com o repositório, criar, revisar, documentar...) deve ser executada por um **agente** de `agents/`. A conversa principal só **orquestra**: entende o pedido, escolhe o agente, delega e reporta o resultado.

| Tipo de tarefa | Agente |
|----------------|--------|
| Escrever US, critérios de aceite, escopo, abrir/consultar issues | `analista` |
| Implementar, corrigir bug, branch, commits, abrir PR | `dev` |
| Escrever/rodar testes, validar `test_command` | `tester` |
| Revisar código/PR, validar DoD | `reviewer` |
| Documentação, README, CHANGELOG | `redator` |

Regras:
- **Uma tarefa, um agente.** Tarefa que cruza papéis (ex: implementar + testar) é dividida em etapas, cada uma com seu agente, na ordem do pipeline `issue → PR → review → DoD`.
- **Passe o contexto completo ao agente**: pedido original, `projeto.md`, issue/US relacionada e arquivos relevantes. O agente não herda a conversa.
- **O agente segue as regras comuns** deste arquivo e usa os skills `issue` e `pr` para falar com a plataforma.
- **Exceção — execução direta**: perguntas, explicações e ajustes triviais (ex: ler um arquivo, corrigir uma linha) não precisam de agente.
- **Portável entre CLIs**: use o mecanismo de subagente da CLI (ex: Agent tool no Claude Code, agentes do Gemini). Se a CLI não suportar subagentes, assuma o papel do agente carregando `agents/<nome>.md` e siga suas regras na própria conversa.

## Como cada CLI lê os skills

### Claude Code
- Skills e agentes são arquivos Markdown com frontmatter (`name`, `description`), instalados por `instalar.sh`.
- O agente **não** lê `AGENTS.md` automaticamente: o `CLAUDE.md` do projeto precisa conter `@AGENTS.md`. O `instalar.sh --init-project` cria isso.
- O `AGENTS.md` é copiado **para dentro do projeto**: importar arquivo de fora do projeto exige aprovação e, sem ela, não é carregado.
- Se o `projeto.md` não existir, o skill pergunta e oferece criar a partir do `projeto.model.md`.

### Gemini CLI
- Skills e agentes são arquivos Markdown com frontmatter (`name`, `description`).
- O agente **não** lê `AGENTS.md` automaticamente: o `GEMINI.md` do projeto precisa conter `@AGENTS.md`. O `instalar.sh --init-project` cria isso.

### opencode / Pi
- Leem `AGENTS.md` da raiz do projeto nativamente (o `--init-project` já o copia para lá).
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

- Se um skill não encontrar a plataforma no `projeto.md`, ele deve falhar com uma mensagem clara.
- Skills devem ser **portáteis** — funcionam em qualquer projeto que tenha o `projeto.md` correto.
