class Dan::Compiler < Temple::Filter
  def on_component(*exps)
    component_name, params, inner_content = exps.dup

    [:dynamic, "::Dan::Component.call(component_name: #{component_name}, params: #{params}, inner_conent: #{inner_content})"]
  end
end
