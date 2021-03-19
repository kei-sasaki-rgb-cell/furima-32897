class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.string :postcode,       null: false
      t.integer :prefecture_id, null: false
      t.string :city,           null: false
      t.string :block,          null: false
      t.string :building
      t.string :phone_number,   null: false
      t.references :buyer,      null: false,  foreign_key: true
      t.timestamps
    end
  end
end
