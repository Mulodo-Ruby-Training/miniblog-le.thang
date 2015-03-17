class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name,       limit: 50, null: false
      t.integer :parent_id, limit: 2,  default: 0
      t.boolean :status,    default: 0

      t.timestamps null: false
    end
  end
end
