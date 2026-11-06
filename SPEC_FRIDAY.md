# SPEC: friday

## 1. Estrutura
```
friday/
  AGENTS.md                 regras comuns (Claude e Gemini leem via import/config)
  project.modelo.md
  agents/                   dev, tester, reviewer, redator, analista
  skills/
    issue/  SKILL.md, plataformas/{github,gitlab,ado}.md
    pr/     SKILL.md, plataformas/{github,gitlab,ado}.md
  instalar.sh
```

---

## 2. Contrato do `projeto.md`
```yaml
plataforma: github | gitlab | ado
repo: dono/nome            (ado: organização/projeto/repo)
fluxo_branch: homolog-main | main
sprint_atual: "Sprint 3"
teste: comando
arquitetura: link ou regras curtas
templates_us: caminho
```

Campos obrigatórios: `platform`, `repo`  
Campos opcionais: `fluxo_branch`, `sprint_atual`, `teste`, `arquitetura`, `templates_us`

---

## 3. Contrato da Skill
- SKILL.md descreve ação, regras e formato do resultado
- Lê `projeto.md`, identifica a plataforma e carrega `plataformas/<plat>.md`
- Se `projeto.md` não existir: pergunta e oferece criar a partir de `projeto.model.md`

---

## 4. Mapeamento entre Plataformas

| Conceito | GitHub | GitLab | Azure DevOps |
|----------|--------|--------|--------------|
| Item de trabalho | issue | issue | work item (PBI/Bug) |
| Sprint | milestone | milestone | iteration path |
| Criar item | `gh issue create` | `glab issue create` | MCP ADO ou `az boards work-item create` |
| Abrir PR | `gh pr create` | `glab mr create` | MCP ADO ou `az repos pr create` |
| Vincular | `Closes #N` | `Closes #N` | `AB#N` |
| Aprovação | review formal | approval da MR | voto do reviewer |

---

## 5. Instalador
`instalar.sh` cria symlinks de `skills/` e `agents/` para `~/.claude` e `~/.gemini`:
- `--remover`: desfaz todos os links
- `--force`: substitui links existentes
- `--init-project`: copia `projeto.model.md` → `projeto.md` no diretório atual

---

## 6.Critérios de Aceite (BDD)
- GitLab: issue usa `glab` + milestone sprint
- ADO: PR corpo contém `AB#<id>` do work item
- Sem `projeto.md`: skill pergunta, não assume plataforma

---

## 7. Plano
1. Esqueleto + instalar + modelo ✅
2. Skills `issue` e `pr` no GitHub ✅
3. Mesmas skills em GitLab e ADO ✅
4. Agentes genéricos ✅
5. Teste real em GitHub e ADO 🔲

---

## 8. Versions Históricos

### v1.0.0
- Estrutura base criada
- `instalar.sh` implementado
- `AGENTS.md` com regras comuns
- `project.model.md` com contrato
- Skills `issue` e `pr` para GitHub, GitLab, ADO
- 5 agentes genéricos

---

## 9. Users Guide
1. Clone: `git clone https://github.com/davieduardo001/friday ~/.friday`
2. Instale: `cd ~/.friday && ./instalar.sh`
3. Configure: `cd meu-projeto && ~/.friday/instalar.sh --init-project`
4. Use: `issue "Título" "Desc"` / `pr "Título" "Desc" --type feature`
