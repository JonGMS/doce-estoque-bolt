CONTEXTO

Implemente o MVP web “Doce Estoque”, um gerenciador de produtos, estoque, receitas e pedidos para uma vendedora autônoma de brigadeiros. Este projeto dá continuidade a um protótipo já criado em uma atividade do SENAI.

Use as quatro imagens do Doce Estoque como referência de layout: Dashboard, Produtos, Novo Produto e Estoque. Use o print “Configure o back-end do seu MVP” como checklist da atividade. Preserve a identidade visual dos protótipos: menu lateral, cabeçalho, fundo claro, tons de marrom e rosa, tabelas, cards e indicadores de estoque. Use português do Brasil, moeda em reais (BRL) e datas no padrão brasileiro.

TAREFA

Implemente o projeto no Bolt, integre um projeto real do Supabase, valide o CRUD pelo frontend, faça commit e push para o GitHub e publique o app em um endereço público fornecido pelo próprio Bolt. Execute as ações disponíveis na plataforma e informe qualquer etapa que dependa de autenticação ou autorização minha.

REQUISITOS

1. Modele os dados antes de implementar. Documente no README as tabelas, atributos e relacionamentos. Priorize duas tabelas funcionais nesta entrega:
   - produtos: ID, proprietário, código, nome, categoria, preço unitário, quantidade em estoque, estoque mínimo, descrição, foto opcional e data de criação.
   - movimentacoes_estoque: ID, proprietário, produto relacionado, tipo de movimentação (entrada ou saída), quantidade, observação e data.
   - Um produto pode ter várias movimentações. Descreva no README como receitas e pedidos poderão se relacionar com produtos em uma próxima etapa. Se aparecerem na interface nesta entrega, sinalize claramente que esses módulos fazem parte do protótipo.

2. Gere um arquivo `schema.sql` documentado e execute-o no SQL Editor do Supabase, usando a integração ou o acesso disponível. Use chaves primárias e estrangeiras, tipos adequados para dinheiro e restrições para impedir preço negativo, estoque negativo e movimentação com quantidade zero. Habilite RLS nas duas tabelas. Crie policies explícitas para SELECT, INSERT, UPDATE e DELETE, restritas aos dados do usuário autenticado. Impeça que uma movimentação referencie um produto de outro usuário. Configure login por e-mail e senha para permitir testar o acesso protegido.

3. Instale `@supabase/supabase-js`, configure o cliente em `lib/supabase.ts` e use as variáveis de ambiente do projeto para a URL e a chave pública do Supabase. Inclua um `.env.example` com os nomes das variáveis e mantenha o `.env` fora do Git. Nunca use a chave `service_role` no frontend. Cadastros, listagens, edições e exclusões devem usar o banco real.

4. Implemente as quatro telas com base nas imagens:
   - Dashboard: calcule o total de produtos, as unidades em estoque e os alertas usando dados reais. Se mostrar pedidos, faturamento ou gráfico de vendas sem dados, sinalize que são demonstrativos.
   - Produtos: liste os registros do Supabase com busca, filtro por categoria e ações para editar e excluir. Peça confirmação antes de excluir.
   - Novo Produto: implemente o formulário da imagem e reutilize-o para edição. Valide os campos obrigatórios e mostre o resultado do salvamento.
   - Estoque: mostre o saldo, o estoque mínimo, o status e o histórico. Registre a movimentação e a alteração do saldo na mesma transação. Impeça saídas acima do saldo disponível.

5. Teste o CRUD usando a interface publicada ou o preview conectado ao Supabase:
   - Cadastre Brigadeiro Tradicional, Beijinho de Coco e Brigadeiro de Pistache.
   - Confirme que os três aparecem na listagem e continuam salvos após recarregar.
   - Edite o preço de um produto e confirme a alteração.
   - Exclua um dos produtos e confirme que ele saiu da listagem. Cadastre-o novamente ao final, para deixar três produtos no banco para a entrega.
   - Confirme o estado final no Table Editor do Supabase, se tiver acesso, e registre no README quais verificações foram executadas e quais ficaram pendentes.

6. Conecte o projeto ao GitHub. Use o repositório indicado por mim, se houver. Se não houver e a integração permitir, crie um repositório chamado `doce-estoque`. Faça commit das alterações e push para a branch principal. Use a mensagem de commit `feat: implementa MVP Doce Estoque com Supabase`. Confirme o hash do commit remoto.

7. Publique o app usando a hospedagem do Bolt e o subdomínio padrão oferecido pela plataforma. Se for possível escolher o nome e ele estiver disponível, use `doce-estoque`. Configure também as variáveis de ambiente da publicação e confirme que a URL abre e conecta ao Supabase.

FORMATO DA ENTREGA

Ao final, informe:
- Link do repositório GitHub e hash do commit enviado.
- URL pública do app publicado pelo Bolt.
- URL do projeto Supabase.
- Caminhos do `schema.sql`, `lib/supabase.ts` e `.env.example`.
- Resultado de cada teste do CRUD e confirmação dos três produtos no banco.
- Qualquer etapa pendente, com a ação exata que preciso realizar no Bolt, GitHub ou Supabase.

Informe somente links e resultados que você conseguiu verificar.
