# AI Engineering Playbook

Como construo software com agentes de código sem abrir mão da disciplina de engenharia.

Não é uma coleção de prompts. É o sistema operacional ao redor do agente: um contrato, um plano com gates, testes como rede de segurança, revisão humana do diff e uma rotina de higiene de segredos que assume que o agente vai errar em algum momento.

[English](README.md) · [Español](README.es.md) · [日本語](README.ja.md)

---

## O problema

Agentes de código são rápidos e confiantes. Essa combinação é perigosa quando a tarefa toca produção, dados pessoais, credenciais ou código de clientes.

Os modos de falha para os quais eu projeto:

- o agente diz que um teste passou quando apenas abriu o app;
- um plano muda de escopo no meio da implementação;
- um segredo acaba em um commit, fixture ou screenshot;
- um "pequeno refactor" reescreve uma interface pública;
- o diff é grande demais para revisar, então ninguém revisa;
- o contexto se perde e a próxima sessão repete os mesmos erros.

## O método

### 1. Um contrato: `AGENTS.md`

O repositório tem um contrato escrito para agentes: missão, fonte da verdade, invariantes, ações proibidas, requisitos de verificação e definição de pronto. É curto para ler e específico para cobrar.

Template: [`templates/AGENTS.md`](templates/AGENTS.md)

### 2. Um plano com gates

O trabalho é dividido em fases. Cada fase tem objetivo, relatório, evidência e gate. Se uma fase não consegue cumprir o gate, ela para e pergunta; não improvisa.

Template: [`docs/PLAN-TEMPLATE.md`](docs/PLAN-TEMPLATE.md)

### 3. Testes como rede

Um teste que apenas abre o app não é um teste aprovado. Ele precisa importar, editar, salvar, reabrir e renderizar quando o produto faz isso. Verificações que dependem de hardware são marcadas e puladas apenas quando o hardware realmente não existe.

Guia: [`docs/TESTING-WITH-AGENTS.md`](docs/TESTING-WITH-AGENTS.md)

### 4. Revisão humana do diff

O agente propõe; a pessoa aceita. A revisão procura scope creep, mudanças silenciosas de interface, testes removidos, dependências novas, segredos, PII e documentação enganosa.

Checklist: [`docs/REVIEW-CHECKLIST.md`](docs/REVIEW-CHECKLIST.md)

### 5. Higiene de segredos

Assuma que um segredo vai acabar colado em algum lugar. Projete para que ele não chegue ao repositório:

- escaneie arquivos rastreados, não apenas o working tree;
- escaneie arquivos ocultos e rastreados mas ignorados;
- defina uma identidade de commit pública;
- use histórico Git novo para releases públicos;
- rode um check pré-push que falhe fechado;
- rotacione qualquer coisa que tenha sido exposta.

Guia: [`docs/SECRET-HYGIENE.md`](docs/SECRET-HYGIENE.md)  
Script: [`scripts/check-no-secrets.sh`](scripts/check-no-secrets.sh)

### 6. MCP e ferramentas locais

Servidores MCP são poderosos e fáceis de permitir demais. Vincule a localhost, limite tokens, registre chamadas e nunca coloque um token em um config que possa ser commitado.

Guia: [`docs/MCP-SETUP.md`](docs/MCP-SETUP.md)

---

## O que há neste repositório

```text
templates/AGENTS.md          template de contrato para um repositório
docs/PLAN-TEMPLATE.md        plano por fases com gates e evidência
docs/REVIEW-CHECKLIST.md     checklist de revisão humana
docs/TESTING-WITH-AGENTS.md  estratégia de testes para código escrito por agentes
docs/MCP-SETUP.md            configuração local de MCP e permissões
docs/SECRET-HYGIENE.md       varredura, identidade de commit, resposta a incidentes
scripts/check-no-secrets.sh  scanner pequeno sem dependências
```

## O que isto não é

- Não é uma lista de prompts mágicos.
- Não afirma que agentes substituem revisão.
- Não garante que uma varredura encontre todos os segredos.
- Não está preso a um fornecedor; os exemplos usam ferramentas genéricas.

## Para quem é

Para engenheiros que usam agentes de código em repositórios reais, especialmente quando o trabalho toca produção, dados pessoais ou código de clientes.

## Licença

CC BY 4.0. Ver [`LICENSE`](LICENSE).
