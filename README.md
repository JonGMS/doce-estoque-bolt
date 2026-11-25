# Doce Estoque

**Sistema de gestão de receitas, estoque e pedidos para quem produz e vende brigadeiros.**

O **Doce Estoque** foi pensado principalmente para mulheres que trabalham por conta própria na confeitaria. A aplicação reúne informações sobre ingredientes, produtos, clientes, pedidos e entregas em um só lugar, ajudando a organizar a rotina desde a compra dos insumos até a entrega da encomenda.

## O problema

Uma encomenda começa com uma pergunta simples: **“Eu consigo entregar essa quantidade no dia combinado?”** Para responder, a vendedora precisa conferir quantos brigadeiros já estão prontos, quanto ainda precisa produzir, quais ingredientes tem em casa e quais pedidos já estão previstos para aquele dia.

Quando essas informações ficam espalhadas entre conversas de WhatsApp, cadernos, planilhas e anotações no celular, fica mais fácil esquecer um pedido, comprar ingredientes em excesso ou descobrir tarde demais que falta algum item para produzir.

O Doce Estoque centraliza essas informações para ajudar a empreendedora a responder perguntas do dia a dia:

- Quais ingredientes tenho e em que quantidade?
- Quanto de cada ingrediente a minha receita consome?
- Quantos brigadeiros já estão prontos para vender?
- O que preciso produzir para os próximos pedidos?
- Para quem devo entregar e em qual data?

## Para quem foi feito

As três personas abaixo representam rotinas diferentes de quem pode usar o sistema.

### Maria Eduarda — Estudante que busca uma renda extra

Maria Eduarda faz faculdade, tem um relacionamento e divide a semana entre aulas, trabalhos acadêmicos e compromissos pessoais. Ela começou a vender brigadeiros para complementar a renda e costuma produzir nos horários livres. Os pedidos chegam por mensagem, principalmente de colegas e conhecidos.

**Principal dificuldade:** encaixar a produção na semana e lembrar quais encomendas precisam ficar prontas antes das aulas ou de outros compromissos.

**Como o sistema ajuda:** Maria Eduarda registra clientes e pedidos, consulta as entregas na agenda e confere as receitas e os ingredientes antes de reservar um horário para produzir.

### Camila — Confeiteira autônoma que trabalha com encomendas

Camila produz brigadeiros em casa para aniversários e pequenas festas. Alguns pedidos são de poucas unidades e outros exigem várias receitas e sabores. Ela compra os ingredientes com o próprio dinheiro e precisa planejar as compras conforme o volume de encomendas.

**Principal dificuldade:** saber quanto produzir e comprar quando vários pedidos chegam para a mesma semana.

**Como o sistema ajuda:** Camila consulta a quantidade pedida, o rendimento das receitas e o saldo dos ingredientes para planejar os lotes e identificar o que precisa comprar.

### Renata — Vendedora que combina pronta-entrega e encomendas

Renata leva caixas de brigadeiros para vender em feiras e também aceita encomendas de clientes recorrentes. Durante a semana, ela precisa decidir quanto da produção pode levar para venda e quanto precisa reservar para entregas já combinadas.

**Principal dificuldade:** distinguir o que já está pronto, o que está comprometido com pedidos e o que ainda pode ser oferecido à pronta-entrega.

**Como o sistema ajuda:** Renata consulta os produtos disponíveis, acompanha os pedidos e usa a agenda para decidir quais entregas têm prioridade.

## Como a gestão funciona

O sistema organiza a operação em registros que se relacionam. **Ingredientes** são usados em **receitas**, receitas orientam a produção de **produtos**, e produtos são vendidos em **pedidos** associados a **clientes**. A data do pedido ajuda a organizar a **agenda de entregas**.

| Conceito | O que representa | Exemplo |
|---|---|---|
| **Estoque de ingredientes** | Os insumos disponíveis para produzir. Cada ingrediente tem uma quantidade e uma unidade de medida. | 800 g de leite condensado e 200 g de chocolate em pó. |
| **Receita** | A ficha de produção. Define os ingredientes, a quantidade usada de cada um e o rendimento de um lote. | Uma receita de brigadeiro tradicional rende 25 unidades. |
| **Produto** | O item que a vendedora oferece ao cliente, com identificação e preço de venda. | Brigadeiro tradicional vendido por unidade. |
| **Estoque de produtos** | A quantidade de itens acabados, disponível para pronta-entrega ou para atender encomendas. | 20 brigadeiros tradicionais já produzidos. |
| **Cliente** | A pessoa que compra ou encomenda os produtos. Seu cadastro ajuda a identificar o contato e os pedidos associados. | Uma cliente que encomendou brigadeiros para uma festa. |
| **Pedido** | O registro do que foi combinado com o cliente, como produtos, quantidades e data de entrega. | Uma encomenda de 70 brigadeiros para sábado. |
| **Agenda** | A visão dos pedidos organizados por data de entrega. | Consultar quais encomendas precisam estar prontas no sábado. |

