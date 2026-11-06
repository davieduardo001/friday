# PRD: friday

## 1. Visão Geral

**Problema.** Cada projeto novo exige recriar agentes, skills e regras, e cada plataforma (GitHub, GitLab, Azure DevOps) usa comandos diferentes.

**Objetivo.** Um repositório único e portável com agentes genéricos e skills que executam a esteira (issue → PR → review → DoD) em qualquer das três plataformas, configurado por projeto em um único arquivo.

---

## 2. Contexto

- **Usuário:** Davi (PO e analista de requisitos, desenvolvedor da startup e da Orbyt)
- **CLI usados:** Claude Code, Gemini CLI
- **Plataformas suportadas:** GitHub, GitLab, Azure DevOps
- **Licença:** MIT

---

## 3. Casos de Uso

### CBU-001 — Instalar o friday globalmente
- **Dado:** um novo projeto na máquina do usuário
- **Quando:** o usuário executa `./instalar.sh`
- **Então:** os skills e agentes são criados em `~/.claude`, `~/.gemini` e `~/.agents/skills`

### CBU-002 — Configurar um novo projeto
- **Dado:** o usuário tem o friday instalado
- **Quando:** o usuário executa `instalar.sh --init-project` em um novo diretório
- **Então:** `projeto.md` é copiado de `projeto.model.md` e aberto no editor

### CBU-003 — Criar um issue
- **Dado:** um `projeto.md` válido
- **Quando:** o usuário executa o comando `issue "Título" "Descrição"`
- **Então:** o skill carrega a plataforma correspondente (`github`, `gitlab` ou `ado`) e cria o item

### CBU-004 — Abrir um PR vinculado
- **Dado:** um `projeto.md` válido com `repo` configurado
- **Quando:** o usuário executa o comando `pr "Título" "Descrição" --type feature`
- **Então:** o skill abre um PR vinculado ao issue na plataforma correta

### CBU-005 — Usar os agentes genéricos
- **Dado:** o friday está instalado
- **Quando:** o usuário força um agente (`dev`, `tester`, `reviewer`, `redator`, `analista`)
- **Então:** o agente segue suas regras e lê `AGENTS.md` + `projeto.md`

---

## 4. Requisitos Funcionais

| ID | Req | Descrição | Plataformas |
|----|-----|-----------|-------------|
| RF1 | Declarar plataforma | Arquivo com `platform: github|gitlab|ado` | Tres |
| RF2 | Skill platform-agnôstica | Each skill executa a mesma ação nas tres | Tres |
| RF3 | Instalador único | Comando em `~/.claude` e `~/.gemini` | Duas |
| RF4 | Sobrescrita local | Projeto pode sobrescrever regras/skills | Tres |

### Detalhes RF2 — Skill platform-agnôstica
- O skill `issue` carrega `plataformas/<plat>.md` conforme `projeto.md`
- Não há duplicação de regras entre plataformas
- Mapeamento unificado: conceitos -> comandos específicos

---

## 5. Requisitos Não Funcionais

| RNF | Req | Descrição |
|----|-----|-----------|
| RNF1 | Skills enxutas | Só a plataforma ativa entra no contexto |
| RNF2 | Sem credenciais | Nenhuma chave ou token no repositório |
| RNF3 | PT-BR formal | Texto formal em português nas entregáveis |

---

## 6. Critérios de Acesse (BDD)

| BDD | Input | Output |
|-----|-------|--------|
| BDD-001 | `projeto.md` com `plataforma: gitlab`, comando `issue "X"` | Skill usa `glab`, aplica milestone do sprint atual |
| BDD-002 | `projeto.md` com `plataforma: ado`, comando `pr` | Corpo contém `AB#<id>` do work item |
| BDD-003 | Projeto sem `projeto.md` | Skill pergunta em vez de assumir plataforma |

---

## 7. Riscos

| Risco | Mitigação |
|-------|----------|
| ADO não mapeia 1:1 | Mapeamento explícito no SPEC |
| MCP do ADO pesa no contexto | Ligamos só nos projetos ADO |
| Dados do cliente (Crea-SP) em agente externo | Confirmar política da Hepta antes |

---

## 8. Estrutura do Repositório

```
friday/
├── AGENTS.md          Regras comuns
├── project.model.md  Template do contrato
├── instalar.sh       Instalador global
├── skills/            issue, pr
│   └── plataformas/  github, gitlab, ado
├── agents/           dev, tester, reviewer, redator, analista
├── CHANGELOG.md
├── VERSION
├── LICENSE
└── README.md
```

---

## 9. Cronograma

| Iten | Status |
|------|--------|
| Esqueleto + instalar + modelo | Concluído |
| Skills issue no GitHub | Concluído |
| Skills issue no GitLab e ADO | Concluído |
| Agentes genéricos | Concluído |
| Teste real em projeto GitHub e ADO | Pendente |

---

## 10. Aprovado

**Aprovado por:** ____________________
**Data:** ____________________
