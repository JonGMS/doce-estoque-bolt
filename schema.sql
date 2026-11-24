/*
  Doce Estoque — esquema aplicado no Supabase

  Tabelas:
  - produtos: catálogo e saldo atual por usuário.
  - movimentacoes_estoque: histórico de entradas e saídas; cada produto possui várias.
  - pedidos / pedido_itens: pedidos e seus itens com preço preservado no momento da criação.
  - receitas / receita_ingredientes: uma receita por produto, com rendimento e ingredientes.
  - configuracoes: identidade do negócio por usuário.

  Relacionamentos:
  produtos 1:N movimentacoes_estoque e pedido_itens.
  produtos 1:1 receitas; receitas 1:N receita_ingredientes.
  pedidos 1:N pedido_itens.
  Todas as tabelas possuem user_id ligado a auth.users e RLS com políticas CRUD separadas.

  A versão executada está registrada na migração create_doce_estoque_schema e inclui as funções
  registrar_movimentacao, criar_pedido e entregar_pedido para manter estoque e pedidos atômicos.
  Para reconstruir um projeto, aplique o conteúdo da migração correspondente no SQL Editor.
*/

-- O schema completo foi aplicado incrementalmente pelo migration runner do projeto.
-- Não há comandos destrutivos neste arquivo; os dados existentes são preservados.
