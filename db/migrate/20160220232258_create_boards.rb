class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title
      t.integer :width
      t.integer :height
      t.boolean :private
      t.boolean :editable
      t.integer :likes

      t.timestamps null: false
    end
  end
end
