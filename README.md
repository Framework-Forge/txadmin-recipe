# Forge Project — receitas do Hub

- `forge-main.yaml`: configura a base e inclui o SQL padrão e os CFGs. Os arquivos em `files/` são as fontes legíveis desses conteúdos.
- `scripts.yaml`: catálogo de 56 recursos. A Completa instala todos. A Custom mantém os obrigatórios e instala os opcionais selecionados e suas dependências. O Hub 1.1.2 fixa tag e SHA-256 dos recursos acoplados ao boot. O oxmysql oficial e os demais recursos usam a última release estável.
- `story.yaml`: catálogo separado da loja. Está vazio por solicitação do proprietário; seus itens não entram automaticamente na instalação padrão.
- `forge-main-example.yaml` no Hub acompanha o conteúdo da receita atual; não deve manter dependências antigas.
- `releases.lock.json`: registro das publicações conferidas, para revisão e geração dos catálogos.

Não instalar `qbx_core` ou `ox_lib` separados. As compatibilidades são fornecidas pelo PR Bridge. Os scripts de desenvolvimento da pasta `[Scripts-para-remover]` não fazem parte da receita.

O `oxmysql` vem da release oficial. Os três recursos padrão CFX vêm de `citizenfx/cfx-server-data`, com commit completo registrado; são a única exceção controlada à exigência de pacotes de release. Não é feito clone de scripts Forge nem compilação no computador do cliente.

O SQL incluído é o arquivo `resources/Docs/database.sql`, SHA-256 `2c6820c560875a229bcd015c442119195e067b1088648a75eb587a42e1deaaf1`, sem alteração de conteúdo. Identificadores administrativos de desenvolvimento foram retirados dos modelos; o assistente fornece os dados do proprietário.

Para gerar e conferir as cópias, execute a partir do código do Hub (Forge-Installer), não do clone isolado de receitas:

    node scripts/build-forge-recipes.mjs
    node scripts/validate-forge-recipes.mjs

O Hub lê `forge-main.yaml` e `scripts.yaml` do repositório oficial no GitHub. Atualizar o clone local não publica esses arquivos: revisar e publicar as alterações em `Framework-Forge/txadmin-recipe` antes do teste de download pelo aplicativo. As cópias em `public/recipes/` acompanham a distribuição e a documentação; não são um desvio silencioso para arquivos locais quando o GitHub falha.

Esta receita é consumida pelo executor do Hub com o catálogo `scripts.yaml`; seu uso isolado em outro executor txAdmin não foi certificado.

O Forge Project 1.1.2 preserva a ordem da receita quando as dependências permitem. O perfil `forge:kernel` é replicado antes do boot. A ordem principal é CFX → oxmysql → PR Bridge → Forge Core → ox_inventory. Renewed-Banking e pr_carkeys são obrigatórios para concluir a ativação. Quando o Housing é selecionado, o Hub instala o serviço de portas como dependência e o inicia antes do Housing e do Realtor. Os aliases do PR Bridge e as tabelas SQL continuam preservados.

Guia vigente: docs/recipe-installer.md. Não use executáveis antigos identificados como Forgebox; a distribuição atual é Forge Project 1.1.2.
