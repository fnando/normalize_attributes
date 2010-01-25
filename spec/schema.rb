ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :email, :username
  end

  create_table :tokens do |t|
    t.string :name
    t.references :user
  end
end
