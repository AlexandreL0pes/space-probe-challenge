# space-probe-challenge

Esse projeto consiste em um teste técnico para a vaga de desenvolvedor back-end na empresa Credere.

## Descrição

Uma sonda exploradora da NASA pousou em marte. O pouso se deu em uma área retangular, na qual a sonda pode navegar usando uma interface web. A posição da sonda é representada pelo seu eixo x e y, e a direção que ele está apontado pela letra inicial, sendo as direções válidas:

- `E` - Esquerda
- `D` - Direita
- `C` - Cima
- `B` - Baixo

A sonda aceita três comandos:

- `GE` - girar 90 graus à esquerda
- `GD` - girar 90 graus à direta
- `M` - movimentar. Para cada comando M a sonda se move uma posição na direção à qual sua face está apontada.

# Instalação

1. Faça o download do repositório

```sh
git clone https://github.com/AlexandreL0pes/space-probe-challenge.git
```

2. Construa a aplicação

```sh
docker compose build
```

3. Crie o banco de dados

```sh
docker-compose rails db:create db:migrate db:seed
```

4. Execute a aplicação

```sh
  docker-compose up
```

Depois disso a aplicação estará disponível em [http://localhost:3000](http://localhost:3000).

# Docs

As requisições HTTPs utilizadas para o consumo da API estão dentro do respositório nesse [arquivo](.github/Insomnia_2021-11-28.json), mas podem ser importadas diretamente pelo botão abaixo. A aplicação também está disponível em: [https://agile-springs-19031.herokuapp.com/](https://agile-springs-19031.herokuapp.com/)
<br>

<div align="left">
  <a href="https://insomnia.rest/run/?label=Space%20Probe%20Challenge&uri=https%3A%2F%2Fgithub.com%2FAlexandreL0pes%2Fspace-probe-challenge%2Fblob%2Fmain%2F.github%2FInsomnia_2021-11-28.json" target="_blank"><img src="https://insomnia.rest/images/run.svg" alt="Run in Insomnia"></a>
</div>

<table border="1">
    <tr>
      <td>Endpoint</td>
      <td>Verbo</td>
      <td>Descrição</td>
    </tr>
  <tbody>
    <tr>
      <td>/space_probes</td>
      <td>GET</td>
      <td>Obtêm todas as sondas existentes</td>
    </tr>
    <tr>
      <td>/space_probes/:id/position</td>
      <td>GET</td>
      <td>Obtêm a posição de uma sonda específica</td>
    </tr>
    <tr>
      <td>/space_probes</td>
      <td>POST</td>
      <td>Efetua a criação de uma nova sonda</td>
    </tr> 
    <tr>
      <td>/space_probes/:id/move</td>
      <td>PUT</td>
      <td>Movimenta a sonda especificada na requisição <br>com base nos comandos informados</td>
    </tr>
    <tr>
      <td>/space_probes/:id/reset</td>
      <td>PUT</td>
      <td>Movimenta a sonda para a posição inicial</td>
    </tr>
  </tbody>
</table>
  
### GET /space_probes 
Obtêm todas as sondas existentes persistidas na base de dados.
```json
  [
    {
      "id": 2,
      "position_x": 4,
      "position_y": 4,
      "front_direction": "B",
      "created_at": "2021-11-28T20:58:16.928Z",
      "updated_at": "2021-11-28T20:58:16.928Z"
    },
    {
      "id": 3,
      "position_x": 0,
      "position_y": 0,
      "front_direction": "D",
      "created_at": "2021-11-28T20:58:16.935Z",
      "updated_at": "2021-11-28T20:58:16.935Z"
    }
  ]
```
### GET /space_probes/:id/position
Obtêm posição de uma sonda específica, recebendo como parâmetro o `id` da sonda pela url.
```json
  {
    "id": 2,
    "position_x": 4,
    "position_y": 4,
    "front_direction": "B",
    "created_at": "2021-11-28T20:58:16.928Z",
    "updated_at": "2021-11-28T20:58:16.928Z"
  }
```

### POST /space_probes
Efetua a criação de uma nova sonda na base de dados.
```json
  {
    "id": 2,
    "position_x": 4,
    "position_y": 4,
    "front_direction": "B",
    "created_at": "2021-11-28T20:58:16.928Z",
    "updated_at": "2021-11-28T20:58:16.928Z"
  }
```

### PUT /space_probes/:id/move
Movimenta a sonda com base nos comandos informados.

Exemplo de requisição:
```json 
{
  "commands": ["GE","M","M","M","M"]
}
```

Exemplo de resposta:
```json
{
  "position_x": 0,
  "position_y": 2,
  "front_direction": "B",
  "id": 1,
  "created_at": "2021-11-28T20:58:16.920Z",
  "updated_at": "2021-11-29T00:23:39.230Z"
}
```
### PUT /space_probes/:id/reset
Movimenta a sona para sua posição inicial, nos pontos x: 0, y: 0 e d: 'D'. Esse endpoint retorna apenas o status da requisição.

<br>

## Comandos úteis

- Exclusão e criação do banco de dados
  `docker-compose run --rm puma rails db:reset`

- Executar o rubocop
  `docker-compose run --rm puma rubocop`

- Executar os testes
  `docker-compose run --rm puma rspec`

- Acessar o rails console
  `docker-compose run --rm puma rails c`

# Informações adicionais

- Ruby versão 3.0.0, RoR versão 6.1.4, PostgreSQL versão 12.9;

- Aplicação hospedada no Heroku;

- Caso surjam dúvidas sobre a instalação ou uso da aplicação me avisem que ajudo no que for preciso :)

- Estatísticas sobre a cobertura dos testes (SimpleCov Gem);

<div align="center">
  <image align="center" src=".github/code-coverage.png" width="800px">
</div>

<div align="center">
  <sub>Construído por
    <a href="https://github.com/AlexandreL0pes">Alexandre Lopes</a>
  </sub>
</div>
