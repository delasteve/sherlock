class AddWhatIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :whatid, :integer
  end
end
