class ChangeTypeFromExtrato < ActiveRecord::Migration
  def change
    change_column :extratos, :valor, :float
  end
end
