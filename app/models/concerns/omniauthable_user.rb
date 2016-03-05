module OmniauthableUser
  extend ActiveSupport::Concern

  included do
    # Add SecureRandom.hex to user's email to avaoid confilict between
    # providers. If one user uses the same email for Facebook and Google,
    # prepending this string will not cause "email has already been taken" error.
    def self.find_or_create_from_facebook_omniauth(auth)
      user = where(provider: auth.provider, uid: auth.uid).first_or_create
      unless auth.info.image.nil?
        user.remote_avatar_url = auth.info.image.gsub('http://','https://') + '?type=large'
      end
      user.update(
        email: "#{SecureRandom.hex}#{auth.info.email}",
        password: Devise.friendly_token[0,20],
        username: auth.info.name
      )
      user
    end

    def self.find_or_create_from_twitter_omniauth(auth)
      user = where(provider: auth.provider, uid: auth.uid).first_or_create
      unless auth.info.image.nil?
        user.remote_avatar_url = auth.info.image.gsub('http://', 'https://').gsub('_normal', '')
      end
      user.update(
        username: auth.info.name,
        password: Devise.friendly_token[0, 20],
        email: "#{SecureRandom.hex}#{auth.info.nickname}@mymediumclone.com" # Twitter does not provide email
      )
      user
    end

    def self.find_or_create_from_google_omniauth(auth)
      user = where(provider: auth.provider, uid: auth.uid).first_or_create
      user.remote_avatar_url = auth.info.image
      user.update(
        username: auth.info.name,
        email: "#{SecureRandom.hex}#{auth.info.email}",
        password: Devise.friendly_token[0, 20]
      )
      user
    end

    def self.new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"]) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end

  end


  def password_required?
    super && self.provider.blank?
  end

  def email_required?
    super && self.provider.blank?
  end

end
