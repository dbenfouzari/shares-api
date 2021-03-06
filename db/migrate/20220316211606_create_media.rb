# frozen_string_literal: true

class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
