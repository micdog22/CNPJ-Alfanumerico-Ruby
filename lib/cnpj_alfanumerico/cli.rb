# frozen_string_literal: true

require "optparse"
require_relative "cnpj"

module CnpjAlfanumerico
  class CLI
    def self.start(argv)
      new.run(argv)
    end

    def run(argv)
      if argv.empty? || ["-h", "--help", "help"].include?(argv[0])
        puts help_text
        return
      end

      cmd = argv.shift
      case cmd
      when "validar"
        n = argv.shift
        abort "Uso: cnpj-alfanumerico validar <cnpj>" unless n
        puts CNPJ.valid?(n) ? "válido" : "inválido"
      when "formatar"
        n = argv.shift
        abort "Uso: cnpj-alfanumerico formatar <cnpj>" unless n
        puts CNPJ.format(n)
      when "limpar"
        n = argv.shift
        abort "Uso: cnpj-alfanumerico limpar <cnpj>" unless n
        puts CNPJ.clean(n)
      when "gerar"
        puts CNPJ.generate
      when "alfa"
        n = argv.shift
        abort "Uso: cnpj-alfanumerico alfa <cnpj>" unless n
        puts CNPJ.to_alfa(n)
      when "numerico"
        a = argv.shift
        abort "Uso: cnpj-alfanumerico numerico <alfa>" unless a
        puts CNPJ.from_alfa(a)
      else
        warn "Comando desconhecido: #{cmd}"
        puts help_text
        exit 1
      end
    rescue => e
      warn "Erro: #{e.message}"
      exit 1
    end

    def help_text
      <<~TXT
      Uso: cnpj-alfanumerico <comando> [args]

      Comandos:
        validar <cnpj>        Verifica se o CNPJ é válido
        formatar <cnpj>       Aplica a máscara ##.###.###/####-##
        limpar <cnpj>         Remove tudo que não é dígito
        gerar                 Gera um CNPJ válido aleatório
        alfa <cnpj>           Converte o CNPJ numérico para base36 (alfanumérico)
        numerico <alfa>       Converte de base36 para CNPJ numérico (14 dígitos)

      Exemplos:
        cnpj-alfanumerico validar 11222333000181
        cnpj-alfanumerico formatar 11222333000181
        cnpj-alfanumerico alfa 11222333000181
        cnpj-alfanumerico numerico 7F4J1Q8K
      TXT
    end
  end
end
