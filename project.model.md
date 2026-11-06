# projeto.model.md

## Contrato do projeto (projeto.md)

Este arquivo é o contrato do projeto e deve estar na raiz de cada projeto que usar dotfiles-ai.

```yaml
platform: github | gitlab | ado
repo: dono/nome            # (ado: organização/projeto/repo)
fluxo_branch: homolog-main | main
current_sprint: "Sprint 3"
teste: comando
arquitetura: link ou regras curtas
templates_us: caminho
```

## Requisitos do projeto

- `platform` é obrigatório
- `repo` é obrigatório
- `fluxo_branch` é opcional (padrão: main)
- `current_sprint` é opcional
- `teste` é opcional
- `arquitetura` é opcional
- `templates_us` é opcional

## Exemplos

### GitHub (repositório público)
```yaml
platform: github
repo: myorg/my-app
fluxo_branch: main
current_sprint: "Sprint 1"
teste: npm run test:ci
arquitetura: docs/ARCH.md
templates_us: .dotfiles-ai/templates/us.md
```

### GitLab (repositório privado)
```yaml
platform: gitlab
repo: myorg/my-app
fluxo_branch: homolog-main
current_sprint: "Sprint 2"
teste: npm run test
arquitetura: docs/ARCH.md
templates_us: .dotfiles-ai/templates/us.md
```

### Azure DevOps (repositório da Hepta)
```yaml
platform: ado
repo: hepta/gerenciar-servidores
fluxo_branch: homolog-main
current_sprint: "Sprint 4"
teste: npm run test
arquitetura: docs/ARCH.md
templates_us: .dotfiles-ai/templates/us.md
```

## Como usar

1. Copie este arquivo para o seu projeto como `projeto.md`
2. Preencha os campos conforme seu projeto
3. Salve o arquivo na raiz do projeto
4. As skills usarão este arquivo para identificar a plataforma e executar as ações corretas