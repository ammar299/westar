class CreateMakes < ActiveRecord::Migration[7.0]
  def change
    create_table :makes do |t|
      t.string :name
      t.references :year, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
