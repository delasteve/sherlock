module UsersHelper

  def make_viewable_stats(hourly_statistic, statistic)
    unless statistic.nil?
      "#{pretty_decimal hourly_statistic} (#{pretty_decimal statistic})"
    else
      "Paranoid."
    end
  end

  def make_viewable_ratio(hourly_ratio, ratio)
    unless ratio.nil?
      "#{pretty_ratio hourly_ratio} (#{pretty_ratio ratio})"
    else
      "Paranoid."
    end
  end

  def pretty_decimal(num_of_bytes)
    if num_of_bytes >= 1099511627776 || num_of_bytes <= -1099511627776
      number_with_precision(num_of_bytes.to_f / 1099511627776, :precision => 3,
                                                               :strip_insignificant_zeros => true) + " TB"
    elsif num_of_bytes >= 1073741824 || num_of_bytes <= -1073741824
       number_with_precision(num_of_bytes.to_f / 1073741824,   :precision => 3,
                                                               :strip_insignificant_zeros => true) + " GB"
    elsif num_of_bytes >= 1048576 || num_of_bytes <= -1048576
      number_with_precision(num_of_bytes.to_f / 1048576,       :precision => 3,
                                                               :strip_insignificant_zeros => true) + " MB"
    else num_of_bytes >= 1024 || num_of_bytes <= -1024
      number_with_precision(num_of_bytes.to_f / 1024,          :precision => 3,
                                                               :strip_insignificant_zeros => true) + " kB"
    end
  end

  def pretty_ratio(ratio)
    number_with_precision(ratio, :precision => 3, :strip_insignificant_zeros => true)
  end

  def make_dygraph_statistics(csv_array)
    csv_array.to_s.gsub(/(", ")/, '"+"').gsub(/(\[|\])/, '').html_safe
  end
end
