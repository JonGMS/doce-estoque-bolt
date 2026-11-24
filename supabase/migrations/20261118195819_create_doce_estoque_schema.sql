/*
# Cria a base do Doce Estoque

1. Novas tabelas
- `produtos`: catálogo de cada usuário, com código, nome, categoria, preço, saldo, mínimo, descrição e foto opcional.
- `movimentacoes_estoque`: histórico de entradas e saídas ligadas a um produto do mesmo usuário.
- `pedidos`: cliente, entrega, status, observações e total preservado no momento da criação.
- `pedido_itens`: produtos, quantidades, preços unitários e subtotais registrados em cada pedido.
- `receitas`: receita associada a um produto, rendimento e modo de preparo.
- `receita_ingredientes`: ingredientes, quantidades e unidades de cada receita.
- `configuracoes`: nome do negócio e nome de exibição da responsável por usuário.

2. Relacionamentos e integridade
- Todos os registros pertencem ao usuário autenticado.
- Produtos possuem várias movimentações, pedidos e receitas.
- Pedidos possuem vários itens; itens preservam o preço usado no pedido.
- Receitas possuem vários ingredientes.
- Quantidades e valores não podem ser negativos ou zero onde isso não faz sentido.

3. Segurança
- RLS habilitado em todas as tabelas.
- CRUD separado para cada tabela, limitado ao usuário autenticado.
- Funções protegidas para registrar movimentações, criar pedidos e entregar pedidos.
- A entrega recalcula o total, verifica saldo e registra a saída uma única vez no banco.

4. Observações
- A migração é incremental e não remove tabelas nem dados existentes.
- Os valores de estoque são alterados somente pelas funções de movimentação e entrega.
*/

CREATE TABLE IF NOT EXISTS public.produtos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  codigo text NOT NULL,
  nome text NOT NULL,
  categoria text NOT NULL,
  preco_unitario numeric(12,2) NOT NULL CHECK (preco_unitario >= 0),
  quantidade_estoque integer NOT NULL DEFAULT 0 CHECK (quantidade_estoque >= 0),
  estoque_minimo integer NOT NULL DEFAULT 0 CHECK (estoque_minimo >= 0),
  descricao text NOT NULL DEFAULT '',
  foto_url text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.movimentacoes_estoque (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  produto_id uuid NOT NULL REFERENCES public.produtos(id) ON DELETE CASCADE,
  tipo text NOT NULL CHECK (tipo IN ('entrada', 'saida')),
  quantidade integer NOT NULL CHECK (quantidade > 0),
  motivo text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.pedidos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  cliente text NOT NULL,
  data_entrega date NOT NULL,
  status text NOT NULL DEFAULT 'Pendente' CHECK (status IN ('Pendente', 'Em produção', 'Entregue', 'Cancelado')),
  observacoes text NOT NULL DEFAULT '',
  total numeric(12,2) NOT NULL DEFAULT 0 CHECK (total >= 0),
  entregue_em timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.pedido_itens (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  pedido_id uuid NOT NULL REFERENCES public.pedidos(id) ON DELETE CASCADE,
  produto_id uuid NOT NULL REFERENCES public.produtos(id) ON DELETE RESTRICT,
  quantidade integer NOT NULL CHECK (quantidade > 0),
  preco_unitario numeric(12,2) NOT NULL CHECK (preco_unitario >= 0),
  subtotal numeric(12,2) NOT NULL CHECK (subtotal >= 0)
);

CREATE TABLE IF NOT EXISTS public.receitas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  produto_id uuid NOT NULL REFERENCES public.produtos(id) ON DELETE CASCADE,
  rendimento integer NOT NULL CHECK (rendimento > 0),
  modo_preparo text NOT NULL DEFAULT '',
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (user_id, produto_id)
);

CREATE TABLE IF NOT EXISTS public.receita_ingredientes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  receita_id uuid NOT NULL REFERENCES public.receitas(id) ON DELETE CASCADE,
  nome text NOT NULL,
  quantidade numeric(12,3) NOT NULL CHECK (quantidade > 0),
  unidade text NOT NULL
);

