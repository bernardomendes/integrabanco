class AddFieldPrefixoToTipoOperacao < ActiveRecord::Migration
  def change
    add_column :tipo_operacoes, :prefixo, :string
  end
end
