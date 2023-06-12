class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :user_id,           null: false, foreign_key: true
      t.string  :item_name,         null: false
      t.text    :item_description,  null: false
      t.integer :category_id,       null: false
      t.integer :item_condition_id, null: false
      t.integer :item_postage_id,   null: false
      t.integer :prefecture_id,     null: false
      t.integer :shipping_day_id,   null: false
      t.integer :price,             null:false
      t.timestamps
    end
  end
end
