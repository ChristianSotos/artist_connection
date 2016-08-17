class DeleteReferencReferencesFromSong < ActiveRecord::Migration
  def change
  	remove_index(:songs, :reference_id)
  	remove_column(:songs, :reference_id)
  end
end
