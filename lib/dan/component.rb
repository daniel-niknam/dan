class Dan::Component
  def self.call(component_name:, params:, inner_conent:)
    if defined?(component_name)
      component_name.new(**params).call
    else
      "<#{component_name} #{URI.encode_www_form(params)}></#{component_name}>"
    end
  end
end
