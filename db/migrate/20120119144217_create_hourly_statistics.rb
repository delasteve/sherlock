class CreateHourlyStatistics < ActiveRecord::Migration
  def change
    create_table :hourly_statistics do |t|
      t.integer :statistic_id
      t.integer :change_in_uploaded
      t.integer :change_in_downloaded
      t.integer :change_in_uploads
      t.integer :change_in_snatched
      t.integer :change_in_posts
      t.integer :change_in_seeding
      t.integer :change_in_leeching
      t.integer :change_in_buffer
      t.decimal :change_in_ratio, :scale => 5

      t.timestamps
    end
  end
end

