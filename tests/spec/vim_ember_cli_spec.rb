require_relative './spec_helper'

describe 'ember.vim' do
  it 'detects when an ember project has been opened' do
    ember_root = open_ember_app()
    output = vim.command('echo g:ember_root')
    expect(output).to eq(ember_root)
  end
end
