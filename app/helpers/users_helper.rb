module UsersHelper
  def avatar_for(user, options = { size: 80 })
    size = options[:size]
    style = options[:style]
    if user.avatar.attached?
      image_tag user.avatar.variant(resize: "#{size}x#{size}"), width: size, height: size, alt: user.username, class: 'avatar-image', style: style
    else
      image_tag 'default-avatar.svg', width: size, height: size, alt: 'avatar image', class: 'avatar-image', style: style
    end
  end
end
