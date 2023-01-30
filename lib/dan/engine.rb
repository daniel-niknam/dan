class Dan::Engine < Temple::Engine
  use Dan::Parser

  filter :StringSplitter
  filter :StaticAnalyzer

  use Dan::Compiler
  use Temple::HTML::Pretty

  filter :ControlFlow

  filter :Escapable
  filter :MultiFlattener
  filter :StaticMerger
  filter :DynamicInliner

  generator :ArrayBuffer
end
