module ApplicationHelper

  def title
    base_title = "Sherlock Ratio Monitoring System"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end

