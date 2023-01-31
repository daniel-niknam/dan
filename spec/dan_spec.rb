# frozen_string_literal: true

class SelfClosedComponent
  def call
    %(<strong>Hello World</strong>)
  end
end

class SelfClosedComponentWithParam
  def initialize(name:, **)
    @name = name
  end

  def call
    %(<strong>Hello World #{@name}</strong>)
  end
end

class ComponentWithInnerContent
  def call
    %(<div><strong>My Content</strong><%= inner_content %></div>)
  end
end

RSpec.describe Dan do
  it "has a version number" do
    expect(Dan::VERSION).not_to be nil
  end

  it "renders a simple text" do
    template = Dan.new(%(My Simple Text))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/text()").text).to eq("My Simple Text")
  end

  it "renders a simple text with a HTML tag" do
    template = Dan.new(%(My <strong>Simple</strong> Text))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/text()").text).to eq("My ")
    expect(parsed_html.at_xpath("/strong/text()").text).to eq("Simple")
    expect(parsed_html.at_xpath("/text()[2]").text).to eq(" Text")
  end

  it "renders a simple object in the given template" do
    x = 42
    template = Dan.new(%(The value of x is: <%= x %>))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/text()").text).to eq("The value of x is: 42")
  end

  it "renders a simple object in the given HTML template" do
    x = 42
    template = Dan.new(%(The value of x is: <strong><%= x %></strong>))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/text()").text).to eq("The value of x is: ")
    expect(parsed_html.at_xpath("/strong/text()").text).to eq("42")
  end

  it "renders a self closed component in the given HTML template" do
    template = Dan.new(%(<b>Here</b> is my component: <SelfClosedComponent />))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/b/text()").text).to eq("Here")
    expect(parsed_html.at_xpath("/text()").text).to eq(" is my component: ")
    expect(parsed_html.at_xpath("/strong/text()").text).to eq("Hello World")
  end

  it "renders a self closed component with parameter in the given HTML template" do
    template = Dan.new(%(Here is my component: <SelfClosedComponentWithParam name="Alex" />))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/text()").text).to eq("Here is my component: ")
    expect(parsed_html.at_xpath("/strong/text()").text).to eq("Hello World Alex")
  end

  it "renders a component with inner content in the given HTML template" do
    template = Dan.new(%(<ComponentWithInnerContent>My Inner Content</ComponentWithInnerContent>))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/div/strong/text()").text).to eq("My Content")
    expect(parsed_html.at_xpath("/div/text()").text).to eq("My Inner Content")
  end

  it "renders multiple component with inner content in the given HTML template" do
    template = Dan.new(%(<ComponentWithInnerContent>First inner<ComponentWithInnerContent>Second inner</ComponentWithInnerContent></ComponentWithInnerContent>))

    parsed_html = Oga.parse_html(template.result(binding))
    expect(parsed_html.at_xpath("/div/strong/text()").text).to eq("My Content")
    expect(parsed_html.at_xpath("/div/text()").text).to eq("First inner")
  end
end
