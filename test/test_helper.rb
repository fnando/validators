require "simplecov"
SimpleCov.start

require "bundler/setup"
require "active_record"
require "validators"
require "active_support/all"

require "minitest/utils"
require "minitest/autorun"

Time.zone = "America/Sao_Paulo"
TLDs = Validators::TLD.all.sample(50)
DISPOSABLE_EMAILS = Validators::DisposableHostnames.all.sample(50)

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"
load "schema.rb"

I18n.enforce_available_locales = false
I18n.load_path << File.dirname(__FILE__) + "/support/translations.yml"

module Minitest
  class Test
    setup do
      I18n.locale = :en
      Time.zone = "America/Sao_Paulo"

      ActiveRecord::Base.descendants.each do |model|
        next if [
          "ActiveRecord::SchemaMigration",
          "ActiveRecord::InternalMetadata"
        ].include? model.name

        model.delete_all

        Object.class_eval {
          remove_const model.name if const_defined?(model.name)
        }
      end

      load File.dirname(__FILE__) + "/support/models.rb"
    end
  end
end
