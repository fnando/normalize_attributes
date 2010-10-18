ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :email, :username
    t.text :preferences
    t.integer :age, :null => false, :default => 0
  end

  create_table :tokens do |t|
    t.string :name
    t.references :user
  end
end
