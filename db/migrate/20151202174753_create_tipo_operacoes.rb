class CreateTipoOperacoes < ActiveRecord::Migration
  def change
    create_table :tipo_operacoes do |t|
      t.string :nome
      t.string :metodo

      t.timestamps null: false
    end
  end
end
