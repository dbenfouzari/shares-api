# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :likable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    # A user can only like a likable once.
    add_index :likes, %i[likable_id likable_type user_id], unique: true
  end
end
