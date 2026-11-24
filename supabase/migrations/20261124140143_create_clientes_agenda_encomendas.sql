/*
# Adiciona clientes e agenda de encomendas

1. Novos dados
- `clientes`: nome e telefone/WhatsApp do cliente autenticado.
- `pedidos.cliente_id`: vínculo opcional com um cliente cadastrado, preservando pedidos antigos.
- `pedidos.horario_entrega`: horário opcional usado pela agenda.

2. Integridade
- Clientes pertencem ao usuário autenticado.
- O cliente e o produto da nova encomenda precisam pertencer ao mesmo usuário.
- A função `criar_encomenda` cria o pedido e seu item com o preço vigente em uma única operação.
- Pedidos antigos continuam válidos porque `cliente_id` e `horario_entrega` aceitam nulo.

3. Segurança
- RLS e quatro policies CRUD são adicionadas para `clientes`.
- A função da encomenda usa `SECURITY DEFINER`, valida o usuário pela sessão e só pode ser chamada por usuários autenticados.
- Nenhuma credencial privilegiada é exposta ao navegador.
*/

CREATE TABLE IF NOT EXISTS public.clientes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  nome text NOT NULL CHECK (char_length(trim(nome)) >= 2),
  telefone text NOT NULL CHECK (char_length(trim(telefone)) >= 8),
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.pedidos ADD COLUMN IF NOT EXISTS cliente_id uuid REFERENCES public.clientes(id) ON DELETE SET NULL;
ALTER TABLE public.pedidos ADD COLUMN IF NOT EXISTS horario_entrega time;

CREATE INDEX IF NOT EXISTS clientes_user_nome_idx ON public.clientes (user_id, nome);
CREATE INDEX IF NOT EXISTS pedidos_user_data_hora_idx ON public.pedidos (user_id, data_entrega, horario_entrega);

ALTER TABLE public.clientes ENABLE ROW LEVEL SECURITY;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.clientes TO authenticated;

DROP POLICY IF EXISTS "clientes_select_own" ON public.clientes;
CREATE POLICY "clientes_select_own" ON public.clientes FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "clientes_insert_own" ON public.clientes;
CREATE POLICY "clientes_insert_own" ON public.clientes FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "clientes_update_own" ON public.clientes;
CREATE POLICY "clientes_update_own" ON public.clientes FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "clientes_delete_own" ON public.clientes;
CREATE POLICY "clientes_delete_own" ON public.clientes FOR DELETE TO authenticated USING (auth.uid() = user_id);

CREATE OR REPLACE FUNCTION public.criar_encomenda(p_cliente_id uuid, p_produto_id uuid, p_quantidade integer, p_data_entrega date, p_horario_entrega time, p_observacoes text DEFAULT '')
RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $$
DECLARE
  v_cliente public.clientes;
  v_produto public.produtos;
  v_pedido_id uuid;
BEGIN
  IF p_quantidade IS NULL OR p_quantidade <= 0 OR p_data_entrega IS NULL THEN
    RAISE EXCEPTION 'Dados da encomenda inválidos';
  END IF;
  SELECT * INTO v_cliente FROM public.clientes WHERE id = p_cliente_id AND user_id = auth.uid();
  IF v_cliente.id IS NULL THEN RAISE EXCEPTION 'Cliente não encontrado'; END IF;
  SELECT * INTO v_produto FROM public.produtos WHERE id = p_produto_id AND user_id = auth.uid();
  IF v_produto.id IS NULL THEN RAISE EXCEPTION 'Produto não encontrado'; END IF;
  INSERT INTO public.pedidos (cliente_id, cliente, data_entrega, horario_entrega, observacoes, total)
  VALUES (v_cliente.id, v_cliente.nome, p_data_entrega, p_horario_entrega, COALESCE(p_observacoes, ''), v_produto.preco_unitario * p_quantidade)
  RETURNING id INTO v_pedido_id;
  INSERT INTO public.pedido_itens (pedido_id, produto_id, quantidade, preco_unitario, subtotal)
  VALUES (v_pedido_id, v_produto.id, p_quantidade, v_produto.preco_unitario, v_produto.preco_unitario * p_quantidade);
  RETURN v_pedido_id;
END;
$$;

REVOKE EXECUTE ON FUNCTION public.criar_encomenda(uuid, uuid, integer, date, time, text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.criar_encomenda(uuid, uuid, integer, date, time, text) TO authenticated;
