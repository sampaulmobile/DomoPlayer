class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|

      t.integer :soundcloud_id
      t.integer :soundcloud_user_id
      t.datetime :soundcloud_created_at

      t.string :title
      t.string :uri
      t.string :sharing

      t.text :description
      t.integer :duration
      t.string :genre
      t.boolean :downloadable, :streamable

      t.integer :comment_count, default: 0
      t.integer :download_count, default: 0
      t.integer :playback_count, default: 0
      t.integer :favoritings_count, default: 0

      t.timestamps null: false
    end

    add_index :tracks, :soundcloud_id, unique: true
  end
end
