# frozen_string_literal: true

require "rspec"
require_relative "../lib/cnpj_alfanumerico"

RSpec.describe CnpjAlfanumerico do
  let(:valid_cnpj) { "11222333000181" }

  it "limpa máscara" do
    expect(CnpjAlfanumerico.clean("11.222.333/0001-81")).to eq(valid_cnpj)
  end

  it "formata corretamente" do
    expect(CnpjAlfanumerico.format(valid_cnpj)).to eq("11.222.333/0001-81")
  end

  it "valida corretamente" do
    expect(CnpjAlfanumerico.valid?(valid_cnpj)).to be true
  end

  it "gera CNPJ válido" do
    gen = CnpjAlfanumerico.generate
    expect(gen.size).to eq(14)
    expect(CnpjAlfanumerico.valid?(gen)).to be true
  end

  it "converte para base36 e volta" do
    alfa = CnpjAlfanumerico.to_alfa(valid_cnpj)
    back = CnpjAlfanumerico.from_alfa(alfa)
    expect(back).to eq(valid_cnpj)
  end

  it "rejeita códigos base36 inválidos" do
    expect { CnpjAlfanumerico.from_alfa("!!") }.to raise_error(ArgumentError)
  end
end
