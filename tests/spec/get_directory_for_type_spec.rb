require_relative './spec_helper'

describe 'ember#get_directory_for_type' do

  def directoryFor(type)
    vim.command "echo ember#get_directory_for_type('#{type}')"
  end

  it 'can correctly detect the directory for a non-test type' do
    expect(directoryFor('component')).to eq('app/components')
    expect(directoryFor('controller')).to eq('app/controllers')
    expect(directoryFor('model')).to eq('app/models')
    expect(directoryFor('template')).to eq('app/templates')
    expect(directoryFor('view')).to eq('app/views')
  end

  it 'can correctly detect the directory for unit tests' do
    expect(directoryFor('controller-test')).to eq('tests/unit/controllers')
    expect(directoryFor('model-test')).to eq('tests/unit/models')
    expect(directoryFor('view-test')).to eq('tests/unit/views')
  end

  it 'can correctly detect the directory for integration tests' do
    expect(directoryFor('component-test')).to eq('tests/integration/components')
  end

  it 'can correctly detect the directory for acceptance tests' do
    expect(directoryFor('acceptance-test')).to eq('tests/acceptance')
  end
end

