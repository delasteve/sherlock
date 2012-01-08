module UsersHelper

  def pretty_decimal(num_of_bytes = 0)
    if num_of_bytes >= 1073741824 || num_of_bytes <= -1073741824
      number_with_precision(num_of_bytes.to_f / 1073741824, :precision => 4, :strip_insignificant_zeros => true) + " TB"
    elsif num_of_bytes >= 1048576 || num_of_bytes <= -1048576
      number_with_precision(num_of_bytes.to_f / 1048576, :precision => 4, :strip_insignificant_zeros => true) + " MB"
    else num_of_bytes >= 1024 || num_of_bytes <= -1024
      number_with_precision(num_of_bytes.to_f / 1024, :precision => 4, :strip_insignificant_zeros => true) + " kB"
    end
  end
end

