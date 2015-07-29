require 'vimrunner'
require 'vimrunner/rspec'

Vimrunner::RSpec.configure do |config|
  config.reuse_server = true

  config.start_vim do
    vim = Vimrunner.start

    plugin_path = File.expand_path('../../../', __FILE__)
    vim.add_plugin(plugin_path, 'plugin/ember.vim')

    def open_ember_app()
      ember_root = File.expand_path('../../ember-app', __FILE__)
      vim.command "cd #{ember_root}"
      vim.command "e package.json"
      vim.command "echo ember#detect_cli_project()"
      ember_root
    end

    vim
  end
end
