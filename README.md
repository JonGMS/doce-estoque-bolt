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
