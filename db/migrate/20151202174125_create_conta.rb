class CreateConta < ActiveRecord::Migration
  def change
    create_table :conta do |t|
      t.integer :numero
      t.float :saldo

      t.timestamps null: false
    end
  end
end
