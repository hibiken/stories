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
end
