class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone_number
      t.string :field

      t.timestamps null: false
    end
  end
end
