class Admin::SessionsController < Devise::SessionsController
  before_action :redirect_loggedin_user, only: [:new]
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

    def redirect_loggedin_user
      if user_signed_in?
        redirect_to root_path, alert: "Please sign out first"
      end
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
