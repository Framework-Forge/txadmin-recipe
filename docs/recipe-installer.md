# Instalação por receita — Forge Project

A distribuição padrão usa o núcleo autoritativo **Forge Core**, a integração **PR Bridge** e os recursos de [Framework-Forge/txadmin-recipe](https://github.com/Framework-Forge/txadmin-recipe). O catálogo atual contém 56 recursos. QBX Core e ox_lib não são recursos separados da instalação; seus nomes de compatibilidade podem continuar sendo fornecidos pelo PR Bridge.

## Arquivos e origem

- forge-main.yaml: SQL, configurações e obtenção dos recursos oficiais CFX.
- scripts.yaml: catálogo da instalação padrão, com repositório e diretório de cada recurso.
- story.yaml: catálogo separado da loja; permanece vazio por decisão do proprietário.
- files/: SQL e modelos legíveis dos CFGs incluídos na receita.
- No Hub, scripts/build-forge-recipes.mjs gera recipes/ e seu espelho public/recipes/. forge-main-example.yaml acompanha a receita atual e não contém uma segunda arquitetura antiga.

O assistente lê a receita e o catálogo oficiais no GitHub a cada carregamento, com renovação da consulta. As cópias locais são usadas para manutenção, geração e testes; não substituem silenciosamente uma consulta online que falhou.

Catálogos antigos com qbx_core ou ox_lib como itens separados são recusados antes de aparecerem na vitrine. O backend repete a proteção e recusa também pacotes que tentem introduzir esses recursos fisicamente. Isso não bloqueia aliases e importações legítimas fornecidos pelo PR Bridge.

## Fluxo

1. Obtém e valida os YAMLs oficiais. Confere nomes, identificadores, repositórios e seleção dos recursos obrigatórios.
2. Confere caminhos, variáveis, licença preenchida e autenticação no banco informado. Uma porta aberta não equivale a um login válido.
3. Resolve as últimas releases estáveis e seus ZIPs publicados. O nome do arquivo pode conter a versão; não existe exigência padrão de um nome fixo slug.zip.
4. Cria uma área temporária própria e baixa o artefato oficial Windows do FXServer.
5. Prepara os arquivos da receita e os pacotes selecionados. Confere manifestos, scripts e interfaces compiladas obrigatórios. Dados gerados pelo próprio recurso no primeiro início e padrões de mídia opcionais recebem tratamento específico.
6. Resolve dependências e importações por nome ou alias, usando o catálogo e os provedores presentes. Dependência sem pacote válido interrompe a instalação.
7. Ordena recursos padrão CFX, oxmysql, pr_bridge e forge-core, respeitando o grafo de dependências dos demais recursos.
8. Confere os CFGs efetivos, incluindo licença e conexão de banco. Administradores vêm do assistente; os modelos não distribuem identificadores de desenvolvimento.
9. Antes do SQL, revalida o acesso ao banco. Banco existente exige backup completo; banco novo só é criado quando essa opção está habilitada. O SQL é executado somente depois da validação dos arquivos.
10. Publica a pasta final e registra origem, versão e SHA-256 dos pacotes em forge-installation.json, sem gravar credenciais nesse relatório.
11. Quando solicitado pelo assistente, inicia o FXServer com +exec server.cfg. A verificação atual confirma que o processo permanece aberto após dois segundos; não comprova a saúde de todos os scripts nem a entrada em jogo. O primeiro boot deve ser conferido pelo console e pela conexão do usuário.

O destino precisa ser uma pasta nova ou vazia. Os recursos ficam em resources/ e o runtime em FXserver/. Não há cópia dos scripts da base de desenvolvimento, pasta vazia substituindo recurso ausente ou compilação de frontend no computador do cliente.

## Downloads

Os scripts Forge e terceiros vêm exclusivamente de ZIPs anexados à última release estável. A API de releases seleciona um único ZIP ou o nome explícito definido em asset. Rascunhos, pré-releases, ausência de pacote e seleção ambígua são recusados. Os links automáticos Source code não são usados.

download_github é um nome compatível de download_github_release. Para os scripts comuns, ref não autoriza clone ou download de branch: a origem continua sendo a release estável. download_file aceita somente URLs GitHub releases/latest/download de pacotes ZIP.

A única exceção é citizenfx/cfx-server-data: esse repositório oficial não publica releases. A receita fixa um commit Git completo e aproveita somente mapmanager, spawnmanager e baseevents. Não são obtidos scripts Forge por esse caminho e não se compila Node/npm no cliente.

oxmysql também vem da fonte oficial. A versão oficial conferida 2.14.3 requer FXServer a partir de 12913 e seleciona o runtime Node.js 22 do próprio servidor. Isso não exige instalar Node.js separado nem substituir MariaDB por outro banco.

Cada pacote recebe SHA-256. O digest do publicador é comparado quando informado pela API. O commit dos recursos CFX e o hash do ZIP recebido ficam registrados. A extração recusa caminhos absolutos, travessias de diretório, links, duplicatas e arquivos acima dos limites. Os limites atuais são 512 MiB de download, 2 GiB expandidos e 50 mil entradas por ZIP.

## Compatibilidade e arquivos gerados

As referências de compatibilidade do PR Bridge são preservadas. Uma importação como @ox_lib/init.lua é resolvida pelo provedor, sem instalar outra biblioteca. Compatibilidade não equivale a um item obrigatório no catálogo.

Os três dados declarados pelo proprietário como gerados no primeiro uso são data/academy.json de forge-gym, data/debts.json de forge-rental e safezones/zones.json de forge-smallresources. A dispensa é específica desses caminhos. Arquivos de código, HTML e outros dados obrigatórios continuam sendo exigidos.

Padrões opcionais de imagem, áudio e modelos podem não encontrar arquivos de determinada extensão. Isso não deve ser interpretado automaticamente como recurso ausente. Scripts e interfaces compiladas realmente necessários permanecem protegidos pela validação.

Convars e nomes históricos usados pelos contratos dos recursos, tabelas SQL e preferências do aplicativo não são renomeados por essa revisão. As chaves internas antigas preservam login, idioma e caminhos; a interface e o executável usam Forge Project.

## Banco

O SQL padrão é resources/Docs/database.sql, preservado na geração: 140 tabelas, SHA-256 2c6820c560875a229bcd015c442119195e067b1088648a75eb587a42e1deaaf1.

O executor usa autenticação real e o cliente SQL instalado. Credenciais são recebidas pelo ambiente do processo filho. Variáveis CFG com quebras de linha, controles ou caracteres que alterem comandos são recusadas; a conexão usa componentes codificados.

SQL confiável pode conter operações além do banco selecionado, conforme as permissões da conta. Backup não representa rollback automático de DDL. Uma falha posterior exige conferir o banco e o backup antes de repetir. Não há exclusão automática de banco como recuperação.

O progresso continua disponível ao navegar pelo Hub. Uma instalação simultânea é recusada. O cancelamento é permitido antes da aplicação do SQL; durante a fase final, aguarde a conclusão.

## Tarefas

| Ação | Uso |
|---|---|
| download_github_release / download_github | ZIP da release estável; CFX oficial aceita somente o commit completo da exceção descrita. |
| download_file | ZIP publicado em release estável. |
| unzip | Extração de pacote baixado. |
| copy_path / move_path | Arquivos dentro da área temporária da instalação. |
| remove_path / ensure_dir | Operações restritas à área temporária, sem atingir sua raiz. |
| write_file | SQL e configurações com variáveis validadas. |
| connect_database | Preparação da conexão de banco. |
| query_database | Exige conexão anterior e exatamente um file ou query; execução após conferir os arquivos. |

Ações e propriedades não suportadas são recusadas. O executor implementa o subconjunto usado pelo Hub; a receita com catálogo separado não foi certificada para uso isolado em outros executores txAdmin.

## Verificação e distribuição

npm run check, npm run build, npm run test:recipe-ui e os testes Rust verificam catálogo obsoleto, aliases, dependências, integridade, interfaces ausentes, SQL simulado e preservação de arquivos. O teste adicional dos pacotes publicados monta 56 recursos mais três CFX em uma pasta temporária, sem iniciar o servidor nem acessar o banco real.

Use o executável Forge Project 1.1.0 ou posterior. A revisão corrige a distribuição dos executáveis que ainda apresentavam a interface antiga com 60 itens. O catálogo oficial deve mostrar os 56 recursos da lista padrão, sem cards separados de QBX Core ou ox_lib.

O primeiro boot, a importação no banco do usuário, a entrada no jogo e os efeitos da otimização de sincronização dependem do teste real do proprietário. Testes de arquivos ou bancos simulados não certificam esses resultados.