### Exemplo de uma encomenda

Imagine que Maria Eduarda recebeu um pedido de **70 brigadeiros tradicionais** para sábado. Ela já tem **20 unidades prontas e disponíveis**, então precisa produzir **50 unidades**.

Se uma receita rende **25 unidades**, ela precisa fazer **dois lotes**. Supondo que cada lote use **395 g de leite condensado** e **50 g de chocolate em pó**, ela precisará de **790 g de leite condensado** e **100 g de chocolate em pó** para a produção.

O fluxo de trabalho fica assim:

1. **Registrar o pedido** com o cliente, o produto, a quantidade e a data.
2. **Conferir os produtos prontos** que podem ser usados nessa encomenda.
3. **Consultar a receita** para calcular quantos lotes faltam.
4. **Conferir o estoque de ingredientes** e planejar as compras, se necessário.
5. **Produzir e atualizar os saldos** conforme as movimentações realizadas.
6. **Consultar a agenda** para cumprir a entrega no dia combinado.

O cálculo acima explica a lógica de gestão que conecta os módulos. Na operação, **registrar um pedido representa uma encomenda, produzir consome ingredientes e gera produtos prontos, e entregar usa os produtos acabados**. Cada etapa muda uma informação diferente do negócio.

## Módulos da aplicação

| Módulo | Papel na rotina |
|---|---|
| **Dashboard** | Reúne informações da operação para a usuária começar o dia e identificar o que precisa de atenção. |
| **Produtos** | Organiza o catálogo de brigadeiros e os dados dos itens vendidos. As receitas descrevem como esses produtos são preparados e quanto cada lote rende. |
| **Estoque** | Permite consultar os saldos e organizar as quantidades de ingredientes e produtos prontas para uso ou venda. |
| **Pedidos** | Centraliza as encomendas e as informações necessárias para acompanhar cada venda. |
| **Clientes** | Organiza os cadastros e contatos das pessoas atendidas. |
| **Agenda** | Permite consultar a programação de entregas por data. |
| **Relatórios** | Reúne informações para acompanhar a operação e consultar seus registros ao longo do tempo. |
| **Configurações** | Agrupa as opções de configuração disponibilizadas pela aplicação. |

## Tecnologias utilizadas

| Tecnologia | Uso no projeto |
|---|---|
| **Bolt.new** | Ferramenta de IA usada para gerar e evoluir o projeto a partir de prompts. |
| **React** | Construção das telas e dos componentes da interface. |
| **TypeScript** | Tipagem dos dados e implementação da lógica da aplicação. |
| **Tailwind CSS** | Estilização e organização visual da interface. |
| **Vite** | Servidor de desenvolvimento e geração do build da aplicação. |
| **Supabase** | Integração com o banco de dados e autenticação. |
| **PostgreSQL e PL/pgSQL** | Estrutura do banco, migrations e rotinas SQL quando aplicáveis. |
| **Git e GitHub** | Versionamento, armazenamento do código e documentação do projeto. |

Na captura do repositório, o GitHub identificou **TypeScript (70,9%)**, **PL/pgSQL (27%)**, **JavaScript (1,3%)** e **HTML (0,8%)**. Esses percentuais refletem a composição dos arquivos naquele momento.

### Como o Bolt foi usado

O desenvolvimento partiu da definição do problema, das personas e dos fluxos que a aplicação precisava atender. Esses requisitos foram descritos em prompts para o Bolt criar a estrutura do projeto, montar as telas e integrar os dados ao Supabase. Os prompts também registram os pedidos de ajustes feitos ao longo do desenvolvimento, como melhorias no alinhamento dos ícones, no espaçamento das telas e na atualização da lista de pedidos.

Consulte a pasta [Prompts usados no Bolt](./prompts) para acompanhar as instruções que deram origem ao projeto e às suas atualizações.

## Estrutura do repositório

