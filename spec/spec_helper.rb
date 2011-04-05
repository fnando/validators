require "validators"
require "active_support/all"

Time.zone = "America/Sao_Paulo"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"
load "schema.rb"

I18n.load_path << File.dirname(__FILE__) + "/support/translations.yml"

RSpec.configure do |config|
  config.before do
    I18n.locale = :en
    Time.zone = "America/Sao_Paulo"

    ActiveRecord::Base.descendants.each do |model|
      model.delete_all
      Object.class_eval { remove_const model.name if const_defined?(model.name) }
    end

    load File.dirname(__FILE__) + "/support/models.rb"
  end
end
