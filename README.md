# Forge Project — receitas do Hub

- `forge-main.yaml`: configura a base e inclui o SQL padrão e os CFGs. Os arquivos em `files/` são as fontes legíveis desses conteúdos.
- `scripts.yaml`: os 56 recursos da instalação padrão, nas respectivas categorias de `resources/`. O Hub escolhe o ZIP da última release estável; `verifiedVersion` apenas registra a versão conferida, sem fixar o download.
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

O Forge Project 1.1.0 recusa catálogos e pacotes com os recursos retirados. A ordem principal é CFX → oxmysql → pr_bridge → forge-core. Os aliases históricos fornecidos pelo PR Bridge e os nomes de tabelas SQL continuam preservados.

Guia vigente: docs/recipe-installer.md. Não use executáveis antigos identificados como Forgebox; a distribuição atual é Forge Project 1.1.0.
