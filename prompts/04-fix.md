Faça uma atualização corretiva no projeto existente Doce Estoque. Use os três prints anexados como referência e preserve a identidade visual e a estrutura das telas.

1. Centralizar os ícones nos controles

Revise o alinhamento dos ícones em botões, campos de busca, filtros e ações das tabelas. Comece pelo botão da lupa mostrado no print, onde o ícone está deslocado para o canto superior esquerdo.

Nos botões que contêm apenas um ícone, centralize-o na horizontal e na vertical dentro da área clicável. Em botões com texto, alinhe o ícone ao texto e mantenha um espaçamento consistente. Em campos com ícone à esquerda, centralize-o verticalmente e preserve o recuo do texto. Corrija primeiro os componentes reutilizáveis que causam o problema em várias telas.

2. Ajustar as telas de login e cadastro

Adicione um espaço visível entre o último campo do formulário e o botão principal, tanto em “Entrar no Doce Estoque” quanto em “Cadastrar”. Use o padrão de espaçamento do projeto, como 16 px, e confira se o espaço aparece nas duas telas.

Nos controles que alternam entre login e cadastro, aplique cursor pointer, um hover visível e um indicador de foco por teclado com focus-visible. Teste com o mouse e com Tab. Preserve o funcionamento dos formulários e da autenticação.

3. Dar espaço entre “Voltar” e o conteúdo

Na tela “Novo Produto”, mostrada no print, o controle “Voltar” está grudado no título. Corrija o espaçamento vertical entre esse controle e o bloco de título ou painel. Revise as demais telas que usam o mesmo cabeçalho. Se o problema estiver no layout compartilhado, aplique o espaçamento no contêiner que organiza os elementos, usando gap ou margin conforme a estrutura existente.

4. Atualizar a tabela de pedidos após criar um pedido

Investigue o fluxo de criação e a consulta que alimenta a tabela. Depois que o Supabase confirmar o salvamento, atualize a lista usando o mecanismo que o projeto já usa para buscar os dados ou invalidar o cache. O pedido deve aparecer sem recarregar a página, desde que corresponda aos filtros ativos.

Respeite os filtros e a paginação existentes. Se um filtro ocultar o novo pedido, mantenha a confirmação de salvamento e indique que ele está fora da visualização atual. Em caso de falha no salvamento, mostre o erro e preserve os dados preenchidos. Evite linhas duplicadas.

Antes de finalizar, verifique estes cenários:

- A lupa e os demais ícones revisados ficam alinhados no desktop e no celular.

- Os botões principais de login e cadastro têm espaço acima, e o controle de alternância responde ao hover e ao foco por teclado.

- “Voltar” fica visualmente separado do título em “Novo Produto” e nas telas com o mesmo layout.

- Um pedido criado com sucesso aparece na tabela sem F5 quando corresponde aos filtros, e continua disponível após recarregar a página.

Ao terminar, informe quais arquivos foram alterados, qual era a causa da tabela desatualizada e quais cenários você conseguiu testar.
