module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_digest, User.digest(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||=
      begin
        remember_digest = User.digest(cookies[:remember_token])
        User.find_by(remember_digest: remember_digest)
      end
  end

  def sign_out
    current_user.update_attribute \
      :remember_digest, User.digest(User.new_remember_token)
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
