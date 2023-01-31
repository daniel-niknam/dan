class Dan::Component
  def self.call(component_name:, params:, inner_content_variable_name:)
    new.call(component_name: component_name, params: params, inner_content_variable_name: inner_content_variable_name)
  end

  def call(component_name:, params:, inner_content_variable_name:)
    output = component_output(component_name: component_name, params: params)
    Dan::ComponentEngine.new.call(
      update_output_inner_content_variable(output, inner_content_variable_name)
    )
  end

  private

  def component_output(component_name:, params:)
    component_const = Object.const_get(component_name)
    if defined?(component_const)
      component_const.new(**params).call
    else
      "<#{component_name} #{URI.encode_www_form(params)}><%= inner_content %></#{component_name}>"
    end
  end

  def update_output_inner_content_variable(output, inner_content_variable_name)
    if inner_content_variable_name
      output.gsub(/<%=\s*inner_content\s*%>/x, "<%= #{inner_content_variable_name} %>")
    else
      output
    end
  end
end
