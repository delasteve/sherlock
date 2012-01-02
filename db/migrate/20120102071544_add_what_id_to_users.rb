class AddWhatIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :what_uid, :integer
  end
end

