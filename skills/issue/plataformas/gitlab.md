# Plataforma GitLab — Issue

## Comando
```bash
glab issue create --title "$TITULO" --description "$DESCRICAO" \
  --label "bug,feature" --milestone "$SPRINT"
```

## Mapeamento
- Item de trabalho: issue
- Sprint: milestone
- Criar item: `glab issue create`
- Vincular: `Closes #N`
- Aprovação: approval da MR
