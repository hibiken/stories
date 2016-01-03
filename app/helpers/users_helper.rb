module UsersHelper
  def avatar_for(user, options = { size: 80 })
    size = options[:size]
    if user.avatar?
      if size <= 80
        image_tag user.avatar.url(:thumb), width: size, height: size, alt: user.username, class: 'avatar-image'
      else
        image_tag user.avatar.url, width: size, height: size, alt: user.username, class: 'avatar-image'
      end
    else
      image_tag 'default-avatar.jpg', width: size, height: size, alt: 'avatar image', class: 'avatar-image'
    end
  end
end
