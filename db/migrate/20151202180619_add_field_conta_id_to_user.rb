class AddFieldContaIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :conta_id, :integer
  end
end
