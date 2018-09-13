require 'sidekiq/web'


Sidekiq::Web.use(Rack::Auth::Basic) do |email, password|
  user = User.find_for_authentication(:email => email)
  user.valid_password?(password) ? user : nil and user.is_admin?
end