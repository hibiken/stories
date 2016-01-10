module ApplicationHelper

  def follow_button_for(user)
    if user_signed_in?
      unless current_user?(user)
        if current_user.following?(user)
          render 'shared/unfollow_button'
        else
          render 'shared/follow_button'
        end
      end
    else
      render 'shared/follow_button'
    end
  end

  def follow_tag_button_for(tag)
    if user_signed_in?
      if current_user.following_tag?(tag)
        render 'shared/unfollow_tag_button'
      else
        render 'shared/follow_tag_button'
      end
    else
      render 'shared/follow_tag_button'
    end
  end

  def nav_link_to(text, url, options = {})
    options[:class] ||= ""
    options[:class] += " active" if current_page?(url)
    options[:class].strip!
    link_to text, url, options
  end
end
