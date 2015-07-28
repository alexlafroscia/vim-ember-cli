require 'vimrunner'

vim = Vimrunner.start
vim.add_plugin(File.expand_path('../..', __FILE__), 'autoload/ember.vim')
vim.add_plugin(File.expand_path('../..', __FILE__), 'plugin/ember.vim')

RSpec.describe "runspec.vim" do
  after(:all) do
    vim.kill
  end

  describe "Test Command" do
    it "returns 'Hello World'" do
      output = vim.command('echo "Hello World"')
      expect(output).to eq('Hello World')
    end
  end
end
