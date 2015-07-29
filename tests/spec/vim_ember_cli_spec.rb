require_relative './spec_helper'

describe 'ember.vim' do
  it 'detects when an ember project has been opened' do
    ember_root = open_ember_app()
    output = vim.command 'echo g:ember_root'
    expect(output).to eq(ember_root)
  end

  it 'can return a list of blueprints' do
    open_ember_app()
    output = vim.command 'echo ember#get_blueprints()'
    output = output[1...output.length - 1].split(",").map do |item|
      item.strip!
      item[1...item.length - 1]
    end
    expect(output.length).to eq(43)
    expect(output[0]).to eq('acceptance-test')
  end
end
