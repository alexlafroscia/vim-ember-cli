require_relative "./spec_helper"

describe "ember#complete_class_and_file" do

  def complete_type_and_file(input = '')
    vim.command "echo ember#complete_class_and_file(0, '#{input}', 0)"
  end

  context "when passed nothing" do
    it "returns a full list of types" do
      open_ember_app()
      output = parse_array complete_type_and_file()
      expect(output.length).to eq(43)
      expect(output[0]).to eq('acceptance-test')
    end
  end

  context "when passed a type" do
    context "when the type is a JS file" do
      it "returns a list of files and directories" do
        open_ember_app()
        output = complete_type_and_file('EmberGen controller')
        output = parse_array output.split("\n")[1]
        expect(output.length).to eq(3)
        expect(output[0]).to eq('application')
        expect(output[1]).to eq('posts')
        expect(output[2]).to eq('posts/post')
      end
    end

    context "when the type is an HBS file" do
      it "returns a list of files and directories" do
        open_ember_app()
        output = complete_type_and_file('EmberGen template')
        output = parse_array output.split("\n")[1]
        expect(output.length).to eq(1)
        expect(output[0]).to eq('application')
      end
    end
  end
end
