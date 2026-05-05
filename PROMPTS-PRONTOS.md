# Prompts Prontos — Cole no Claude Code antes de dormir

Escolha UM dos prompts abaixo, edite as tarefas, e cole no Claude Code.

---

## Prompt 1 — Genérico (qualquer projeto)

```
Trabalhe autonomamente nas próximas 10 horas. Siga este fluxo:

1. Leia CLAUDE.md e TODO.md para entender o projeto e as tarefas
2. Trabalhe nas tarefas [TONIGHT] do TODO.md, uma por vez
3. Para tarefas complexas, use Agent Teams (spawne teammates por domínio)
4. Após cada tarefa: commit em português, marque [DONE], documente no OVERNIGHT-LOG.md
5. Se travar 10+ min: documente e pule pra próxima
6. Quando acabar [TONIGHT], trabalhe no backlog

Configure um /loop de 30m para manter o trabalho contínuo e comece agora.
```

---

## Prompt 2 — Com Agent Teams explícito

```
Trabalhe autonomamente. Crie uma equipe de agentes:

- Teammate "frontend": Implementa componentes visuais e UI. Só mexe em arquivos de componentes/telas.
- Teammate "backend": Trabalha em API, banco de dados, lógica de negócio. Só mexe em arquivos de servidor/API.
- Teammate "quality": Roda testes, verifica build, checa cobertura. Não implementa — só valida.

Fluxo:
1. Leia CLAUDE.md e TODO.md
2. Trabalhe nas tarefas [TONIGHT]
3. Use a equipe quando a tarefa toca múltiplos módulos
4. Commit após cada tarefa, documente no OVERNIGHT-LOG.md
5. Se travar, documente e pule

Configure /loop 30m e comece pela primeira tarefa.
```

---

## Prompt 3 — Foco em uma tarefa específica

```
Trabalhe autonomamente na seguinte tarefa até completar:

[DESCREVA SUA TAREFA AQUI COM O MÁXIMO DE DETALHES]

Use Agent Teams se precisar dividir em frontend/backend/testes.
Faça commits incrementais em português.
Documente progresso no OVERNIGHT-LOG.md.
Se travar por mais de 10 min, documente o bloqueio e tente resolver de outra forma.
Quando completar, passe para as tarefas do TODO.md (se existir).

Configure /loop 30m e comece agora.
```

---

## Dicas:
- Quanto mais detalhado o CLAUDE.md, melhor o resultado
- Sempre tenha git inicializado (safety net)
- Desabilite suspensão do Windows antes de dormir
- Comece com tarefas simples nas primeiras noites
