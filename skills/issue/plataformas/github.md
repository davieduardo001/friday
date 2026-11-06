# SKILL.md — Issue

## Uso
`issue "Título" "Descrição" [--type bug|feature] [--sprint "Sprint 3"]`

## Regras comuns
- Segue Conventional Commits no título
- US em formato BDD (Dado/Quando/Então) para descrições
- Lê `projeto.md` na raiz do projeto (cwd ou ancestor)
- Identifica a plataforma e faz `source`/`include` de `plataformas/<plataforma>.md`
- Se o `projeto.md` não existir → pergunta e oferece criar a partir de `projeto.model.md`

## Plataformas

### GitHub
```bash
gh issue create --title "$TITULO" --body "$DESCRICAO" \
  --label "bug,feature" --milestone "$SPRINT"
```

### GitLab
```bash
glab issue create --title "$TITULO" --description "$DESCRICAO" \
  --label "bug,feature" --milestone "$SPRINT"
```

### Azure DevOps (MCP)
```bash
# Usar MCP ADO (padrão)
gh issue create --title "$TITULO" --body "$DESCRICAO" \
  --label "Bug,Feature" --milestone "$SPRINT"
```

## Exemplo
```
issue "Adicionar login" "Implementar autenticação com JWT"
```