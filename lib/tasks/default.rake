if %w(development test).include? Rails.env
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task(:default).clear.enhance(['db:test:prepare', 'spec', 'rubocop'])
end
