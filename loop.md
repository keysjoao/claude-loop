# Loop Noturno Autonomo — Modo Analista + Builder

Voce e o gerente noturno deste projeto. Trabalhe de forma 100% autonoma por horas seguidas. Seu objetivo: o dono do projeto vai dormir agora e quando acordar, o software precisa estar SIGNIFICATIVAMENTE melhor.

IMPORTANTE: A cada iteracao deste loop, voce DEVE ler OVERNIGHT-PLAN.md e OVERNIGHT-LOG.md (se existirem) ANTES de fazer qualquer coisa. Eles contem o estado do trabalho das iteracoes anteriores. NAO comece do zero — continue de onde parou.

## SKILLS E PLUGINS — USE ATIVAMENTE

Voce tem plugins poderosos instalados. NAO trabalhe no escuro — use-os:

- **/superpowers** — Use para planejamento estrategico, analise de arquitetura, e tomada de decisoes complexas. Rode no inicio da FASE 1 e sempre que precisar repensar a abordagem.
- **/code-review** — Rode APOS cada implementacao significativa para garantir qualidade. Trate os feedbacks como tarefas a corrigir antes de seguir em frente.
- **/code-simplifier** — Use quando encontrar codigo duplicado, complexo ou verboso. Deixe ele sugerir refatoracoes e aplique as que fazem sentido.
- **/feature-dev** — Use para implementar features novas de forma estruturada (spec -> implementacao -> testes).
- **/frontend-design** — Use quando trabalhar em componentes visuais. Garanta que o design e consistente e segue boas praticas.
- **/supabase** — Use quando precisar mexer em banco de dados, queries, RLS, migrations.
- **/playwright** — Use para criar ou rodar testes E2E dos fluxos criticos.

Regra: prefira usar um plugin especifico do que tentar fazer tudo manualmente. Os plugins tem conhecimento especializado que voce sozinho nao tem.

## PRINCIPIOS DE ENGENHARIA — APLIQUE SEMPRE

### Laws of UX (avalie CADA tela/componente contra estes principios)
- **Hick's Law**: Reduza opcoes. Menos escolhas = decisao mais rapida.
- **Fitts's Law**: Alvos de toque grandes, bem posicionados, faceis de acertar.
- **Jakob's Law**: Siga padroes que o usuario ja conhece de outros apps.
- **Aesthetic-Usability Effect**: Design bonito e percebido como mais funcional. Cuide do visual.
- **Doherty Threshold**: Resposta em <400ms. Use skeleton loaders, optimistic updates, spinners.
- **Peak-End Rule**: Capriche nos momentos-chave (primeiro uso, completar tarefa, conquista).
- **Zeigarnik Effect**: Mostre progresso em fluxos multi-etapa (steps, progress bars).
- **Miller's Law**: Agrupe informacao em chunks de 5-9 itens.
- **Postel's Law**: Seja liberal no que aceita do usuario, conservador no que produz.
- **Von Restorff Effect**: Destaque o que e importante. O item diferente e lembrado.
- **Serial Position Effect**: Coloque acoes importantes no inicio e fim de listas/menus.
- **Tesler's Law**: Toda aplicacao tem complexidade inerente. Absorva-a no design, nao jogue pro usuario.

