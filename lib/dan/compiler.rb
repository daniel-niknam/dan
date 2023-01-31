class Dan::Compiler < Temple::Filter
  def on_component(*exps)
    component_name, params, inner_content = exps.dup

    result = [:multi]
    result << [:capture, "inner_content", inner_content]
    result << Dan::Component.call(component_name: component_name, params: params)

    result
  end
end
