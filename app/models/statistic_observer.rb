class StatisticObserver < ActiveRecord::Observer

  def before_create(statistic)
    statistic.ratio = statistic.uploaded.to_f / statistic.downloaded if !statistic.uploaded.nil? and !statistic.downloaded.nil?
    statistic.buffer = statistic.uploaded - statistic.downloaded if !statistic.uploaded.nil? and !statistic.downloaded.nil?

    last_hours_statistics = Statistic.order("created_at DESC").find_by_user_id(statistic.user_id)

    statistic.create_hourly_statistic(:change_in_uploaded => do_calculation(statistic.uploaded, last_hours_statistics.uploaded),
                                      :change_in_downloaded => do_calculation(statistic.downloaded, last_hours_statistics.downloaded),
                                      :change_in_uploads => do_calculation(statistic.uploads, last_hours_statistics.uploads),
                                      :change_in_snatched => do_calculation(statistic.snatched, last_hours_statistics.snatched),
                                      :change_in_posts => do_calculation(statistic.posts, last_hours_statistics.posts),
                                      :change_in_seeding => do_calculation(statistic.seeding, last_hours_statistics.seeding),
                                      :change_in_leeching => do_calculation(statistic.leeching, last_hours_statistics.leeching),
                                      :change_in_buffer => do_calculation(statistic.buffer, last_hours_statistics.buffer),
                                      :change_in_ratio => do_calculation(statistic.ratio, last_hours_statistics.ratio))
  end

  private
    def do_calculation(statistic, last_hours_statistic)
      if !statistic.nil? and !last_hours_statistic.nil?
        statistic - last_hours_statistic
      elsif !statistic.nil? and last_hours_statistic.nil?
        statistic
      else
        0
      end
    end
end
