# frozen_string_literal: true

require_relative "lib/cnpj_alfanumerico/version"

Gem::Specification.new do |spec|
  spec.name          = "cnpj_alfanumerico"
  spec.version       = CnpjAlfanumerico::VERSION
  spec.authors       = ["MicDog (Michael Douglas)"]
  spec.email         = [""]

  spec.summary       = "Validação, formatação, geração e conversão alfanumérica (base36) de CNPJ, com CLI."
  spec.description   = "Biblioteca Ruby para manipular CNPJ: validação, máscara, geração e conversão numérico ⇄ alfanumérico. Inclui CLI e testes."
  spec.homepage      = "https://example.com/cnpj_alfanumerico"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(bin/|lib/|LICENSE|README\.md)}) }
  rescue
    Dir.glob("bin/*") + Dir.glob("lib/**/*") + ["LICENSE", "README.md"]
  end

  spec.bindir        = "bin"
  spec.executables   = ["cnpj-alfanumerico"]
  spec.require_paths = ["lib"]

  spec.metadata = { "rubygems_mfa_required" => "false" }
end
