# 🏴‍☠️ Ilha do Tesouro
### Documentação do projeto

**Ilha do Tesouro** é um jogo de aventura 2D desenvolvido na Godot Engine 4.7.2. O jogador controla um pirata que precisa explorar uma ilha perigosa, encontrar cinco pistas e localizar o tesouro escondido pelo antigo capitão Fli.

Durante a exploração, o jogador deve evitar as cobras, coletar moedas e administrar suas três vidas. A aventura termina quando o tesouro é encontrado ou quando todas as vidas são perdidas.

---

## 📚 Sumário

- [1. Sobre o jogo](#1-sobre-o-jogo)
- [2. História](#2-história)
- [3. Objetivos do projeto](#3-objetivos-do-projeto)
- [4. Tecnologias e recursos](#4-tecnologias-e-recursos)
- [5. Requisitos](#5-requisitos)
- [6. Como obter e executar o projeto](#6-como-obter-e-executar-o-projeto)
- [7. Controles](#7-controles)
- [8. Como jogar](#8-como-jogar)
- [9. Mecânicas do jogo](#9-mecânicas-do-jogo)
- [10. Sistema de pontuação](#10-sistema-de-pontuação)
- [11. Sistema de vidas e derrota](#11-sistema-de-vidas-e-derrota)
- [12. Personagens, inimigos e objetos](#12-personagens-inimigos-e-objetos)
- [13. Telas e navegação](#13-telas-e-navegação)
- [14. Organização dos arquivos](#14-organização-dos-arquivos)
- [15. Funcionamento interno](#15-funcionamento-interno)
- [16. Testes recomendados](#16-testes-recomendados)
- [17. Melhorias futuras](#17-melhorias-futuras)
- [18. Créditos e informações acadêmicas](#18-créditos-e-informações-acadêmicas)

---

## 1. Sobre o jogo

O projeto consiste em um jogo de exploração e caça ao tesouro em um cenário 2D. O jogador controla um personagem pirata e percorre uma ilha em busca de objetivos que são distribuídos pelo mapa.

O principal desafio é encontrar cinco pistas antes de chegar ao tesouro. O jogo fornece indicações de direção e distância até o objetivo atual, permitindo que o jogador decida como explorar o cenário.

Além da busca, existem cobras que causam dano ao personagem e moedas que podem ser coletadas para aumentar a pontuação.

## 2. História

Segundo a história apresentada na tela **Sobre**, um antigo capitão pirata conhecido como Fli escondeu seu maior tesouro em uma ilha distante. Antes de desaparecer, espalhou cinco pistas pelo território e protegeu o caminho com armadilhas e cobras.

O jogador assume a missão de explorar a ilha, encontrar as cinco pistas e descobrir a localização do lendário tesouro perdido.

## 3. Objetivos do projeto

### Objetivo geral

Desenvolver um jogo de aventura 2D utilizando a Godot Engine, aplicando conceitos de lógica de programação, movimentação, colisão, organização de cenas e interação entre objetos.

### Objetivos específicos

- Implementar movimentação do personagem em oito direções.
- Criar animações para as direções de movimento e para o personagem parado.
- Construir um cenário 2D explorável.
- Configurar colisões com obstáculos e inimigos.
- Sortear posições para as cinco pistas e para o tesouro.
- Orientar o jogador por meio de direção e distância.
- Implementar coleta de moedas.
- Criar um sistema de pontuação.
- Controlar as vidas do personagem.
- Implementar condições de vitória e derrota.
- Criar telas de menu, vitória e derrota.

## 4. Tecnologias e recursos

| Tecnologia ou recurso | Utilização |
|---|---|
| Godot Engine 4.7.2 | Engine utilizada no desenvolvimento |
| GDScript | Linguagem dos scripts do jogo |
| Godot 2D | Desenvolvimento do cenário e dos elementos em duas dimensões |
| `CharacterBody2D` | Controle de movimento e colisão do pirata e da cobra |
| `AnimatedSprite2D` | Animações do pirata, da cobra e da moeda |
| `CollisionShape2D` | Formas de colisão |
| `Area2D` | Detecção da coleta de moedas |
| `Control` e nós de interface | Construção dos menus e telas |
| Autoload | Compartilhamento dos resultados entre cenas |
| Git e GitHub | Versionamento e hospedagem do código |

## 5. Requisitos

Para abrir e executar o projeto, são necessários:

- Computador com sistema operacional compatível com a Godot Engine.
- Godot Engine 4.7 ou versão compatível com o projeto.
- Arquivos completos do repositório.
- Teclado numérico para utilizar os controles configurados.

O projeto foi configurado com a Godot 4.7 e renderização **GL Compatibility**.

## 6. Como obter e executar o projeto

### 6.1. Clonar o repositório

No terminal, execute:

```bash
git clone URL_DO_REPOSITORIO
```

Substitua `URL_DO_REPOSITORIO` pelo endereço HTTPS ou SSH do repositório.

Também é possível baixar o projeto pelo botão **Code → Download ZIP** do GitHub.

### 6.2. Abrir na Godot

1. Abra a Godot Engine.
2. Na tela de projetos, selecione **Importar**.
3. Localize a pasta baixada.
4. Selecione o arquivo `project.godot`.
5. Importe e abra o projeto.

### 6.3. Executar

Depois de abrir o projeto, utilize o botão de execução da Godot.

- `F6`: executa a cena atualmente aberta.
- `F5`: executa a cena principal configurada no projeto.

**Atenção à configuração atual:** no arquivo `project.godot` enviado, a cena principal está apontada para `player.tscn`. A cena de menu está em `menu_inicial.tscn`, e o botão **Jogar** chama `ilha.scn`. Se a intenção for iniciar o jogo pelo menu ao pressionar `F5`, configure `menu_inicial.tscn` como cena principal em **Projeto → Configurações do Projeto → Aplicação → Executar → Cena Principal**.

## 7. Controles

A movimentação utiliza o teclado numérico e permite andar em oito direções.

| Tecla | Direção |
|---|---|
| 8 | Norte |
| 2 | Sul |
| 4 | Oeste |
| 6 | Leste |
| 7 | Noroeste |
| 9 | Nordeste |
| 1 | Sudoeste |
| 3 | Sudeste |

O personagem se movimenta enquanto a tecla correspondente estiver pressionada. Ao soltar a tecla, ele para e mantém a orientação da última direção utilizada.

A velocidade diagonal é normalizada para que o personagem não se movimente mais rápido nas diagonais do que nas direções retas.

## 8. Como jogar

1. Inicie a aventura.
2. Utilize o teclado numérico para explorar a ilha.
3. Observe o painel de instruções.
4. Siga a direção e a distância indicadas até a pista atual.
5. Encontre as cinco pistas.
6. Depois da quinta pista, siga as indicações até o tesouro.
7. Evite as cobras e colete as moedas pelo caminho.

O jogador começa com três vidas. É importante evitar colisões com as cobras para não perder todas elas antes de encontrar o tesouro.

## 9. Mecânicas do jogo

### 9.1. Movimentação do pirata

O personagem é controlado por oito ações de entrada configuradas no projeto: norte, sul, leste, oeste, nordeste, noroeste, sudeste e sudoeste.

O script `player.gd` controla a velocidade, a direção, as animações e a distância percorrida. A movimentação utiliza `CharacterBody2D` e `move_and_slide()`.

### 9.2. Exploração e objetivos aleatórios

O jogo possui seis objetivos: cinco pistas e um tesouro. O script `gerenciador_pistas.gd` sorteia as posições desses objetivos dentro de uma área definida do mapa.

O sorteio considera:
- Limites horizontais e verticais definidos no script.
- Distância mínima entre os objetivos.
- Distância mínima entre os objetivos e a posição inicial do jogador.
- Verificação de obstáculos por consulta ao espaço físico 2D.

Os marcadores dos objetivos permanecem invisíveis durante a busca. O jogador recebe as orientações por meio da interface.

### 9.3. Orientação por direção e distância

O jogo calcula a distância entre o pirata e o objetivo atual. Essa distância é convertida em passos considerando uma referência de 32 unidades por passo.

A direção é apresentada como norte, sul, leste, oeste ou uma das quatro diagonais.

O painel de instruções muda conforme o jogador encontra cada pista e avança na missão.

### 9.4. Descoberta das pistas

Cada pista encontrada:
- Avança o progresso da missão.
- Atualiza a mensagem de descoberta.
- Acrescenta 100 pontos.
- Faz o sistema indicar a próxima pista.

As mensagens de descoberta também apresentam partes da história do tesouro.

### 9.5. Tesouro

Depois que as cinco pistas são encontradas, o próximo objetivo passa a ser o tesouro.

Ao alcançá-lo, o jogador recebe 200 pontos adicionais e a cena de vitória é aberta.

### 9.6. Moedas

As moedas são objetos coletáveis. Quando o personagem entra na área de colisão de uma moeda, o sistema adiciona 50 pontos à pontuação e remove a moeda da cena.

## 10. Sistema de pontuação

A pontuação é atualizada durante a partida pelo método `atualizar_pontuacao()` do `gerenciador_pistas.gd`.

| Ação | Pontos |
|---|---:|
| Encontrar uma pista | +100 |
| Encontrar o tesouro | +200 |
| Coletar uma moeda | +50 |
| Perder uma vida | -100 |

A pontuação é exibida na interface durante a partida. Na vitória, o resultado é armazenado e apresentado na tela final.

**Exemplo:** encontrar as cinco pistas e o tesouro, sem coletar moedas e sem perder vidas, resulta em 700 pontos.

## 11. Sistema de vidas e derrota

O personagem começa com **3 vidas**.

Quando uma cobra colide com o jogador, o método `receber_dano()` é chamado. O sistema:
1. Verifica se o personagem pode receber dano.
2. Retira uma vida.
3. Aplica uma penalidade de 100 pontos.
4. Atualiza o texto de vidas na interface.
5. Aguarda 1,5 segundo antes de permitir outro dano, caso o jogador ainda esteja vivo.

Quando as vidas chegam a zero, o jogo muda para a tela de derrota.

## 12. Personagens, inimigos e objetos

### Pirata

É o personagem controlado pelo jogador. Possui animações de movimento e de repouso nas oito direções.

### Cobra

A cobra é um inimigo controlado pelo script `cobra.gd`. Ela se movimenta em uma das quatro direções principais — norte, sul, leste ou oeste — e escolhe uma nova direção aleatória ao iniciar e ao encontrar uma parede.

Quando colide com o jogador, causa perda de uma vida.

### Moeda

A moeda possui animação própria e utiliza `Area2D` para detectar quando o jogador entra em contato com ela. Sua coleta adiciona 50 pontos.

### Obstáculos

Elementos do cenário, como árvores, água e limites da ilha, dificultam a exploração e impedem a passagem do personagem conforme as colisões configuradas no mapa.

## 13. Telas e navegação

### Menu inicial — `menu_inicial.tscn`

Apresenta o título e as opções:

- **Jogar:** abre a cena `ilha.scn`.
- **Como Jogar:** abre uma janela com objetivo, controles e regras de pontuação.
- **Sobre:** apresenta a história do capitão Fli e do tesouro perdido.

### Tela de jogo — `ilha.scn`

É a área principal de exploração. Nela ficam o personagem, o cenário, os objetivos, os inimigos e a interface com instruções, pontuação e vidas.

### Tela de vitória — `tela_vitoria.tscn`

É exibida quando o tesouro é encontrado. Apresenta uma mensagem de comemoração, a pontuação final, as vidas restantes e um botão para voltar ao menu.

### Tela de derrota — `tela_derrota.tscn`

É exibida quando o jogador perde todas as vidas. Apresenta uma mensagem de encerramento da jornada e permite retornar ao menu inicial.

## 14. Organização dos arquivos

A estrutura identificada no projeto enviado é:

```text
jogo---caça-ao-tesouro/
│
├── project.godot
├── README.md
├── .gitignore
│
├── player.tscn
├── ilha.scn
├── menu_inicial.tscn
├── tela_vitoria.tscn
├── tela_derrota.tscn
├── cobra.tscn
├── moeda.tscn
│
├── player.gd
├── gerenciador_pistas.gd
├── cobra.gd
├── moeda.gd
├── menu_inicial.gd
├── tela_vitoria.gd
├── tela_derrota.gd
├── ResultadoJogo.gd
│
└── Assents/
    ├── imagens do pirata e animações
    ├── imagens da cobra
    ├── imagens das moedas
    ├── imagens do mapa e dos terrenos
    ├── Fundo_menu.png
    ├── FundoVitoria.png
    └── FundoGameOver.png
```

A pasta `Assents` contém os recursos gráficos utilizados no projeto. O nome está escrito dessa forma no projeto original e, por isso, deve ser mantido ao referenciar os arquivos.

O arquivo `.gitignore` já contém a regra para ignorar a pasta `.godot/`, que armazena dados locais gerados pelo editor.

## 15. Funcionamento interno

### 15.1. Scripts principais

| Arquivo | Responsabilidade |
|---|---|
| `player.gd` | Movimentação, animações, vidas, distância percorrida e recebimento de dano |
| `gerenciador_pistas.gd` | Sorteio dos objetivos, orientação, descoberta das pistas e pontuação |
| `cobra.gd` | Movimento aleatório da cobra, animação e colisão com o jogador |
| `moeda.gd` | Detecção da coleta da moeda e adição de pontos |
| `menu_inicial.gd` | Navegação do menu e abertura das janelas informativas |
| `tela_vitoria.gd` | Exibição dos resultados e retorno ao menu |
| `tela_derrota.gd` | Retorno ao menu após a derrota |
| `ResultadoJogo.gd` | Armazenamento temporário da pontuação final e das vidas restantes |

### 15.2. Gerenciamento dos resultados

O script `ResultadoJogo.gd` é registrado como Autoload no projeto. Isso permite manter os resultados disponíveis durante a troca de cenas.

As variáveis utilizadas são:
- `pontuacao_final`: armazena a pontuação obtida.
- `vidas_finais`: armazena a quantidade de vidas restantes.

Quando o tesouro é encontrado, o gerenciador copia os valores da partida para essas variáveis. A tela de vitória utiliza os valores para preencher os textos correspondentes.

### 15.3. Troca de cenas

As mudanças entre as telas são realizadas por meio de `get_tree().change_scene_to_file()`. No encerramento da partida, a troca para a tela de vitória ou derrota é solicitada de forma adiada com `call_deferred()`.

## 16. Testes recomendados

A lista abaixo pode ser utilizada para verificar as funcionalidades antes da entrega:

- [ ] O projeto abre na Godot sem erros.
- [ ] O menu inicial é exibido conforme a configuração de execução.
- [ ] O botão Jogar abre a fase.
- [ ] A janela Como Jogar apresenta as instruções.
- [ ] A janela Sobre apresenta a história.
- [ ] O pirata se movimenta nas oito direções.
- [ ] O pirata mantém a última direção ao parar.
- [ ] As colisões com os obstáculos funcionam.
- [ ] As cinco pistas são sorteadas.
- [ ] Os objetivos respeitam as verificações de distância e obstáculos.
- [ ] O painel informa direção e distância.
- [ ] Cada pista adiciona 100 pontos.
- [ ] A moeda adiciona 50 pontos.
- [ ] A cobra causa perda de vida e 100 pontos.
- [ ] A partida termina ao perder as três vidas.
- [ ] O tesouro é encontrado somente depois das cinco pistas.
- [ ] A vitória adiciona 200 pontos.
- [ ] A tela de vitória apresenta pontuação e vidas.
- [ ] Os botões de retorno levam ao menu inicial.

## 17. Melhorias futuras

Algumas funcionalidades que podem ser consideradas em versões futuras:

- Adicionar novos tipos de inimigos.
- Criar novas ilhas e fases.
- Adicionar efeitos sonoros e música.
- Implementar novos itens coletáveis.
- Criar níveis de dificuldade.
- Desenvolver um sistema de recordes.
- Adicionar novas missões e histórias.

## 18. Créditos e informações acadêmicas

**Projeto:** Ilha do Tesouro  
**Instituição:** Instituto Federal de Educação, Ciência e Tecnologia do Sul de Minas Gerais — IFSULDEMINAS  
**Campus:** Machado  
**Curso:** Sistemas de Informação  
**Disciplina:** [Preencher com o nome da disciplina]  
**Professor(a):** [Preencher com o nome do(a) professor(a)]  
**Desenvolvedor(es):** [Preencher com o(s) nome(s)]

### Créditos dos recursos visuais

Preencha esta seção com os autores, sites e licenças dos sprites, imagens, fundos e demais recursos externos utilizados no jogo, conforme a origem de cada material.

---

**Explore a ilha, encontre as cinco pistas, escape das cobras e conquiste o lendário tesouro do capitão Fli!** 🏴‍☠️
