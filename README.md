# CNPJ Alfanumérico (Ruby)

Biblioteca Ruby para **validar**, **formatar**, **gerar**, **converter para alfanumérico (base36)** e **reverter** CNPJ.
Inclui **CLI** (`cnpj-alfanumerico`) e **tests (RSpec)**.

**Autor:** MicDog (Michael Douglas)  
**Licença:** MIT

## Recursos

- Validação completa dos dígitos verificadores
- Remoção e aplicação de máscara (`11.222.333/0001-81`)
- Geração de CNPJ válido aleatório
- Conversão **Numérico ⇄ Alfanumérico (Base36)** para compactar o CNPJ em um código curto
- CLI sem dependências externas
- Testes (RSpec)

## Instalação

### Como Gem local (recomendado para começar)

```bash
git clone <seu-fork-ou-zip> cnpj_alfanumerico
cd cnpj_alfanumerico
bundle install
rake build
gem install pkg/cnpj_alfanumerico-$(ruby -r ./lib/cnpj_alfanumerico/version -e "puts CnpjAlfanumerico::VERSION").gem
```

Isso instalará o executável `cnpj-alfanumerico` no seu RubyGems bin path.

### Em um projeto Ruby (via Gemfile)

Por enquanto use via path (ou publique no RubyGems):

```ruby
# Gemfile
gem "cnpj_alfanumerico", path: "../cnpj_alfanumerico"
```

## Uso da Biblioteca

```ruby
require "cnpj_alfanumerico"

cnpj = "11222333000181"

CnpjAlfanumerico.valid?(cnpj)        # => true/false
CnpjAlfanumerico.format(cnpj)        # => "11.222.333/0001-81"
CnpjAlfanumerico.clean("11.222.333/0001-81")  # => "11222333000181"

alfa = CnpjAlfanumerico.to_alfa(cnpj)   # => e.g. "7F4J1Q8K"
num  = CnpjAlfanumerico.from_alfa(alfa) # => "11222333000181"

gerado = CnpjAlfanumerico.generate      # => "XXXXXXXXXXXXXX" (válido)
```

## CLI

```bash
cnpj-alfanumerico validar 11222333000181
cnpj-alfanumerico formatar 11222333000181
cnpj-alfanumerico limpar 11.222.333/0001-81
cnpj-alfanumerico gerar
cnpj-alfanumerico alfa 11222333000181
cnpj-alfanumerico numerico 7F4J1Q8K
```

Saída de ajuda:

```bash
cnpj-alfanumerico --help
```

## Base36 (Alfanumérico)

- O CNPJ (14 dígitos) é tratado como inteiro decimal e convertido para **base36** (`0-9A-Z`).
- `to_alfa` remove zeros à esquerda; `from_alfa` **reconstrói com 14 dígitos**, preservando o valor.
- **A conversão NÃO substitui a validação** — sempre utilize `valid?` quando necessário.

## Testes

```bash
bundle exec rspec
```

## Licença

MIT — © MicDog (Michael Douglas)
