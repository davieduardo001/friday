# Plataforma GitLab — MR

## Comando
```bash
glab mr create --title "$TITULO" --description "$DESCRICAO" \
  --source-branch "feature/$(date +%Y%m%d)-$(date +%s)" \
  --target-branch "main" --label "bug,feature" --milestone "$SPRINT"
```

## Corpo do MR (template)
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
- Item de trabalho: MR (GitLab)
- Sprint: milestone
- Abrir PR: `glab mr create`
- Vincular: `Closes #N`
- Aprovação: approval da MR