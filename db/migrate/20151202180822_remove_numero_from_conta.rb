class RemoveNumeroFromConta < ActiveRecord::Migration
  def change
    remove_column :contas, :numero, :integer
  end
end
