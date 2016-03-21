module ControllerMacros
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    sign_in user
  end

  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end
