require_relative './spec_helper'

describe 'ember#get_directory_for_type' do

  def directory_for(type)
    vim.command "echo ember#get_directory_for_type('#{type}')"
  end

  it 'can correctly detect the directory for a non-test type' do
    expect(directory_for('component')).to eq('app/components')
    expect(directory_for('controller')).to eq('app/controllers')
    expect(directory_for('model')).to eq('app/models')
    expect(directory_for('template')).to eq('app/templates')
    expect(directory_for('view')).to eq('app/views')
  end

  it 'can correctly detect the directory for unit tests' do
    expect(directory_for('controller-test')).to eq('tests/unit/controllers')
    expect(directory_for('model-test')).to eq('tests/unit/models')
    expect(directory_for('view-test')).to eq('tests/unit/views')
  end

  it 'can correctly detect the directory for integration tests' do
    expect(directory_for('component-test')).to eq('tests/integration/components')
  end

  it 'can correctly detect the directory for acceptance tests' do
    expect(directory_for('acceptance-test')).to eq('tests/acceptance')
  end
end

