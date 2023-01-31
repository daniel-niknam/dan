class Dan::Component
  def self.call(component_name:, params:)
    new.call(component_name: component_name, params: params)
  end

  def call(component_name:, params:)
    output = component_output(component_name: component_name, params: params)
    Dan::ComponentEngine.new.call(output)
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
end
