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

end
