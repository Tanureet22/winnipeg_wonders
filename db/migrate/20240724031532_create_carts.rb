class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
     er, null t.references :us: false, foreign_key: true

      t.timestamps
    end
  end
end
