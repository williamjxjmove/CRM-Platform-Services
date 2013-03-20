module ApplicationHelper

  # Simple helper to inject the page title into pages used in the site.
  def full_title(page_title)
    base_title = 'CRM Platform Services API'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
