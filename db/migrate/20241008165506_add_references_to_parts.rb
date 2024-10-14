class AddReferencesToParts < ActiveRecord::Migration[7.0]
  def change
    add_reference :parts, :model, foreign_key: true
    add_reference :parts, :year, foreign_key: true
  end
end
