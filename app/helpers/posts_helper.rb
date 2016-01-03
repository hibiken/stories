module PostsHelper
  def post_length_in_minutes(body)
    min = body.split(" ").size / 250
    if min == 0
      'less than a minute'
    else
      "#{min} min read"
    end
  end
end
