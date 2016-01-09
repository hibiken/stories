module PostsHelper
  def post_length_in_minutes(body)
    min = body.split(" ").size / 250
    if min == 0
      'less than a minute read'
    else
      "#{min} min read"
    end
  end

  def link_to_responses_to(post)
    link_to (pluralize(post.responses.count, "response")), post_path(post, anchor: 'responses'), class: 'response-count'
  end
end
