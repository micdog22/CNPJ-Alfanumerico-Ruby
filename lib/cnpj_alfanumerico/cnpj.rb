# frozen_string_literal: true

module CnpjAlfanumerico
  class CNPJ
    DIGITS = ("0".."9").to_a.freeze
    BASE36 = (("0".."9").to_a + ("A".."Z").to_a).freeze

    class << self
      def clean(str)
        (str || "").to_s.gsub(/\D/, "")
      end

      def format(cnpj)
        n = clean(cnpj)
        raise ArgumentError, "CNPJ precisa ter 14 dígitos" unless n.size == 14
        "%s.%s.%s/%s-%s" % [n[0,2], n[2,3], n[5,3], n[8,4], n[12,2]]
      end

      def valid?(cnpj)
        n = clean(cnpj)
        return false unless n.size == 14
        return false if n.chars.uniq.size == 1

        d1 = calc_digit(n[0,12], [5,4,3,2,9,8,7,6,5,4,3,2])
        d2 = calc_digit(n[0,12] + d1.to_s, [6,5,4,3,2,9,8,7,6,5,4,3,2])
        n[-2,2] == "#{d1}#{d2}"
      end

      def generate
        base = Array.new(12) { rand(10) }.join
        d1   = calc_digit(base, [5,4,3,2,9,8,7,6,5,4,3,2])
        d2   = calc_digit(base + d1.to_s, [6,5,4,3,2,9,8,7,6,5,4,3,2])
        base + d1.to_s + d2.to_s
      end

      def to_alfa(cnpj)
        n = clean(cnpj)
        raise ArgumentError, "CNPJ inválido" unless n.size == 14
        i = n.to_i
        return "0" if i == 0
        s = ""
        while i > 0
          i, r = i.divmod(36)
          s << BASE36[r]
        end
        s.reverse
      end

      def from_alfa(alfa)
        s = (alfa || "").to_s.upcase.strip
        raise ArgumentError, "Código alfanumérico inválido" unless s.match?(/^[0-9A-Z]+$/)
        i = 0
        s.each_char { |ch| i = i * 36 + BASE36.index(ch) }
        "%014d" % i
      end

      private

      def calc_digit(str, weights)
        sum = str.chars.map(&:to_i).zip(weights).map { |d, w| d * w }.sum
        r = sum % 11
        r < 2 ? 0 : 11 - r
      end
    end
  end
end
