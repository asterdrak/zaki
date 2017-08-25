# frozen_string_literal: true
if %w(development test).include? Rails.env
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  require 'haml_lint/rake_task'
  HamlLint::RakeTask.new

  task(:default).clear.enhance([
                                 'db:test:prepare',
                                 'rubocop',
                                 'haml_lint',
                                 'coffeelint',
                                 'spec'
                               ])

end
