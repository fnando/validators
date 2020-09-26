# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options << "--config"
  t.options << File.expand_path(".rubocop.yml", __dir__)
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = false
end

task default: %i[test rubocop]
