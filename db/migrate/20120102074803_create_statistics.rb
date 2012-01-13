class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :user_id
      t.integer :uploaded
      t.integer :downloaded
      t.integer :seeding
      t.integer :leeching
      t.integer :posts
      t.integer :uploads
      t.integer :snatched
      t.decimal :ratio, :scale => 5
      t.integer :buffer

      t.timestamps
    end
  end
end

