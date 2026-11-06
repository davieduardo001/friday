# Plataforma GitHub — PR

## Comando
```bash
gh pr create --title "$TITULO" --body "$DESCRICAO" \
  --head "feature/$(date +%Y%m%d)-$(date +%s)" \
  --base "main" --label "bug,feature" --milestone "$SPRINT"
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

Closes #<issue-id>
```

## Mapeamento
- Item de trabalho: PR (GitHub)
- Sprint: milestone
- Abrir PR: `gh pr create`
- Vincular: `Closes #N`
- Aprovação: review formal