class AddColumnsToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :item, t.string  :item_name,         null: false
    add_column :item, t.text    :item_description,  null: false
    add_column :item, t.integer :category_id,       null: false
    add_column :item, t.integer :item_condition_id, null: false
    add_column :item, t.integer :item_postage_id,   null: false
    add_column :item, t.integer :prefecture_id,     null: false
    add_column :item, t.integer :shipping_day_id,   null: false
    add_column :item, t.integer :price,             null:false
  end
end
