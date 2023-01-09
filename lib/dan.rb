# frozen_string_literal: true

require_relative "dan/version"

class Dan
  class Error < StandardError; end

  RUBY_EXPRESION_REGEX = /<%=\s?(?<exp>[a-z0-9()]+)\s?%>/i
  private_constant :RUBY_EXPRESION_REGEX

  def initialize(string)
    @string = string
    @output = ""
  end

  def result(b)
    @output = @string.gsub(RUBY_EXPRESION_REGEX) do |_m|
      b.eval($~[:exp])
    end

    @output
  end
end
