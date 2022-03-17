class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension("citext")

    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.citext :email, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
