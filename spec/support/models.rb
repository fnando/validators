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
