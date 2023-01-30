# frozen_string_literal: true

class SelfClosedComponent
  def call
    "<strong>Hello World</strong>"
  end
end

class SelfClosedComponentWithParam
  def initialize(name:, **)
    @name = name
  end

  def call
    "<strong>Hello World #{@name}</strong>"
  end
end

RSpec.describe Dan do
  it "has a version number" do
    expect(Dan::VERSION).not_to be nil
  end

  it "renders a simple text" do
    template = Dan.new <<~EOF
      My Simple Text
    EOF
    expect(template.result(binding)).to eq("My Simple Text\n")
  end

  it "renders a simple text with a HTML tag" do
    template = Dan.new <<~EOF
      My <strong>Simple</strong> Text
    EOF
    expect(template.result(binding)).to eq("My <strong>Simple</strong> Text\n")
  end

  it "renders a simple object in the given template" do
    x = 42
    template = Dan.new <<~EOF
      The value of x is: <%= x %>
    EOF
    expect(template.result(binding)).to eq("The value of x is: 42\n")
  end

  it "renders a simple object in the given HTML template" do
    x = 42
    template = Dan.new <<~EOF
      The value of x is: <strong><%= x %></strong>
    EOF
    expect(template.result(binding)).to eq("The value of x is: <strong>42</strong>\n")
  end

  it "renders a self closed component in the given HTML template" do
    template = Dan.new <<~EOF
      <b>Here</b> is my component: <SelfClosedComponent />
    EOF
    expect(template.result(binding)).to eq("<b>Here</b> is my component: <strong>Hello World</strong>\n")
  end

  it "renders a self closed component with parameter in the given HTML template" do
    template = Dan.new <<~EOF
      Here is my component: <SelfClosedComponentWithParam name="Alex" />
    EOF
    expect(template.result(binding)).to eq("Here is my component: <strong>Hello World Alex</strong>\n")
  end
end
