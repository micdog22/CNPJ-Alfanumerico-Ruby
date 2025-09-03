# frozen_string_literal: true

require_relative "cnpj_alfanumerico/version"
require_relative "cnpj_alfanumerico/cnpj"

module CnpjAlfanumerico
  class Error < StandardError; end

  def self.valid?(cnpj)    = CNPJ.valid?(cnpj)
  def self.format(cnpj)    = CNPJ.format(cnpj)
  def self.clean(cnpj)     = CNPJ.clean(cnpj)
  def self.generate        = CNPJ.generate
  def self.to_alfa(cnpj)   = CNPJ.to_alfa(cnpj)
  def self.from_alfa(alfa) = CNPJ.from_alfa(alfa)
end
