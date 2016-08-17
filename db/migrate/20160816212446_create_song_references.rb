class CreateSongReferences < ActiveRecord::Migration
  def change
    create_table :song_references do |t|
      t.references :song, index: true
      t.references :reference, index: true

      t.timestamps null: false
    end
    add_foreign_key :song_references, :songs
    add_foreign_key :song_references, :references
  end
end
