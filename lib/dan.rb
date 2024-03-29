# frozen_string_literal: true

require "temple"
require "oga"
require "securerandom"

require_relative "dan/version"
require_relative "dan/parser"
require_relative "dan/compiler"
require_relative "dan/engine"
require_relative "dan/component_engine"
require_relative "dan/component"

class Dan
  class Error < StandardError; end

  def initialize(string)
    @string = string
  end

  def result(b)
    @output = b.eval(Dan::Engine.new.call(@string))

    @output
  end
end
