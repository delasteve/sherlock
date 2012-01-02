class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :user_id
      t.integer :post_count
      t.integer :upload
      t.integer :download
      t.integer :uploaded
      t.integer :seeding

      t.timestamps
    end
  end
end
