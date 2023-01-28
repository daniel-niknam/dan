# frozen_string_literal: true

require "temple"

require_relative "dan/version"
require_relative "dan/parser"
require_relative "dan/engine"

class Dan
  class Error < StandardError; end

  RUBY_EXPRESION_REGEX = /<%=\s?(?<exp>[a-z0-9()]+)\s?%>/i
  private_constant :RUBY_EXPRESION_REGEX

  def initialize(string)
    @string = string
  end

  def result(b)
    @output = b.eval(Dan::Engine.new.call(@string))

    @output
  end
end