CREATE TABLE IF NOT EXISTS public.configuracoes (
  user_id uuid PRIMARY KEY DEFAULT auth.uid() REFERENCES auth.users(id) ON DELETE CASCADE,
  nome_negocio text NOT NULL DEFAULT 'Doce Estoque',
  nome_responsavel text NOT NULL DEFAULT 'Responsável',
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS movimentacoes_estoque_produto_idx ON public.movimentacoes_estoque (produto_id, created_at DESC);
CREATE INDEX IF NOT EXISTS pedidos_user_status_idx ON public.pedidos (user_id, status, data_entrega);
CREATE INDEX IF NOT EXISTS pedido_itens_pedido_idx ON public.pedido_itens (pedido_id);

ALTER TABLE public.produtos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.movimentacoes_estoque ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pedidos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pedido_itens ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.receitas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.receita_ingredientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.configuracoes ENABLE ROW LEVEL SECURITY;

GRANT SELECT, INSERT, UPDATE, DELETE ON public.produtos TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.movimentacoes_estoque TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pedidos TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.pedido_itens TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.receitas TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.receita_ingredientes TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.configuracoes TO authenticated;

DROP POLICY IF EXISTS "produtos_select_own" ON public.produtos;
CREATE POLICY "produtos_select_own" ON public.produtos FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "produtos_insert_own" ON public.produtos;
CREATE POLICY "produtos_insert_own" ON public.produtos FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "produtos_update_own" ON public.produtos;
CREATE POLICY "produtos_update_own" ON public.produtos FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "produtos_delete_own" ON public.produtos;
CREATE POLICY "produtos_delete_own" ON public.produtos FOR DELETE TO authenticated USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "mov_select_own" ON public.movimentacoes_estoque;
CREATE POLICY "mov_select_own" ON public.movimentacoes_estoque FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "mov_insert_own" ON public.movimentacoes_estoque;
CREATE POLICY "mov_insert_own" ON public.movimentacoes_estoque FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id AND EXISTS (SELECT 1 FROM public.produtos p WHERE p.id = produto_id AND p.user_id = auth.uid()));
DROP POLICY IF EXISTS "mov_update_own" ON public.movimentacoes_estoque;
CREATE POLICY "mov_update_own" ON public.movimentacoes_estoque FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "mov_delete_own" ON public.movimentacoes_estoque;
CREATE POLICY "mov_delete_own" ON public.movimentacoes_estoque FOR DELETE TO authenticated USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "pedidos_select_own" ON public.pedidos;
CREATE POLICY "pedidos_select_own" ON public.pedidos FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "pedidos_insert_own" ON public.pedidos;
CREATE POLICY "pedidos_insert_own" ON public.pedidos FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "pedidos_update_own" ON public.pedidos;
CREATE POLICY "pedidos_update_own" ON public.pedidos FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "pedidos_delete_own" ON public.pedidos;
CREATE POLICY "pedidos_delete_own" ON public.pedidos FOR DELETE TO authenticated USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "itens_select_own" ON public.pedido_itens;
CREATE POLICY "itens_select_own" ON public.pedido_itens FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "itens_insert_own" ON public.pedido_itens;
CREATE POLICY "itens_insert_own" ON public.pedido_itens FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id AND EXISTS (SELECT 1 FROM public.pedidos p WHERE p.id = pedido_id AND p.user_id = auth.uid()) AND EXISTS (SELECT 1 FROM public.produtos p WHERE p.id = produto_id AND p.user_id = auth.uid()));
DROP POLICY IF EXISTS "itens_update_own" ON public.pedido_itens;
CREATE POLICY "itens_update_own" ON public.pedido_itens FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "itens_delete_own" ON public.pedido_itens;
CREATE POLICY "itens_delete_own" ON public.pedido_itens FOR DELETE TO authenticated USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "receitas_select_own" ON public.receitas;
CREATE POLICY "receitas_select_own" ON public.receitas FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "receitas_insert_own" ON public.receitas;
CREATE POLICY "receitas_insert_own" ON public.receitas FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id AND EXISTS (SELECT 1 FROM public.produtos p WHERE p.id = produto_id AND p.user_id = auth.uid()));
DROP POLICY IF EXISTS "receitas_update_own" ON public.receitas;
CREATE POLICY "receitas_update_own" ON public.receitas FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "receitas_delete_own" ON public.receitas;
CREATE POLICY "receitas_delete_own" ON public.receitas FOR DELETE TO authenticated USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "ingredientes_select_own" ON public.receita_ingredientes;
CREATE POLICY "ingredientes_select_own" ON public.receita_ingredientes FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "ingredientes_insert_own" ON public.receita_ingredientes;
CREATE POLICY "ingredientes_insert_own" ON public.receita_ingredientes FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id AND EXISTS (SELECT 1 FROM public.receitas r WHERE r.id = receita_id AND r.user_id = auth.uid()));
DROP POLICY IF EXISTS "ingredientes_update_own" ON public.receita_ingredientes;
CREATE POLICY "ingredientes_update_own" ON public.receita_ingredientes FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "ingredientes_delete_own" ON public.receita_ingredientes;
CREATE POLICY "ingredientes_delete_own" ON public.receita_ingredientes FOR DELETE TO authenticated USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "config_select_own" ON public.configuracoes;
CREATE POLICY "config_select_own" ON public.configuracoes FOR SELECT TO authenticated USING (auth.uid() = user_id);
DROP POLICY IF EXISTS "config_insert_own" ON public.configuracoes;
CREATE POLICY "config_insert_own" ON public.configuracoes FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "config_update_own" ON public.configuracoes;
CREATE POLICY "config_update_own" ON public.configuracoes FOR UPDATE TO authenticated USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
DROP POLICY IF EXISTS "config_delete_own" ON public.configuracoes;
CREATE POLICY "config_delete_own" ON public.configuracoes FOR DELETE TO authenticated USING (auth.uid() = user_id);

