# == Schema Information
#
# Table name: hourly_statistics
#
#  id                   :integer         not null, primary key
#  statistic_id         :integer
#  change_in_uploaded   :integer
#  change_in_downloaded :integer
#  change_in_uploads    :integer
#  change_in_snatched   :integer
#  change_in_posts      :integer
#  change_in_seeding    :integer
#  change_in_leeching   :integer
#  change_in_buffer     :integer
#  change_in_ratio      :decimal(, )
#  created_at           :datetime
#  updated_at           :datetime
#

class HourlyStatistic < ActiveRecord::Base
end

