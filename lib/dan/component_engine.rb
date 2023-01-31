class Dan::ComponentEngine < Temple::Engine
  use Dan::Parser

  filter :StringSplitter
  filter :StaticAnalyzer

  use Dan::Compiler

  filter :ControlFlow

  filter :Escapable
  filter :MultiFlattener
  filter :StaticMerger
  filter :DynamicInliner
end
