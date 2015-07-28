require 'spec_helper'

describe "ember#get_module_name" do
  context "when the buffer is a test" do
    context "that contains a regular test module" do
      context "with an implicit name" do
        it "returns the correct module name" do
          write_file('controller-test.rb', <<-EOF)
            import Ember from 'ember;

            moduleFor('controller:application', {

            });
          EOF

          vim.edit 'controller-test.rb'
          output = vim.command('echo ember#get_module_name()')
          expect(output).to eq("'controller:application'")
        end
      end

      context "with an explicit name" do
        it "returns the correct module name" do
          write_file('controller-test.rb', <<-EOF)
            import Ember from 'ember;

            moduleFor('controller:application', 'Application Controller', {

            });
          EOF

          vim.edit 'controller-test.rb'
          output = vim.command('echo ember#get_module_name()')
          expect(output).to eq("'Application Controller'")
        end
      end
    end

    context "that contains a component test" do
      context "with an implicit name" do
        it "returns the correct module name" do
          write_file('component-test.rb', <<-EOF)
            import Ember from 'ember;

            moduleForComponent('application', {

            });
          EOF

          vim.edit 'component-test.rb'
          output = vim.command('echo ember#get_module_name()')
          expect(output).to eq("'component:application'")
        end
      end

      context "with an explicit name" do
        it "returns the correct module name" do
          write_file('component-test.rb', <<-EOF)
            import Ember from 'ember;

            moduleForComponent('application', 'Application Component', {

            });
          EOF

          vim.edit 'component-test.rb'
          output = vim.command('echo ember#get_module_name()')
          expect(output).to eq("'Application Component'")
        end
      end
    end

    context "that contains a model test" do
      context "with an implicit name" do
        it "returns the correct module name" do
          write_file('model-test.rb', <<-EOF)
            import Ember from 'ember;

            moduleForModel('test', {

            });
          EOF

          vim.edit 'model-test.rb'
          output = vim.command('echo ember#get_module_name()')
          expect(output).to eq("'model:test'")
        end
      end

      context "with an explicit name" do
        it "returns the correct module name" do
          write_file('model-test.rb', <<-EOF)
            import Ember from 'ember;

            moduleForModel('test', 'Test Model', {

            });
          EOF

          vim.edit 'model-test.rb'
          output = vim.command('echo ember#get_module_name()')
          expect(output).to eq("'Test Model'")
        end
      end
    end

    context "that contains an acceptance test" do
      it "returns the correct module name" do
        write_file('acceptance-test.rb', <<-EOF)
          import Ember from 'ember;

          module('Acceptance | some test', {

          });
        EOF

        vim.edit 'acceptance-test.rb'
        output = vim.command('echo ember#get_module_name()')
        expect(output).to eq("'Acceptance | some test'")
      end
    end
  end
end
