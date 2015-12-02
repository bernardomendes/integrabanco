class AddFieldNovaContaIdToExtrato < ActiveRecord::Migration
  def change
    add_column :extratos, :nova_conta_id, :integer
  end
end
