class AddTypeToMedium < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE medium_type AS ENUM ('book', 'restaurant', 'movie', 'series', 'video_game');
    SQL

    add_column :media, :medium_type, :medium_type
    add_index :media, :medium_type
  end

  def down
    remove_column :media, :medium_type

    execute <<-SQL
      DROP TYPE medium_type
    SQL
  end
end
