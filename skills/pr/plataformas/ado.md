# Plataforma Azure DevOps — PR

## Comando (MCP)
```bash
# Usar MCP ADO (padrão)
gh pr create --title "$TITULO" --body "$DESCRICAO" \
  --head "feature/$(date +%Y%m%d)-$(date +%s)" \
  --base "main" --label "Bug,Feature" --milestone "$SPRINT"
```

## Comando (fallback az)
```bash
az repos pr create --title "$TITULO" --description "$DESCRICAO" \
  --source-branch "feature/$(date +%Y%m%d)-$(date +%s)" \
  --target-branch "main"
```

## Corpo do PR (template)
```
## Resumo
<!-- O que muda -->

## Tipo
- [ ] Feature
- [ ] Bugfix
- [ ] Refactor
- [ ] Docs

## Testes
- [ ] Unitários passam
- [ ] Integração passam

## DoD
- [ ] Código revisado
- [ ] Documentação atualizada
- [ ] Deploy em homolog validado

AB#<issue-id>
```

## Mapeamento
- Item de trabalho: PR (GitHub)
- Sprint: iteration path
- Abrir PR: MCP ADO ou `az repos pr create`
- Vincular: `AB#N`
- Aprovação: voto do reviewer