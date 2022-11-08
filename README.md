# Boas vindas ao repositório do projeto One For All! 🚀
<strong>:whale: Rodando no Docker vs Localmente</strong><br />

  ## Com Docker

  > Rode os serviços `node` e `db` com o comando `docker-compose up -d`.
  - Lembre-se de parar o `mysql` se estiver usando localmente na porta padrão (`3306`), ou adapte, caso queria fazer uso da aplicação em containers. A recomendação é pela performance do seu computador, pois o `docker-compose.yml` está configurado para mapear a porta padao do `mysql` do container para a porta `3307` e não `3306`. 
  - Esses serviços irão inicializar um container chamado `one_for_all` e outro chamado `one_for_all_db`.
  - A partir daqui você pode rodar o container `one_for_all` via CLI ou abri-lo no VS Code.

  > Use o comando `docker exec -it one_for_all bash`.
  - Ele te dará acesso ao terminal interativo do container criado pelo compose, que está rodando em segundo plano;
  - As credencias de acesso ao banco de dados estão definidas no arquivo `docker-compose.yml`, e são acessíveis no container através das variáveis de ambiente `MYSQL_USER` e `MYSQL_PASSWORD`. 💡

  > Instale as dependências [**Caso existam**] com `npm install`

  ⚠ Atenção ⚠ Caso opte por utilizar o Docker, **TODOS** os comandos disponíveis no `package.json` (npm start, npm test, npm run dev, ...) devem ser executados **DENTRO** do container, ou seja, no terminal que aparece após a execução do comando `docker exec` citado acima.

  ⚠ Atenção ⚠ O **git** dentro do container não vem configurado com suas credenciais. Ou faça os commits fora do container, ou configure as suas credenciais do git dentro do container.

  ⚠ Atenção ⚠ Não rode o comando npm audit fix! Ele atualiza várias dependências do projeto, e essa atualização gera conflitos com o avaliador.

  ⚠ Atenção ⚠ Caso você esteja usando macOS e ao executar o `docker-compose up -d` se depare com o seguinte erro:

  ~~~bash
  The Compose file './docker-compose.yml' is invalid because:
  Unsupported config option for services.db: 'platform'
  Unsupported config option for services.node: 'platform'
  ~~~

> Foram encontradas 2 possíveis soluções para este problema:
> 1. Você pode adicionar manualmente a option `platform: linux/amd64` no service do banco de dados no arquivo docker-compose.yml do projeto, mas essa é uma solução local e você deverá reproduzir isso para os outros projetos.
> 2. Você pode adicionar manualmente nos arquivos .bashrc, .zshenv ou .zshrc do seu computador a linha `export DOCKER_DEFAULT_PLATFORM=linux/amd64`, essa é uma solução global.
> As soluções foram com base [nesta fonte](https://stackoverflow.com/a/69636473).


✨ **Dica:** A extensão `Remote - Containers` (que estará na seção de extensões recomendadas do VS Code) é indicada para que você possa desenvolver sua aplicação no container Docker direto no VS Code, como você faz com seus arquivos locais.

<img src="images/remote-container.png" width="800px" >

 :warning: Atenção :warning: Para que você consiga rodar o seu projeto com docker e o avaliador funcione é fundamental que o seu docker compose esteja na **versão 1.29**
 primeiro verifique sua versão
 > docker-compose --version

 Se não for a versão 1.29, faça os seguintes comandos para atualizar a versão:

 >sudo rm /usr/local/bin/docker-compose

 >sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

 >sudo chmod +x /usr/local/bin/docker-compose


---

  ## Sem Docker


  > Instale as dependências [**Caso existam**] com `npm install`

  ⚠ Atenção ⚠ Não rode o comando npm audit fix! Ele atualiza várias dependências do projeto, e essa atualização gera conflitos com o avaliador.

  ✨ **Dica:** Para rodar o projeto desta forma, obrigatoriamente você deve ter o `node` instalado em seu computador.
  ✨ **Dica:** O avaliador espera que a versão do `node` utilizada seja a 16.

  <br/>
<strong>🧑‍💻 Implementações técnicas</strong><br />

Algumas coisas devem seguir um padrão pré-estabelecido para que o projeto funcione adequadamente:

Para executar localmente os testes é preciso escrever adicionar variáveis de ambiente com suas credências do `mysql`, você pode fazer de algumas formas:

  1. Adicionando os dados a arquivo um arquivo com o nome `.env`, como no estão no de exemplo, `.env.example`, basta renomeá-lo e ajustá-lo com suas crendencias:
  ```sh
    # ./.env
    MYSQL_USER=root # ou seu usuário
    MYSQL_PASSWORD=suaSenha # senha do usuário acima
    MYSQL_HOSTNAME=localhost # o padrão é `localhost`
    MYSQL_PORT=3306 # a padrão é `3306`
  ```
    - Depois disso basta rodar `npm test` ou `npm test -- -t "<número-do-requisito>"
  2. Você também pode usar as variáveis de ambiente antes do comando `npm test` como abaixo:
    ```sh
    MYSQL_USER=<SEU_NOME_DE_PESSOA_USUARIA> MYSQL_PASSWORD=<SUA SENHA> MYSQL_HOSTNAME=<NOME_DO_HOST> MYSQL_PORT=<PORTA> npm test
    ```

  * Ou seja, suponha que para poder acessar a base de dados feita neste projeto você tenha `root` como seu nome de pessoa usuária, `password` como senha, `localhost` como host e `1337` como porta. Logo, você executaria:
    ```sh
    MYSQL_USER=root MYSQL_PASSWORD=password MYSQL_HOSTNAME=localhost MYSQL_PORT=1337 npm test
    ```

  * Usando o exemplo anterior de base, suponha que você não tenha setado uma senha para `root` e esteja usando a porta padrão (3306). Neste caso, você executaria:
    ```sh
    MYSQL_USER=root MYSQL_PASSWORD= MYSQL_HOSTNAME=localhost MYSQL_PORT= npm test
    ```

**Dica**: variáveis de ambiente definidas na mesma linha do comando valem apenas para aquele comando. Se preferir, você pode exportar as variáveis de ambiente para toda a _sessão_ (todos os comandos até você fechar aquele terminal). Por exemplo:

```sh
export MYSQL_USER=root MYSQL_PASSWORD=password HOSTNAME=localhost PORT=3306
```

E depois disso você só precisa rodar `npm test` quando for testar os projetos.

⚠️ **Dica**: O avaliador espera que a versão do  MySQL seja a 8.0.23. Em caso de erro nos testes, verifique se essa é a versão que está sendo usada por você.⚠️

⚠️ **Dica**: Caso queira utilizar _Docker_ para rodar os testes localmente, basta executar o comando: ⚠️

```sh
docker run -p 3306:3306 --name mysql_57 -e MYSQL_ROOT_PASSWORD=1234 -d mysql:8.0.23 mysqld --default-authentication-plugin=mysql_native_password
```