```text
doce-estoque/
├── .bolt/                 # Configurações do projeto para o Bolt
├── src/                   # Código-fonte da aplicação
├── supabase/
│   └── migrations/        # Alterações versionadas do banco de dados
├── prompts/               # Prompts usados no desenvolvimento
├── .env.example           # Modelo das variáveis de ambiente
├── .gitignore             # Regras de arquivos ignorados pelo Git
├── package.json           # Dependências e scripts do projeto
├── schema.sql             # Arquivo SQL de referência do banco
└── README.md              # Documentação do projeto
```

## Como baixar e executar

### 1. Baixe o código

Tenha o **Node.js com npm** e o **Git** instalados. No terminal, execute:

```bash
git clone [https://github.com/JonGMS/doce-estoque.git](https://github.com/JonGMS/doce-estoque-bolt.git)
cd doce-estoque
npm ci
```

Também é possível baixar o código pelo GitHub em **Code → Download ZIP**. Depois, extraia o arquivo, abra a pasta extraída no terminal e execute `npm ci`.

### 2. Configure o ambiente

Crie um arquivo `.env` a partir do `.env.example`.

**Windows com PowerShell**

```powershell
Copy-Item .env.example .env
```

**Linux, macOS ou Git Bash**

```bash
cp .env.example .env
```

Abra o `.env` e preencha as variáveis com a URL e a chave pública do seu projeto Supabase, usando os nomes definidos no `.env.example`. Mantenha o `.env` fora do controle de versão. Use somente a chave pública do Supabase na configuração do frontend.

### 3. Prepare o banco de dados

Crie ou use um projeto Supabase no qual você tenha acesso. Se o banco estiver vazio, aplique as migrations em `supabase/migrations/` em ordem cronológica. Elas definem a estrutura esperada pela aplicação. Se o banco já estiver configurado, confira quais migrations já foram aplicadas antes de executar as restantes.

### 4. Inicie o projeto

```bash
npm run dev
```

Abra no navegador o endereço local exibido no terminal. Para conferir se o ambiente está funcionando, faça login ou crie uma conta pela interface e teste um fluxo completo: **cadastre um cliente, crie um pedido e confira se ele aparece na lista de pedidos e na agenda da data escolhida**.

Para gerar os arquivos de produção, execute:

```bash
npm run build
```



# Doce Estoque

MVP para controle de produtos, estoque, receitas e pedidos de uma vendedora autônoma de brigadeiros.

## Entrega

- Dashboard com produtos, saldo, alertas e resumo de pedidos.
- Produtos com busca, filtro, cadastro, edição e exclusão protegida por confirmação.
- Estoque com entrada e saída atômicas, histórico, indicadores e exportação CSV.
- Pedidos com cliente, data, produtos, quantidade, preço preservado, total e entrega segura.
- Relatórios por período com faturamento, pedidos entregues e movimentações.
- Receitas com produto associado, rendimento, ingredientes e modo de preparo.
- Configurações para nome do negócio e responsável, exibidas no cabeçalho e Dashboard.
- Login por e-mail e senha do Supabase.

## Modelo de dados

`produtos` guarda o catálogo e o saldo atual. `movimentacoes_estoque` referencia produtos e registra o histórico. `pedidos` possui muitos `pedido_itens`, e cada item guarda o preço unitário usado no momento da criação. `receitas` pertence a um produto e possui muitos `receita_ingredientes`. `configuracoes` guarda os nomes da conta.

Todas as tabelas têm RLS e políticas separadas de leitura, criação, alteração e exclusão, sempre limitadas ao usuário autenticado. As funções `registrar_movimentacao`, `criar_pedido` e `entregar_pedido` validam os dados no banco; a entrega verifica o saldo e gera a saída apenas uma vez.

## Arquivos importantes

- `schema.sql`: documentação do modelo aplicado.
- `src/lib/supabase.ts`: cliente público do Supabase.
- `.env.example`: nomes das variáveis necessárias para execução.

## Verificações

A estrutura do banco foi aplicada ao projeto Supabase provisionado. O CRUD, os fluxos de estoque e os pedidos foram implementados para validação no preview/publicação. A busca, edição, acompanhamento de status e entrega dos pedidos estão disponíveis, assim como o acesso à receita na edição do produto. O cadastro final de produtos e a confirmação manual no Table Editor dependem de uma sessão autenticada criada pelo responsável do projeto; a publicação e o envio para GitHub não foram executados nesta sessão.
