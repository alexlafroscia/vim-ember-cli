require 'vimrunner'
require 'vimrunner/rspec'

Vimrunner::RSpec.configure do |config|
  config.reuse_server = true

  config.start_vim do
    vim = Vimrunner.start

    plugin_path = File.expand_path('../../../', __FILE__)
    vim.add_plugin(plugin_path, 'plugin/ember.vim')

    # Set up the Vim instance to use the context of the Ember app that can be
    #   found in `../ember-app`.
    #
    #   This is useful when we want to verify a command that reads from the file
    #   structure for input
    def open_ember_app()
      ember_root = File.expand_path('../../ember-app', __FILE__)
      vim.command "cd #{ember_root}"
      vim.command "e package.json"
      vim.command "echo ember#detect_cli_project()"
      ember_root
    end

    # Parse a "vim array" into a real Ruby array
    def parse_array(input)
      input[1...input.length - 1].split(",").map do |item|
        item.strip!
        item[1...item.length - 1]
      end
    end

    vim
  end
end
