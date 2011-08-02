ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :email, :corporate_email, :url, :cpf, :zipcode
    t.string :email, :corporate_email, :url
    t.datetime :registered_at, :starts_at, :ends_at
    t.date :birthday
  end

  create_table :categories do |t|
    t.references :user
  end

  create_table :tasks do |t|
    t.references :user, :category
  end

  create_table :companies do |t|
    t.string :cnpj, :url
  end
end
