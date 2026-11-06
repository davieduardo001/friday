# Plataforma Azure DevOps — Issue (Work Item)

## Comando (MCP ADO)
```bash
# Usar MCP ADO (padrão)
gh issue create --title "$TITULO" --body "$DESCRICAO" \
  --label "Bug,Feature" --milestone "$SPRINT"
```

## Comando (fallback az)
```bash
az boards work-item create --type "PBI" --title "$TITULO" --description "$DESCRICAO"
```

## Mapeamento
- Item de trabalho: work item (PBI/Bug)
- Sprint: iteration path
- Criar item: MCP ADO ou `az boards work-item create`
- Vincular: `AB#N`
- Aprovação: voto do reviewer
