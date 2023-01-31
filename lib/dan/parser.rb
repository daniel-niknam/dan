class Dan::Parser < Temple::Parser
  def initialize(_options)
    @result = [:multi]
  end

  def call(input)
    @result = [:multi]

    document = Oga.parse_html(input)
    document.children.each do |node|
      parse_document(node, @result)
    end

    @result
  end

  private

  def parse_document(document, result = [:multi])
    if document.is_a? Oga::XML::Element
      node_result = [:multi]
      attributes = {}
      document.children.each do |node|
        parse_document(node, node_result)
      end
      document.attributes.each do |attribute|
        attributes[attribute.name.to_sym] = attribute.value
      end
      result << if upcase?(document.name)
        [:component, document.name, attributes, node_result]
      else
        [:html, :tag, document.name, [:multi], node_result]
      end
    elsif document.is_a? Oga::XML::Text
      erb = Temple::ERB::Parser.new.call(document.text)
      # Temple::ERB parser will return a S-Expression like
      # [:multi, [:static, "..."]] We are removing
      # the :multi part since we don't need it and add
      # the rest of S-Expressions to our result
      erb.delete_at(0)
      erb.each { |sexp| result << sexp }
    else
      puts document.inspect
    end
  end

  def upcase?(string)
    !string[0][/[[:lower:]]/]
  end
end
