class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :artist_name
      t.string :email
      t.integer :phone_number
      t.string :password_digest
      t.text :description
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :soundcloud

      t.timestamps null: false
    end
  end
end
