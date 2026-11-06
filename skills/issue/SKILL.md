---
name: issue
description: Criar, listar e gerenciar issues/bugs/features em GitHub, GitLab ou Azure DevOps com Conventional Commits no título e descrição em US formato BDD (Dado/Quando/Então). Use quando o usuário pedir para abrir uma issue, reportar um bug, criar uma task/história de usuário ou consultar issues do repositório.
---

# Issue

### Uso
`issue "Título" "Descrição" [--type bug|feature] [--sprint "Sprint 3"]`

### Regras comuns
- Conventional Commits no título
- US em formato BDD (Dado/Quando/Então) para descrições
- O skill usa `plataformas/<plataforma>.md` para criar/abrir itens
- Se `projeto.md` não existir, o skill pergunta e oferece criar a partir de `projeto.model.md`

### Plataformas
- **GitHub**: `gh issue create`
- **GitLab**: `glab issue create`
- **Azure DevOps**: MCP ADO ou `az boards work-item create`

### Mapeamento
- `Closes #N` no corpo do PR
- Aprovação via review formal (GitHub), approval da MR (GitLab), voto do reviewer (ADO)

### Exemplo
```
issue "Adicionar login" "Implementar autenticação com JWT"
```

### Skill AGENTS.md
O `AGENTS.md` define as regras comuns e como cada CLI (Claude Code, Gemini) lê os skills.
