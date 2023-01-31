class Dan::Compiler < Temple::Filter
  def on_component(*exps)
    component_name, params, inner_content = exps.dup

    inner_content = compile_inner_content(inner_content)
    # This is a hack to generate random inner_content_xxx variable for each object since they will all share the same scope
    inner_content_variable_name = "inner_content_#{SecureRandom.hex(10)}"

    result = [:multi]
    result << [:capture, inner_content_variable_name, inner_content]
    result << Dan::Component.call(component_name: component_name, params: params, inner_content_variable_name: inner_content_variable_name)

    result
  end

  def compile_inner_content(inner_content)
    inner_content_processed = []
    inner_content.each do |inner_sexp|
      if inner_sexp[0] == :component
        response = compile(inner_sexp)
        inner_content_processed << response
      else
        inner_content_processed << inner_sexp
      end
    end
    inner_content_processed
  end
end
