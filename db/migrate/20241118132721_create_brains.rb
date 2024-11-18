class CreateBrains < ActiveRecord::Migration[7.1]
  def change
    create_table :brains do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.decimal :price
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
