require_relative "./spec_helper"

describe "ember#complete_type_and_files_with_dir" do

  def complete_type_and_file(input = '')
    output = vim.command "echo ember#complete_type_and_files_with_dir(0, '#{input}', 0)"
    parse_array output
  end

  context "when passed nothing" do
    it "returns a full list of types" do
      open_ember_app()
      output = complete_type_and_file()
      expect(output.length).to eq(43)
      expect(output[0]).to eq('acceptance-test')
    end
  end

  context "when passed a type" do
    context "when the type is a JS file" do
      it "returns a list of files and directories" do
        open_ember_app()
        output = complete_type_and_file('EmberGen controller')
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
        expect(output.length).to eq(1)
        expect(output[0]).to eq('application')
      end
    end
  end
end

describe "ember#complete_type_and_files" do

  def complete_type_and_file(input = '')
    output = vim.command "echo ember#complete_type_and_files(0, '#{input}', 0)"
    parse_array output
  end

  context "when passed nothing" do
    it "returns a full list of types" do
      open_ember_app()
      output = complete_type_and_file()
      expect(output.length).to eq(43)
      expect(output[0]).to eq('acceptance-test')
    end
  end

  context "when passed a type" do
    context "when the type is a JS file" do
      it "returns a list of files and directories" do
        open_ember_app()
        output = complete_type_and_file('EmberGen controller')
        expect(output.length).to eq(2)
        expect(output[0]).to eq('application')
        expect(output[1]).to eq('posts/post')
      end
    end

    context "when the type is an HBS file" do
      it "returns a list of files and directories" do
        open_ember_app()
        output = complete_type_and_file('EmberGen template')
        expect(output.length).to eq(1)
        expect(output[0]).to eq('application')
      end
    end
  end
end
