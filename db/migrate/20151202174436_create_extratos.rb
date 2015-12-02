class CreateExtratos < ActiveRecord::Migration
  def change
    create_table :extratos do |t|
      t.integer :tipo_operacao_id
      t.integer :conta_id
      t.integer :valor
      t.string :descricao

      t.timestamps null: false
    end
  end
end