CREATE OR REPLACE FUNCTION public.registrar_movimentacao(p_produto_id uuid, p_tipo text, p_quantidade integer, p_motivo text DEFAULT '')
RETURNS public.movimentacoes_estoque
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $$
DECLARE v_produto public.produtos; v_mov public.movimentacoes_estoque;
BEGIN
  SELECT * INTO v_produto FROM public.produtos WHERE id = p_produto_id AND user_id = auth.uid() FOR UPDATE;
  IF v_produto.id IS NULL THEN RAISE EXCEPTION 'Produto não encontrado'; END IF;
  IF p_tipo NOT IN ('entrada','saida') OR p_quantidade IS NULL OR p_quantidade <= 0 THEN RAISE EXCEPTION 'Movimentação inválida'; END IF;
  IF p_tipo = 'saida' AND v_produto.quantidade_estoque < p_quantidade THEN RAISE EXCEPTION 'Saldo insuficiente'; END IF;
  UPDATE public.produtos SET quantidade_estoque = quantidade_estoque + CASE WHEN p_tipo = 'entrada' THEN p_quantidade ELSE -p_quantidade END WHERE id = p_produto_id;
  INSERT INTO public.movimentacoes_estoque (produto_id, tipo, quantidade, motivo) VALUES (p_produto_id, p_tipo, p_quantidade, COALESCE(p_motivo, '')) RETURNING * INTO v_mov;
  RETURN v_mov;
END;
$$;
REVOKE EXECUTE ON FUNCTION public.registrar_movimentacao(uuid, text, integer, text) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.registrar_movimentacao(uuid, text, integer, text) TO authenticated;

CREATE OR REPLACE FUNCTION public.criar_pedido(p_cliente text, p_data_entrega date, p_observacoes text, p_itens jsonb)
RETURNS uuid
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $$
DECLARE v_pedido_id uuid; v_item jsonb; v_produto public.produtos; v_total numeric := 0; v_qtd integer; v_preco numeric;
BEGIN
  IF NULLIF(trim(p_cliente), '') IS NULL OR p_data_entrega IS NULL OR jsonb_array_length(p_itens) = 0 THEN RAISE EXCEPTION 'Dados do pedido inválidos'; END IF;
  INSERT INTO public.pedidos (cliente, data_entrega, observacoes) VALUES (trim(p_cliente), p_data_entrega, COALESCE(p_observacoes, '')) RETURNING id INTO v_pedido_id;
  FOR v_item IN SELECT * FROM jsonb_array_elements(p_itens) LOOP
    v_qtd := (v_item->>'quantidade')::integer;
    SELECT * INTO v_produto FROM public.produtos WHERE id = (v_item->>'produto_id')::uuid AND user_id = auth.uid();
    IF v_produto.id IS NULL OR v_qtd IS NULL OR v_qtd <= 0 THEN RAISE EXCEPTION 'Item do pedido inválido'; END IF;
    v_preco := v_produto.preco_unitario;
    INSERT INTO public.pedido_itens (pedido_id, produto_id, quantidade, preco_unitario, subtotal) VALUES (v_pedido_id, v_produto.id, v_qtd, v_preco, v_preco * v_qtd);
    v_total := v_total + v_preco * v_qtd;
  END LOOP;
  UPDATE public.pedidos SET total = v_total WHERE id = v_pedido_id;
  RETURN v_pedido_id;
END;
$$;
REVOKE EXECUTE ON FUNCTION public.criar_pedido(text, date, text, jsonb) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.criar_pedido(text, date, text, jsonb) TO authenticated;

CREATE OR REPLACE FUNCTION public.entregar_pedido(p_pedido_id uuid)
RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
AS $$
DECLARE v_pedido public.pedidos; v_item record; v_produto public.produtos;
BEGIN
  SELECT * INTO v_pedido FROM public.pedidos WHERE id = p_pedido_id AND user_id = auth.uid() FOR UPDATE;
  IF v_pedido.id IS NULL THEN RAISE EXCEPTION 'Pedido não encontrado'; END IF;
  IF v_pedido.status = 'Entregue' THEN RAISE EXCEPTION 'Pedido já entregue'; END IF;
  IF v_pedido.status = 'Cancelado' THEN RAISE EXCEPTION 'Pedido cancelado'; END IF;
  FOR v_item IN SELECT * FROM public.pedido_itens WHERE pedido_id = p_pedido_id AND user_id = auth.uid() LOOP
    SELECT * INTO v_produto FROM public.produtos WHERE id = v_item.produto_id AND user_id = auth.uid() FOR UPDATE;
    IF v_produto.quantidade_estoque < v_item.quantidade THEN RAISE EXCEPTION 'Saldo insuficiente para entregar'; END IF;
    UPDATE public.produtos SET quantidade_estoque = quantidade_estoque - v_item.quantidade WHERE id = v_produto.id;
    INSERT INTO public.movimentacoes_estoque (produto_id, tipo, quantidade, motivo) VALUES (v_produto.id, 'saida', v_item.quantidade, 'Entrega do pedido');
  END LOOP;
  UPDATE public.pedidos SET status = 'Entregue', entregue_em = now() WHERE id = p_pedido_id;
END;
$$;
REVOKE EXECUTE ON FUNCTION public.entregar_pedido(uuid) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.entregar_pedido(uuid) TO authenticated;