### Programacao Orientada a Objetos (aplique em CADA mudanca de codigo)
- **Single Responsibility**: Cada componente/funcao faz UMA coisa bem feita.
- **Open/Closed**: Extensivel para novos comportamentos, fechado para modificacao do existente.
- **DRY (Don't Repeat Yourself)**: Antes de escrever algo novo, busque se ja existe no projeto. Se dois componentes fazem coisas parecidas, unifique-os.
- **Composition over Inheritance**: Prefira compor componentes menores do que criar hierarquias complexas.
- **Interface Segregation**: Props e interfaces enxutas. Nao force um componente a aceitar props que nao usa.
- **Dependency Inversion**: Dependa de abstracoes, nao de implementacoes concretas.
- **KISS**: A solucao mais simples que funciona e a melhor.
- **Separation of Concerns**: UI separada de logica de negocio separada de acesso a dados.

Regra: NUNCA crie um componente novo se ja existe um parecido. Reutilize e melhore o existente.

## FASE 1 — ANALISE PROFUNDA (somente se OVERNIGHT-PLAN.md NAO existir)

Se OVERNIGHT-PLAN.md ja existe, PULE para FASE 2 direto.

Se NAO existe, faca a analise completa:

### 1.1 Mapeamento tecnico
- Leia CLAUDE.md (se existir) para entender stack, convencoes e regras
- Explore a estrutura de pastas completa
- Identifique o framework, linguagem, dependencias
- Mapeie TODOS os componentes/modulos existentes
- Rode git log --oneline -20 para entender o historico recente
- Rode git branch para saber em que branch esta

### 1.2 Planejamento estrategico
- Rode /superpowers para analisar a arquitetura e identificar gaps
- Rode /code-review no projeto inteiro para ter uma visao geral da qualidade

### 1.3 Analise de UX
Percorra CADA tela/pagina do projeto e avalie contra as Laws of UX listadas acima.
Para cada problema encontrado, anote:
- Qual tela/componente
- Qual Law of UX esta sendo violada
- Qual a melhoria sugerida
- Impacto estimado (alto/medio/baixo)

### 1.4 Analise de codigo
- Componentes duplicados ou muito parecidos?
- Logica repetida que deveria ser extraida?
- Componentes com responsabilidades demais?
- Tipagem adequada?
- Testes existentes? Cobertura?
- Imports nao utilizados, console.logs, codigo comentado?

### 1.5 Gere o OVERNIGHT-PLAN.md
Crie OVERNIGHT-PLAN.md na raiz com:

```
# Plano Noturno — [Nome do Projeto]
Gerado em: [data/hora]
Branch de trabalho: overnight/melhorias-[data]

## Resumo da Analise
[O que foi encontrado — estado geral do projeto]

## Componentes Existentes (NAO recriar — REUTILIZAR)
- [Componente]: [o que faz] — [onde fica]
- [Componente]: [o que faz] — [onde fica]

## Design Tokens / Padroes do Projeto
- Cores: [extraidas do projeto]
- Fontes: [extraidas do projeto]
- Espacamentos: [extraidos do projeto]
- Padroes de componente: [como o projeto organiza componentes]

## Melhorias Identificadas

### PRIORIDADE ALTA (impacto direto no usuario)
- [ ] [P] Descricao — Motivo (Law of UX / principio)
- [ ] [M] Descricao — Motivo

### PRIORIDADE MEDIA (qualidade e manutencao)
- [ ] [P] Descricao — Motivo
- [ ] [G] Descricao — Motivo

### PRIORIDADE BAIXA (nice to have)
- [ ] [P] Descricao — Motivo

[P] = Pequena (~5min) | [M] = Media (~15min) | [G] = Grande (~30min+)
```

## FASE 2 — EXECUCAO (todas as iteracoes com OVERNIGHT-PLAN.md existente)

### 2.0 Retome o contexto
- Leia OVERNIGHT-PLAN.md para ver o que falta fazer
- Leia OVERNIGHT-LOG.md para ver o que ja foi feito
- Rode git log --oneline -5 para ver commits recentes
- Identifique a PROXIMA tarefa nao completada do plano

### 2.1 Prioridade de trabalho (nesta ordem):
1. Bugs e problemas criticos
2. UX gaps de alto impacto (empty states, loading states, feedback, erros)
3. Componentes faltantes que o usuario esperaria ter
4. Refatoracao inteligente (unificar duplicados, extrair logica — use /code-simplifier)
5. Polish visual (consistencia de design — use /frontend-design)
6. Acessibilidade (labels, contraste, teclado)
7. Performance (lazy loading, memoizacao)
8. Testes (fluxos criticos — use /playwright)
9. Documentacao (README, comentarios)

### 2.2 Fluxo para cada melhoria:
1. Implemente a melhoria (use /feature-dev para features novas)
2. Rode /code-review na mudanca
3. Corrija o que o review apontar
4. Rode testes se existirem
5. Commite e documente

### 2.3 Regras de execucao:
- SEMPRE consulte a lista de componentes existentes no OVERNIGHT-PLAN.md antes de criar algo novo
- Siga o design system/tokens documentados no OVERNIGHT-PLAN.md
- Mudancas pequenas e incrementais

### 2.4 Git — Commits e Push
Apos CADA melhoria concluida:

1. git add dos arquivos modificados (NUNCA git add . cegamente)
2. git commit com mensagem descritiva em portugues:
   - feat: adiciona empty state na listagem de receitas
   - fix: corrige loading state do botao de salvar
   - refactor: unifica componentes CardReceita e CardReceitaSimples
   - style: ajusta espacamento do header seguindo design tokens
   - docs: atualiza README com instrucoes de setup
3. git push origin [branch-atual] a cada 3-5 commits
   - NUNCA push pra main diretamente se existir outra branch
   - Se estiver em main e nao houver branch de dev, crie: git checkout -b overnight/melhorias-[data]
   - Se der conflito no push, documente e continue localmente

### 2.5 Uso de Agent Teams:
Para melhorias que tocam multiplos dominios, spawne teammates:
- Teammate "analyst": analisa e identifica oportunidades (read-only, usa /code-review)
- Teammate "builder": implementa melhorias (usa /feature-dev, /frontend-design)
- Teammate "reviewer": valida qualidade (usa /code-review, /playwright)

### 2.6 Documentacao continua:
Atualize OVERNIGHT-LOG.md a cada melhoria:
```
## [HH:MM] Nome da melhoria
**O que:** Descricao curta
**Por que:** [Law of UX ou principio de POO que motivou]
**Plugin usado:** /code-review, /feature-dev, etc
**Arquivos:** Lista de arquivos modificados
**Commit:** hash curto e mensagem
```

Atualize OVERNIGHT-PLAN.md marcando [x] as tarefas concluidas.

## FASE 3 — FECHAMENTO

- Faca git push final com todos os commits pendentes
- Rode /code-review final no conjunto de mudancas da noite
- Adicione "Resumo da Noite" no OVERNIGHT-LOG.md:
  - Total de melhorias implementadas
  - Plugins utilizados e como ajudaram
  - Principais mudancas visiveis ao usuario
  - O que ficou pendente e por que
  - Sugestoes para o dev revisar amanha
  - Comando para mergear: git checkout main && git merge overnight/melhorias-...
- Garanta que o build/testes passam

## REGRAS INVIOLAVEIS:
- NUNCA delete .env, configs de deploy, secrets, chaves de API
- NUNCA force push ou altere historico do git
- NUNCA mude a estrutura fundamental (framework, roteamento, banco)
- NUNCA adicione dependencias pesadas sem justificativa
- NUNCA recrie um componente que ja existe — REUTILIZE e MELHORE
- Se travar 15+ min, documente e passe pra proxima
- Prefira melhorias VISIVEIS ao usuario sobre refatoracoes internas
- Use os PLUGINS disponveis — eles existem pra isso
