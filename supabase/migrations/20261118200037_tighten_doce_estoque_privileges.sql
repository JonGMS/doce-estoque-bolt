/*
# Restringe privilégios do Doce Estoque

1. Objetivo
- Remove acesso da role anon às tabelas privadas, pois o app exige login.
- Impede que o navegador altere diretamente o saldo de produtos.
- Impede inserções manuais de histórico que não passem pela operação atômica.

2. Segurança
- Movimentações passam a ser lidas pelo usuário e criadas somente pela função protegida.
- O saldo de produtos é alterado somente por registrar_movimentacao e entregar_pedido.
- As políticas RLS existentes continuam limitando os registros ao proprietário.
*/

REVOKE ALL ON public.produtos, public.movimentacoes_estoque, public.pedidos, public.pedido_itens, public.receitas, public.receita_ingredientes, public.configuracoes FROM anon;

REVOKE INSERT, UPDATE, DELETE ON public.movimentacoes_estoque FROM authenticated;
GRANT SELECT ON public.movimentacoes_estoque TO authenticated;

REVOKE UPDATE ON public.produtos FROM authenticated;
GRANT UPDATE (codigo, nome, categoria, preco_unitario, estoque_minimo, descricao, foto_url) ON public.produtos TO authenticated;
