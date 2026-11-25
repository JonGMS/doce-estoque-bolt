Continue o projeto Doce Estoque a partir do estado atual. Use as imagens anexadas de Dashboard, Produtos, Novo Produto e Estoque como referência visual. Mantenha a ordem e os nomes do menu lateral: Dashboard, Produtos, Estoque, Pedidos, Relatórios e Configurações. Use o mesmo cabeçalho, estilo de formulário, tabelas, cards e paleta marrom e rosa nas novas telas. Destaque no menu a seção ativa.

1. COMPLETE A NAVEGAÇÃO DAS TELAS JÁ DESENHADAS

- Dashboard → “Ver Estoque” abre Estoque. O botão “Produzir” abre o formulário de entrada de estoque com o produto selecionado. Confirme a quantidade antes de registrar a entrada.
- Produtos → “Novo Produto” abre o formulário vazio. “Editar” abre o mesmo formulário preenchido. “Salvar” volta para Produtos com mensagem de sucesso. “Voltar” e “Cancelar” retornam à lista e pedem confirmação se houver alterações pendentes. “Excluir” pede confirmação com o nome do produto.
- Estoque → “Nova movimentação” abre um formulário para selecionar produto, tipo, quantidade e motivo. Os botões + e − abrem esse mesmo formulário com o produto e o tipo já preenchidos. Após confirmar, atualize saldo, histórico e indicadores. “Exportar” baixa em CSV os dados da lista conforme os filtros aplicados.
- Permita voltar ao Dashboard pelo menu de qualquer tela. Garanta que as páginas também abram por URL direta e continuem funcionando após recarregar.

2. CRIE AS TELAS RESTANTES DO MENU

- Pedidos → crie uma listagem com busca, filtro por status e botão “Novo Pedido”. No formulário, permita informar cliente, data de entrega, produtos, quantidades e observações. Calcule o total com os preços unitários e preserve o preço registrado em cada pedido. Permita consultar, editar e acompanhar os status Pendente, Em produção, Entregue e Cancelado. Ao entregar, registre a saída de estoque uma única vez e impeça a operação se faltar saldo.
- Relatórios → crie um filtro por período e mostre unidades vendidas, faturamento de pedidos entregues e movimentações de estoque. Calcule os indicadores com os dados do Supabase e permita exportar o período filtrado em CSV.
- Configurações → permita salvar o nome do negócio e o nome de exibição da responsável. Use os dados salvos no cabeçalho e na saudação do Dashboard. Inclua a opção de sair da conta.
- Receitas → adicione o atalho “Receitas” dentro de Produtos e preserve a estrutura do menu lateral. Crie uma lista e um formulário para cadastrar e editar receitas com produto associado, ingredientes, quantidades, unidades, rendimento e modo de preparo. Mostre o acesso à receita na edição do produto quando houver uma vinculada.

3. INTEGRE E VERIFIQUE A ENTREGA

- Preserve as tabelas `produtos` e `movimentacoes_estoque`, o CRUD exigido na atividade e o cliente em `lib/supabase.ts`. Acrescente ao `schema.sql` as tabelas necessárias para os novos fluxos, documente os relacionamentos e aplique as alterações de forma incremental, preservando os dados existentes.
- Habilite RLS e configure policies nas tabelas novas para que cada usuário autenticado acesse somente seus próprios registros. Use os dados do Supabase como fonte comum para Produtos, Estoque, Pedidos, Relatórios e Dashboard.
- Teste no navegador o fluxo completo: cadastrar produto → criar receita → registrar entrada de estoque → criar pedido → marcar como entregue → conferir a baixa no Estoque e os números em Relatórios. Verifique também edição e exclusão de um produto de teste pelo frontend. Deixe três produtos cadastrados ao final e confirme-os no Table Editor se tiver acesso.
- Reutilize as integrações já configuradas. Ao terminar, faça commit e push para o GitHub, publique ou atualize a publicação no subdomínio do próprio Bolt e verifique se a URL abre. Entregue a URL pública, o link do repositório, o hash do commit e a URL do projeto Supabase. Se algum passo depender de uma ação minha, diga exatamente qual e continue com as demais etapas.
