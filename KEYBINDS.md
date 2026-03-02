# Keybinds — KriawqVim

Referência completa de todos os atalhos: built-ins do Neovim, customizações e plugins.

`<leader>` = `Espaço`

> **Legenda de modos:**
> `n` = Normal · `i` = Insert · `v` = Visual · `V` = Visual Line · `^V` = Visual Block · `c` = Command · `t` = Terminal

---

## Índice

- [Notação](#notação)
- [Movimento](#movimento)
- [Edição](#edição)
- [Busca](#busca)
- [Visual mode](#visual-mode)
- [Registros e clipboard](#registros-e-clipboard)
- [Macros](#macros)
- [Marks](#marks)
- [Dobramento de código (folds)](#dobramento-de-código-folds)
- [Janelas e splits](#janelas-e-splits)
- [Buffers e tabs](#buffers-e-tabs)
- [Command mode](#command-mode)
- [Customizações globais](#customizações-globais)
- [LSP](#lsp)
- [Telescope & Projetos](#telescope--projetos)
- [nvim-tree](#nvim-tree)
- [nvim-cmp (autocompletar)](#nvim-cmp-autocompletar)
- [Treesitter (seleção incremental)](#treesitter-seleção-incremental)
- [Comentários (nvim-comment)](#comentários-nvim-comment)
- [Surround (nvim-surround)](#surround-nvim-surround)
- [Trouble (diagnósticos)](#trouble-diagnósticos)
- [Terminal (toggleterm)](#terminal-toggleterm)
- [Copilot & CopilotChat](#copilot--copilotchat)
- [Dashboard (alpha-nvim)](#dashboard-alpha-nvim)

---

## Notação

| Símbolo | Significado |
|---|---|
| `<leader>` | Tecla espaço |
| `<CR>` | Enter |
| `<Esc>` | Escape |
| `<BS>` | Backspace |
| `<Tab>` | Tab |
| `<C-x>` | Ctrl + x |
| `<S-x>` | Shift + x |
| `<M-x>` | Alt + x |
| `<A-x>` | Alt + x (alternativo) |
| `[count]` | Número opcional antes do comando (ex: `3j` desce 3 linhas) |

---

## Movimento

**Built-in — não alterados.**

### Básico

| Keybind | Modo | O que faz |
|---|---|---|
| `h` | n/v | Move o cursor para a esquerda |
| `j` | n/v | Move o cursor para baixo |
| `k` | n/v | Move o cursor para cima |
| `l` | n/v | Move o cursor para a direita |
| `[count]j` | n/v | Move `count` linhas para baixo (ex: `5j`) |
| `[count]k` | n/v | Move `count` linhas para cima |

### Por palavra

| Keybind | Modo | O que faz |
|---|---|---|
| `w` | n/v | Próxima palavra (início) |
| `b` | n/v | Palavra anterior (início) |
| `e` | n/v | Fim da palavra atual/próxima |
| `W` | n/v | Próxima WORD (ignora pontuação) |
| `B` | n/v | WORD anterior |
| `E` | n/v | Fim da WORD |

### Por linha

| Keybind | Modo | O que faz |
|---|---|---|
| `0` | n/v | Início da linha (coluna 0) |
| `^` | n/v | Primeiro caractere não-branco da linha |
| `$` | n/v | Fim da linha |
| `g_` | n/v | Último caractere não-branco da linha |

### Por arquivo

| Keybind | Modo | O que faz |
|---|---|---|
| `gg` | n/v | Primeira linha do arquivo |
| `G` | n/v | Última linha do arquivo |
| `[count]G` | n/v | Vai para a linha `count` (ex: `42G`) |
| `:[num]` | c | Vai para a linha `num` (ex: `:42<CR>`) |
| `%` | n/v | Pula para o par correspondente de `(`, `[`, `{` |
| `H` | n | Topo da janela visível |
| `M` | n | Meio da janela visível |
| `L` | n | Fundo da janela visível |

### Por caractere (busca inline)

> ⚠️ `t` foi remapeado — veja [Customizações globais](#customizações-globais).

| Keybind | Modo | O que faz |
|---|---|---|
| `f{char}` | n/v | Pula até o próximo `{char}` na linha (inclusive) |
| `F{char}` | n/v | Pula até o `{char}` anterior na linha (inclusive) |
| `;` | n/v | Repete o último `f`/`F`/`t`/`T` |
| `,` | n/v | Repete na direção oposta |

### Rolagem

| Keybind | Modo | O que faz |
|---|---|---|
| `<C-d>` | n | Rola meia tela para baixo (cursor acompanha) |
| `<C-u>` | n | Rola meia tela para cima |
| `<C-f>` | n | ~~Rola tela inteira para baixo~~ → **remapeado para formatar arquivo** |
| `<C-e>` | n | Rola uma linha para baixo (sem mover cursor) |
| `<C-y>` | n | Rola uma linha para cima (sem mover cursor) |
| `zz` | n | Centraliza a linha do cursor na tela |
| `zt` | n | Coloca a linha do cursor no topo da tela |
| `zb` | n | Coloca a linha do cursor no fundo da tela |

---

## Edição

**Built-in — exceto onde indicado como `[custom]`.**

### Entrar no modo Insert

| Keybind | Modo | O que faz |
|---|---|---|
| `i` | n | Entra no Insert antes do cursor |
| `I` | n | Entra no Insert no início da linha |
| `a` | n | Entra no Insert após o cursor |
| `A` | n | Entra no Insert no fim da linha |
| `o` | n | Abre nova linha abaixo e entra no Insert |
| `O` | n | **[custom]** Adiciona linha vazia abaixo sem entrar no Insert (original: abrir linha acima no insert) |
| `<Tab>` | n | **[custom]** Entra no Insert e insere um `<Tab>` (original: nenhum efeito no normal mode) |
| `gi` | n | Volta para o último local onde estava no Insert |

### Deletar

| Keybind | Modo | O que faz |
|---|---|---|
| `x` | n | Deleta o caractere sob o cursor (vai para o registro `"`) |
| `X` | n | Deleta o caractere antes do cursor |
| `dd` | n | Deleta a linha atual (vai para o registro `"`) |
| `D` | n | **[custom]** Deleta a linha atual **sem copiar** (vai para `"_`, registro de lixo) |
| `dw` | n | Deleta do cursor até o início da próxima palavra |
| `de` | n | Deleta do cursor até o fim da palavra |
| `d$` | n | Deleta do cursor até o fim da linha |
| `d0` | n | Deleta do cursor até o início da linha |
| `diw` | n | Deleta a palavra sob o cursor (inner word) |
| `daw` | n | Deleta a palavra sob o cursor + espaço adjacente |
| `di(` | n | Deleta tudo dentro dos `()` |
| `da(` | n | Deleta tudo dentro dos `()` incluindo os parênteses |
| `di"` | n | Deleta tudo dentro das `""` |
| `[count]dd` | n | Deleta `count` linhas |

### Mudar (delete + insert)

| Keybind | Modo | O que faz |
|---|---|---|
| `cc` | n | Deleta a linha e entra no Insert |
| `C` | n | Deleta do cursor até o fim da linha e entra no Insert |
| `cw` | n | Deleta a palavra e entra no Insert |
| `ciw` | n | Deleta a palavra inteira e entra no Insert |
| `ci"` | n | Deleta o conteúdo entre `""` e entra no Insert |
| `ci(` | n | Deleta o conteúdo entre `()` e entra no Insert |
| `s` | n | Deleta o caractere e entra no Insert |
| `S` | n | Deleta a linha e entra no Insert (igual a `cc`) |

### Substituição inline

| Keybind | Modo | O que faz |
|---|---|---|
| `r{char}` | n | Substitui o caractere sob o cursor por `{char}` |
| `R` | n | Entra no Replace mode (sobrescreve caracteres) |
| `~` | n | Inverte maiúsculas/minúsculas do caractere |
| `guu` | n | Converte a linha para minúsculas |
| `gUU` | n | Converte a linha para maiúsculas |
| `g~~` | n | Inverte case da linha inteira |

### Copiar (yank)

| Keybind | Modo | O que faz |
|---|---|---|
| `yy` ou `Y` | n | Copia a linha inteira |
| `yw` | n | Copia do cursor até o início da próxima palavra |
| `ye` | n | Copia do cursor até o fim da palavra |
| `y$` | n | Copia do cursor até o fim da linha |
| `yiw` | n | Copia a palavra sob o cursor |
| `yi"` | n | Copia o conteúdo entre `""` |
| `[count]yy` | n | Copia `count` linhas |

### Colar (paste)

| Keybind | Modo | O que faz |
|---|---|---|
| `p` | n | Cola após o cursor (ou abaixo da linha para linhas) |
| `P` | n | Cola antes do cursor (ou acima da linha) |
| `gp` | n | Cola após o cursor e move o cursor para o fim do colado |
| `]p` | n | Cola e ajusta a indentação ao contexto atual |

### Desfazer / Refazer

| Keybind | Modo | O que faz |
|---|---|---|
| `u` | n | Desfaz (undo) |
| `U` | n | **[custom]** Refaz (redo) — original: desfaz todas as mudanças da linha |
| `<C-r>` | n | Refaz (redo) — built-in original |

### Indentação

| Keybind | Modo | O que faz |
|---|---|---|
| `>>` | n | Indenta a linha para a direita |
| `<<` | n | Indenta a linha para a esquerda |
| `>}` | n | Indenta o parágrafo |
| `={motion}` | n | Auto-indenta o trecho (ex: `gg=G` indenta o arquivo inteiro) |
| `>` | v | Indenta a seleção (mantém o visual mode) |
| `<` | v | Remove indentação da seleção |

### Operações de linha

| Keybind | Modo | O que faz |
|---|---|---|
| `J` | n | Une a linha atual com a próxima |
| `gJ` | n | Une as linhas sem adicionar espaço |
| `O` | n | **[custom]** Adiciona linha vazia abaixo sem entrar no insert |
| `t` | n | **[custom]** Cria linha acima e entra no Insert (original: mover até char) |

---

## Busca

**Built-in — exceto onde indicado.**

| Keybind | Modo | O que faz |
|---|---|---|
| `/` | n | Busca para frente (aceita regex) |
| `?` | n | Busca para trás |
| `n` | n | Próxima ocorrência (na direção da busca atual) |
| `N` | n | Ocorrência anterior |
| `*` | n | Busca a palavra sob o cursor (para frente) |
| `#` | n | Busca a palavra sob o cursor (para trás) |
| `<Esc>` | n | **[custom]** Limpa o destaque da busca (`:noh`) |
| `gd` | n | **[LSP custom]** Ir para definição do símbolo |
| `gD` | n | **[LSP custom]** Ir para declaração |
| `gr` | n | **[LSP custom]** Ver todas as referências |

### Substituição (command mode)

| Comando | O que faz |
|---|---|
| `:s/foo/bar/` | Substitui `foo` por `bar` na linha atual (primeira ocorrência) |
| `:s/foo/bar/g` | Substitui todas as ocorrências na linha |
| `:%s/foo/bar/g` | Substitui em todo o arquivo |
| `:%s/foo/bar/gc` | Substitui com confirmação a cada ocorrência |
| `:%s/\<foo\>/bar/g` | Substitui apenas palavras exatas |

---

## Visual mode

**Built-in.**

| Keybind | Modo | O que faz |
|---|---|---|
| `v` | n | Inicia Visual mode (por caractere) |
| `V` | n | Inicia Visual Line mode (por linha) |
| `<C-v>` | n | Inicia Visual Block mode (retângulo) |
| `gv` | n | Restaura a última seleção visual |
| `o` | v | Move o cursor para o outro extremo da seleção |
| `O` | v | Move o cursor para o outro extremo (Visual Block) |
| `I` | ^V | Entra no Insert no início de cada linha selecionada |
| `A` | ^V | Entra no Insert no fim de cada linha selecionada |
| `>` / `<` | v | Indenta / remove indentação |
| `y` | v | Copia a seleção |
| `d` | v | Deleta a seleção |
| `c` | v | Deleta a seleção e entra no Insert |
| `~` | v | Inverte case da seleção |
| `u` | v | Converte para minúsculas |
| `U` | v | Converte para maiúsculas |

---

## Registros e clipboard

**Built-in.**

O Neovim tem múltiplos registros onde o texto copiado/deletado vai.

| Keybind | O que faz |
|---|---|
| `"{x}y` | Copia para o registro `{x}` (ex: `"ayy` copia para o registro `a`) |
| `"{x}p` | Cola do registro `{x}` |
| `"*y` / `"*p` | Copia/cola do clipboard do sistema (PRIMARY no X11) |
| `"+y` / `"+p` | Copia/cola do clipboard do sistema (CLIPBOARD — `Ctrl+C`) |
| `"_dd` | Deleta sem salvar em nenhum registro (registro "buraco negro") |
| `""` | Registro padrão (último yank/delete) |
| `"0` | Registro do último yank (nunca sobrescrito por delete) |
| `":` | Último comando executado |
| `"/` | Última busca realizada |
| `:reg` | Mostra todos os registros e seus conteúdos |

> `D` no KriawqVim usa `"_dd` — deleta sem poluir o registro de yank.

---

## Macros

**Built-in.**

Macros gravam sequências de teclas para repetição.

| Keybind | O que faz |
|---|---|
| `q{x}` | Inicia a gravação da macro no registro `{x}` |
| `q` | Para a gravação |
| `@{x}` | Executa a macro do registro `{x}` |
| `@@` | Executa a última macro novamente |
| `[count]@{x}` | Executa a macro `count` vezes |
| `:reg {x}` | Mostra o conteúdo da macro |

---

## Marks

**Built-in.**

Marks são marcadores de posição no arquivo ou global.

| Keybind | O que faz |
|---|---|
| `m{x}` | Define um mark na posição atual (letra minúscula = local, maiúscula = global) |
| `` `{x} `` | Pula para o mark `{x}` (linha e coluna) |
| `'{x}` | Pula para a linha do mark `{x}` |
| `` `. `` | Pula para a última edição |
| `` `" `` | Pula para onde o cursor estava quando o arquivo foi fechado |
| `:marks` | Lista todos os marks |

---

## Dobramento de código (folds)

**Built-in.**

| Keybind | O que faz |
|---|---|
| `za` | Abre/fecha o fold sob o cursor |
| `zo` | Abre o fold |
| `zc` | Fecha o fold |
| `zR` | Abre todos os folds do arquivo |
| `zM` | Fecha todos os folds do arquivo |
| `zj` | Move para o próximo fold |
| `zk` | Move para o fold anterior |

---

## Janelas e splits

**Built-in para criar/gerenciar; navegação customizada.**

### Criar splits

| Comando / Keybind | O que faz |
|---|---|
| `:split` ou `:sp` | Divide a janela horizontalmente |
| `:vsplit` ou `:vsp` | Divide a janela verticalmente |
| `<C-w>s` | Divide horizontalmente (atalho) |
| `<C-w>v` | Divide verticalmente (atalho) |
| `<C-w>n` | Abre janela em branco horizontal |

### Navegar entre splits — `[custom]`

| Keybind | Modo | O que faz |
|---|---|---|
| `<C-h>` | n | Move o foco para o split da esquerda |
| `<C-j>` | n | Move o foco para o split de baixo |
| `<C-k>` | n | Move o foco para o split de cima |
| `<C-l>` | n | Move o foco para o split da direita |

### Redimensionar splits — `[custom]`

| Keybind | Modo | O que faz |
|---|---|---|
| `<leader>j` | n | Aumenta o split horizontal em 5 linhas |
| `<leader>k` | n | Diminui o split horizontal em 5 linhas |
| `<leader>l` | n | Aumenta o split vertical em 5 colunas |
| `<leader>h` | n | Diminui o split vertical em 5 colunas |

### Fechar / reorganizar

| Keybind / Comando | O que faz |
|---|---|
| `<C-w>q` | Fecha a janela atual |
| `<C-w>o` | Fecha todas as janelas exceto a atual |
| `<C-w>=` | Equaliza o tamanho de todas as janelas |
| `<C-w>r` | Rotaciona as janelas |
| `<C-w>x` | Troca de posição com a próxima janela |
| `<C-w>T` | Move a janela atual para uma nova tab |

---

## Buffers e tabs

### Buffers — `[custom]`

| Keybind | Modo | O que faz |
|---|---|---|
| `<S-l>` | n | Vai para o próximo buffer |
| `<S-h>` | n | Vai para o buffer anterior |
| `<S-w>` | n | Fecha o buffer atual (`:bd`) |

### Buffers — built-in

| Comando | O que faz |
|---|---|
| `:ls` ou `:buffers` | Lista todos os buffers abertos |
| `:b {n}` | Abre o buffer número `{n}` |
| `:b {nome}` | Abre o buffer pelo nome (aceita Tab para completar) |
| `:bn` | Próximo buffer |
| `:bp` | Buffer anterior |
| `:bd` | Fecha o buffer atual |
| `:ba` | Abre todos os buffers em splits |

### Tabs — built-in

| Keybind / Comando | O que faz |
|---|---|
| `:tabnew` | Abre uma nova tab |
| `gt` | Próxima tab |
| `gT` | Tab anterior |
| `[count]gt` | Vai para a tab número `count` |
| `:tabclose` | Fecha a tab atual |
| `:tabonly` | Fecha todas as tabs exceto a atual |

---

## Command mode

**Built-in.**

| Comando | O que faz |
|---|---|
| `:w` | Salva o arquivo |
| `:q` | Fecha a janela (erro se houver mudanças não salvas) |
| `:wq` ou `:x` | Salva e fecha |
| `:q!` | Fecha sem salvar (descarta mudanças) |
| `:e {arquivo}` | Abre um arquivo |
| `:e!` | Recarrega o arquivo do disco (descarta mudanças) |
| `:r {arquivo}` | Insere o conteúdo de um arquivo abaixo do cursor |
| `:!{cmd}` | Executa um comando do sistema (ex: `:!ls`) |
| `:.!{cmd}` | Substitui a linha atual pelo output do comando |
| `:%!{cmd}` | Substitui o arquivo inteiro pelo output do comando |
| `:cd {dir}` | Muda o diretório de trabalho |
| `:pwd` | Mostra o diretório atual |
| `:h {termo}` | Abre a ajuda sobre `{termo}` |

### Atalhos no command mode

| Keybind | O que faz |
|---|---|
| `<Tab>` | Autocompleta o comando/caminho |
| `<C-p>` | Vai para o comando anterior no histórico |
| `<C-n>` | Vai para o próximo no histórico |
| `<C-r><C-w>` | Insere a palavra sob o cursor no command mode |
| `<C-r>"` | Insere o conteúdo do registro padrão |

---

## Customizações globais

Definidas em `lua/config/keymaps.lua`.

### Salvar

| Keybind | Modo | O que faz |
|---|---|---|
| `<C-s>` | n | Salva o arquivo |
| `<C-s>` | i | Salva e volta ao Insert mode |
| `<C-s>` | v | Salva e mantém a seleção visual |

### Edição

| Keybind | Modo | O que faz | Override |
|---|---|---|---|
| `<Esc>` | n | Limpa o destaque de busca (`:noh`) | Esc normalmente só sai de modos |
| `D` | n | Deleta a linha atual sem copiar (`"_dd`) | Original `D`: deleta até o fim da linha |
| `U` | n | Redo (`<C-r>`) | Original `U`: desfaz mudanças da linha |
| `O` | n | Adiciona linha vazia abaixo sem entrar no insert | Original `O`: abre linha acima no insert |
| `t` | n | Cria linha acima e entra no Insert (`ko`) | Original `t`: pula até caractere na linha |
| `<Tab>` | n | Entra no Insert e insere um tab | Original: sem ação no normal mode |

---

## LSP

Definidos em `lua/config/keymaps.lua`. Funcionam quando um servidor LSP está ativo no buffer.

| Keybind | Modo | O que faz |
|---|---|---|
| `gd` | n | Vai para a **definição** do símbolo sob o cursor |
| `gD` | n | Vai para a **declaração** do símbolo |
| `gr` | n | Lista todas as **referências** ao símbolo |
| `K` | n | Abre a **documentação** (hover) do símbolo |
| `<leader>rn` | n | **Renomeia** o símbolo em todo o projeto |
| `<leader>a` | n | Abre os **code actions** disponíveis |
| `<C-f>` | n | **Formata** o arquivo inteiro (async) |
| `<leader>e` | n | Abre o **diagnóstico** flutuante da linha |
| `[d` | n | Vai para o **diagnóstico anterior** |
| `]d` | n | Vai para o **próximo diagnóstico** |

---

## Telescope & Projetos

Plugins: `nvim-telescope/telescope.nvim` · `ahmedkhalf/project.nvim`
Arquivos: `lua/plugins/telescope.lua` · `lua/plugins/projects.lua`

Lazy-loaded: carrega apenas quando um desses keybinds é pressionado.

### Keybinds globais

| Keybind | Modo | O que faz |
|---|---|---|
| `<leader>ff` | n | Busca arquivos no projeto (respeita `.gitignore`) |
| `<leader>fg` | n | Busca texto em todos os arquivos (live grep com `rg`) |
| `<leader>fb` | n | Lista e busca entre os buffers abertos |
| `<leader>fh` | n | Busca nos help tags do Neovim |
| `<leader>fp` | n | Lista projetos recentes (Telescope projects) |
| `<leader>fo` | n | Abre input para digitar/completar qualquer pasta como root |

> **`<leader>fp`** mostra todos os projetos detectados. Ao selecionar, o cwd muda e o nvim-tree abre na nova raiz automaticamente.
>
> **`<leader>fo`** aceita `~`, caminhos relativos e absolutos. Tab completa o diretório.

### Keybinds dentro do Telescope

Built-in do plugin — não alterados.

| Keybind | Modo | O que faz |
|---|---|---|
| `<C-n>` / `<C-j>` | i | Próximo resultado |
| `<C-p>` / `<C-k>` | i | Resultado anterior |
| `<CR>` | i/n | Abre o arquivo selecionado |
| `<C-v>` | i/n | Abre em split vertical |
| `<C-x>` | i/n | Abre em split horizontal |
| `<C-t>` | i/n | Abre em nova tab |
| `<C-q>` | i/n | Envia resultados para a quickfix list |
| `<C-c>` / `<Esc>` | i/n | Fecha o Telescope |
| `?` | n | Mostra atalhos disponíveis |

---

## nvim-tree

Plugin: `nvim-tree/nvim-tree.lua` · Arquivo: `lua/plugins/nvim-tree.lua`

### Keybinds globais

| Keybind | Modo | O que faz |
|---|---|---|
| `<C-a>` | n | Abre / fecha o explorador de arquivos |
| `<leader>r` | n | Atualiza a árvore de arquivos |
| `<leader>n` | n | Localiza o arquivo aberto na árvore |

### Keybinds dentro da árvore

Ativos apenas quando o foco está no painel do nvim-tree.

| Keybind | O que faz |
|---|---|
| `<CR>` ou `o` | Abre arquivo ou expande/colapsa pasta |
| `<BS>` | Fecha a pasta pai (colapsa) |
| `u` | Move o foco para a pasta pai sem fechar |
| `a` | Cria um novo arquivo ou pasta (termine com `/` para pasta) |
| `r` | Renomeia o arquivo/pasta |
| `d` | Deleta o arquivo/pasta |
| `R` | Recarrega a árvore |
| `<leader>c` | Define o nó selecionado como root da árvore |
| `<leader>vs` | Abre o arquivo em split vertical |
| `<leader>hs` | Abre o arquivo em split horizontal |

---

## nvim-cmp (autocompletar)

Plugin: `hrsh7th/nvim-cmp` · Arquivo: `lua/plugins/cmp.lua`

Ativo no Insert mode quando o menu de sugestões está aberto.

| Keybind | Modo | O que faz |
|---|---|---|
| `<C-Space>` | i | Força abrir o menu de sugestões |
| `<C-b>` | i | Sobe na documentação da sugestão |
| `<C-e>` | i | Fecha o menu sem aceitar |
| `<CR>` | i | Aceita a sugestão selecionada |
| `<C-n>` | i | Próxima sugestão |
| `<C-p>` | i | Sugestão anterior |
| `<Tab>` | i/s | Próxima sugestão; se não houver menu, expande/pula snippet |
| `<S-Tab>` | i/s | Sugestão anterior; se estiver em snippet, volta para placeholder anterior |

> Sugestões do Copilot aparecem no topo da lista com o ícone ``.
>
> Command-line completion também está ativo: `/` usa fonte de buffer e `:` usa `path` + `cmdline`.

---

## Treesitter (seleção incremental)

Plugin: `nvim-treesitter/nvim-treesitter` · Arquivo: `lua/plugins/treesitter.lua`

Permite expandir/contrair seleções seguindo a árvore sintática do código.

| Keybind | Modo | O que faz |
|---|---|---|
| `gnn` | n | Inicia a seleção incremental no nó atual |
| `grn` | n/v | Expande a seleção para o nó pai |
| `grm` | n/v | Diminui a seleção para o nó filho |
| `grc` | n/v | Expande a seleção para o escopo (função, classe, etc.) |

**Exemplo de uso:** Com o cursor em uma variável dentro de uma função:
- `gnn` → seleciona o identificador
- `grn` → expande para a expressão
- `grn` → expande para o statement
- `grn` → expande para o corpo da função
- `grm` → volta um nível

---

## Comentários (nvim-comment)

Plugin: `terrortylor/nvim-comment` · Arquivo: `lua/plugins/editor.lua`

| Keybind | Modo | O que faz |
|---|---|---|
| `gcc` | n | Comenta/descomenta a linha atual |
| `gc{motion}` | n | Comenta/descomenta o trecho do motion (ex: `gc3j` comenta 3 linhas) |
| `gc` | v | Comenta/descomenta a seleção visual |
| `gcip` | n | Comenta/descomenta o parágrafo inteiro |
| `gco` | n | Adiciona comentário na linha abaixo |
| `gcO` | n | Adiciona comentário na linha acima |
| `gcA` | n | Adiciona comentário no fim da linha atual |

---

## Surround (nvim-surround)

Plugin: `kylechui/nvim-surround` · Arquivo: `lua/plugins/editor.lua`

Atalhos padrão do plugin (não remapeados). Funciona em qualquer linguagem/texto.

| Keybind | Modo | O que faz |
|---|---|---|
| `ys{motion}{char}` | n | Adiciona surround em um motion (ex: `ysiw"` envolve palavra com aspas) |
| `yss{char}` | n | Adiciona surround na linha inteira |
| `ds{char}` | n | Remove um surround (ex: `ds"` remove aspas) |
| `cs{old}{new}` | n | Troca um surround por outro (ex: `cs"'`) |
| `S{char}` | v | Envolve seleção visual com o delimitador |
| `gS{char}` | v | Envolve seleção visual em modo linewise |

Exemplo para JSX/HTML:
- `dst` remove a tag em volta do cursor
- `cst<div>` troca a tag atual para `div`

---

## Trouble (diagnósticos)

Plugin: `folke/trouble.nvim` · Arquivo: `lua/plugins/editor.lua`

| Keybind | Modo | O que faz |
|---|---|---|
| `<leader>xx` | n | Toggle diagnósticos do workspace |
| `<leader>xX` | n | Toggle diagnósticos só do buffer atual |
| `<leader>cs` | n | Símbolos do arquivo atual |
| `<leader>cl` | n | Definições/referências do LSP |
| `<leader>xL` | n | Toggle Location List |
| `<leader>xQ` | n | Toggle Quickfix List |

---

## Terminal (toggleterm)

Plugin: `akinsho/toggleterm.nvim` · Arquivo: `lua/plugins/editor.lua`

O terminal usa `fish` por padrão. Shell configurável em `lua/plugins/editor.lua`.

| Keybind | Modo | O que faz |
|---|---|---|
| `<S-Tab>` | n/i/t | Abre / fecha o terminal horizontal |

### Dentro do terminal

| Keybind | Modo | O que faz |
|---|---|---|
| `<S-Tab>` | t | Fecha o terminal |
| `<C-\><C-n>` | t | Sai do terminal mode (volta ao normal mode do Neovim) |

> Após `<C-\><C-n>` você pode usar todos os keybinds normais do Neovim no painel do terminal.

---

## Copilot & CopilotChat

Plugin: `CopilotC-Nvim/CopilotChat.nvim` · Arquivo: `lua/plugins/copilot.lua`

### Keybinds globais

| Keybind | Modo | O que faz |
|---|---|---|
| `<leader>cc` | n | Abre / fecha o painel do CopilotChat |
| `<leader>cq` | n | Abre um prompt rápido sobre o buffer atual |
| `<leader>ce` | n/v | Explica o código (ou seleção) |
| `<leader>cf` | n/v | Corrige bugs no código |
| `<leader>co` | n/v | Otimiza o código |
| `<leader>cd` | n/v | Gera documentação (JSDoc, docstring, etc.) |
| `<leader>ct` | n/v | Gera testes unitários |
| `<leader>cr` | n/v | Faz code review do código |
| `<leader>cx` | n | Corrige o diagnóstico do LSP sob o cursor |
| `<leader>cg` | n | Gera mensagem de commit para o git staged |

### Dentro da janela do chat

| Keybind | Modo | O que faz |
|---|---|---|
| `<CR>` | n | Envia a mensagem |
| `<C-s>` | i | Envia a mensagem |
| `q` | n | Fecha o chat |
| `<C-c>` | i | Fecha o chat |
| `<C-r>` | n/i | Reseta o chat (limpa o histórico) |
| `<C-a>` | n/i | Aceita o diff sugerido pelo Copilot |
| `<C-d>` | n | Mostra o diff da sugestão |

---

## Dashboard (alpha-nvim)

Plugin: `goolord/alpha-nvim` · Arquivo: `lua/plugins/dashboard.lua`

Aberto automaticamente ao iniciar `nvim` sem arquivos. É o ponto de entrada para o fluxo de trabalho por projetos.

| Tecla | O que faz |
|---|---|
| `p` | Lista projetos recentes — selecione para abrir direto na raiz |
| `o` | Input para abrir qualquer pasta (Tab completa o caminho) |
| `f` | Abre o Telescope para buscar arquivos |
| `r` | Abre o Telescope com arquivos recentes |
| `g` | Abre o Telescope com live grep |
| `n` | Cria um novo arquivo em branco |
| `c` | Abre o `init.lua` (configuração do KriawqVim) |
| `l` | Abre a UI do lazy.nvim (`:Lazy`) |
| `q` | Sai do Neovim |

> Ao pressionar `p` ou `o` e confirmar uma pasta, o nvim-tree abre automaticamente na raiz do projeto escolhido.

---

<sub>Para keybinds completos dos plugins nativos do Neovim (quickfix, spell, etc.), consulte `:help index`.</sub>
