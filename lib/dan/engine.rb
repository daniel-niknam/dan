class Dan::Engine < Temple::Engine
  use Temple::ERB::Parser
  use Temple::ERB::Trimming

  filter :Escapable
  filter :MultiFlattener
  filter :StaticMerger

  generator :ArrayBuffer
end
