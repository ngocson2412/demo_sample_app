class CreateLikeposts < ActiveRecord::Migration
  def change
    create_table :likeposts do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps null: false
    end
    add_index :likeposts, :user_id
    add_index :likeposts, :post_id
    add_index :likeposts, [:user_id, :post_id], unique: true
  end
end
