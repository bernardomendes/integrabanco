class CreateContas < ActiveRecord::Migration
  def change
    create_table :contas do |t|
      t.integer :numero
      t.float :saldo

      t.timestamps null: false
    end
  end
end
