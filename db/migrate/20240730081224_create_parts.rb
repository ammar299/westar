class CreateParts < ActiveRecord::Migration[7.0]
  def change
    create_table :parts do |t|
      t.string :item_part_number
      t.string :part_number
      t.text :description
      t.integer :package_level_gtin
      t.float :height
      t.float :width
      t.float :length
      t.float :shipping_height
      t.float :shipping_width
      t.float :shipping_length
      t.float :weight
      t.text :attribute_name
      t.text :product_attribute

      t.timestamps
    end
  end
end
