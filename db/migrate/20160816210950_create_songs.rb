class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :play_count
      t.string :key
      t.integer :bpm
      t.text :analysis
      t.integer :rating
      t.boolean :reviewed
      t.references :genre, index: true
      t.references :user, index: true
      t.references :admin, index: true
      t.references :reference, index: true

      t.timestamps null: false
    end
    add_foreign_key :songs, :genres
    add_foreign_key :songs, :users
    add_foreign_key :songs, :admins
    add_foreign_key :songs, :references
  end
end
