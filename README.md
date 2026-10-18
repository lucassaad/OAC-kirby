# OAC Kirby

Um projeto acadêmico de jogo em Assembly RISC-V inspirado em *Kirby's Adventure* (NES). O jogo demonstra movimentação e animação de personagem, colisão com o cenário e renderização de mapas em um framebuffer.

## Funcionalidades

- Duas fases com mapas e dados de colisão próprios.
- Movimentação horizontal e rolagem do mapa.
- Salto e queda com atualização de estado do personagem.
- Animação de Kirby orientada para a esquerda ou para a direita.
- Desenho do cenário e do personagem em tiles no framebuffer.

## Controles

| Tecla | Ação |
| --- | --- |
| `A` | Mover para a esquerda |
| `D` | Mover para a direita |
| `W` | Pular |
| `E` | Avançar para a segunda fase |

## Como executar

O projeto foi desenvolvido para o simulador FPGRARS. A partir da raiz do repositório, execute:

```sh
.\tools\fpgrars-x86_64-pc-windows-msvc--unb.exe main.s
```

Os caminhos dos arquivos incluídos são relativos à raiz do repositório. Portanto, mantenha a raiz como diretório de trabalho ao usar o simulador ou outra distribuição do FPGRARS. O executável incluído é para Windows; em outros sistemas, use uma versão compatível do simulador.

## Organização

```text
.
├── assets/
│   ├── maps/       # Matrizes visuais e dados de colisão das fases
│   └── tiles/      # Tiles do cenário e sprites de Kirby
├── examples/       # Rotina de música independente
├── src/            # Lógica do jogo, teclado, estados e renderização
├── tools/          # Executável FPGRARS para Windows
├── archive/        # Versão antiga da rotina de salto, não usada pelo jogo
└── main.s          # Ponto de entrada; inclui os módulos do projeto
```

## Arquivos principais

- [`main.s`](main.s): inicialização e loop principal do jogo.
- [`src/keyboard.s`](src/keyboard.s): leitura do teclado, movimentação e troca de fase.
- [`src/controleEstados.s`](src/controleEstados.s), [`src/checaSubindo.s`](src/checaSubindo.s) e [`src/checaCaindo.s`](src/checaCaindo.s): estados e movimento vertical.
- [`src/print_map.s`](src/print_map.s) e [`src/print_tile.s`](src/print_tile.s): renderização de mapas e tiles.
- [`assets/maps/`](assets/maps/): mapas visuais e matrizes de colisão das duas fases.
- [`assets/tiles/`](assets/tiles/): gráficos usados pelo jogo.
- [`examples/music.s`](examples/music.s): rotina de música separada; não é incluída pelo jogo principal.

## Tecnologias

- Assembly RISC-V
- Simulador FPGRARS
- Git
