module PostsHelper
  def post_length_in_minutes(body)
    if body.blank?
      min = 0 
    else 
      min = body.split(" ").size / 250
    end
    if min == 0
      'less than a minute read'
    else
      "#{min} min read"
    end
  end

  # whitelisting
  # TODO: this won't work for embedded video
  def sanitize_html(html)
    sanitize(html, tags: %w(p b i u blockquote br h2 h3 div a img figure figcaption iframe html),
             attributes: %w(class href style))
  end
end
