---
name: pr
description: Criar pull/merge requests em GitHub, GitLab ou Azure DevOps com Conventional Commits, descrição em US BDD e vínculo à issue via Closes #N. Use quando o usuário pedir para abrir um PR/MR, revisar ou vincular mudanças a uma issue.
---

# PR

## Uso
`pr "Título" "Descrição" [--type bug|feature] [--sprint "Sprint 3"]`

## Regras comuns
- Conventional Commits no título
- US em formato BDD para descrição
- Vincula a issue/PBI via `Closes #N` ou `AB#N`
- Aprovação: review formal (GitHub), approval da MR (GitLab), voto do reviewer (ADO)
- O skill usa `plataformas/<plataforma>.md` para criar/abrir PR

## Plataformas

### GitHub
```bash
gh pr create --title "$TITULO" --body "$DESCRICAO" \
  --head "feature/$(date +%Y%m%d)-$(date +%s)" \
  --base "main" --label "bug,feature" --milestone "$SPRINT"
```

### GitLab
```bash
glab mr create --title "$TITULO" --description "$DESCRICAO" \
  --source-branch "feature/$(date +%Y%m%d)-$(date +%s)" \
  --target-branch "main" --label "bug,feature" --milestone "$SPRINT"
```

### Azure DevOps (MCP)
```bash
# Usar MCP ADO (padrão)
gh pr create --title "$TITULO" --body "$DESCRICAO" \
  --head "feature/$(date +%Y%m%d)-$(date +%s)" \
  --base "main" --label "Bug,Feature" --milestone "$SPRINT"
```

## Exemplo
```
pr "Adicionar login" "Implementar autenticação com JWT" --type feature --sprint "Sprint 3"
```