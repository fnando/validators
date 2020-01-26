# frozen_string_literal: true

def build_model(&block)
  Class.new do
    include ActiveModel::Model

    def self.name
      "SomeModel"
    end

    instance_eval(&block)
  end
end

class User < ActiveRecord::Base
  has_many :tasks
  has_many :categories
end

class Category < ActiveRecord::Base
  belongs_to :user
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
end

class Buyer < ActiveRecord::Base
  self.table_name = :users
end

class Person < ActiveRecord::Base
  self.table_name = :users
end

class UserWithTLD
  include ActiveModel::Validations
  attr_accessor :url

  validates_url_format_of :url, tld: true

  def self.name
    "User"
  end

  def initialize(url)
    @url = url
  end
end

class ServerWithoutTLD
  include ActiveModel::Validations
  attr_accessor :host

  validates_hostname :host

  def initialize(host)
    @host = host
  end
end

class ServerWithTLD
  include ActiveModel::Validations
  attr_accessor :host

  validates_hostname :host, tld: true

  def initialize(host)
    @host = host
  end
end

class EmailWithTLD
  include ActiveModel::Validations
  attr_accessor :email

  validates_email :email, tld: true

  def initialize(email)
    @email = email
  end
end
