module ApplicationHelper
  def short_date d
    d.strftime "%b %Y"
  end

  def markdown raw
    GitHub::Markup.render('README.md', raw).html_safe if raw.present?
  end
end
