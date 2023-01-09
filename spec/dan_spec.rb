# frozen_string_literal: true

RSpec.describe Dan do
  it "has a version number" do
    expect(Dan::VERSION).not_to be nil
  end

  it "renders a simple text" do
    template = Dan.new <<~EOF
      This is my text
    EOF
    expect(template.result(binding)).to eq("This is my text\n")
  end

  it "renders a simple object in the given template" do
    x = 42
    template = Dan.new <<~EOF
      The value of x is: <%= x %>
    EOF
    expect(template.result(binding)).to eq("The value of x is: 42\n")
  end
end
