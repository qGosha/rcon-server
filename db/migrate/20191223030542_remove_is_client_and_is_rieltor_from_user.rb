class RemoveIsClientAndIsRieltorFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_client, :boolean
    remove_column :users, :is_realtor, :boolean
  end
end
