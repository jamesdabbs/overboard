module ApplicationHelper
  def short_date d
    d.strftime "%b %Y"
  end
end
