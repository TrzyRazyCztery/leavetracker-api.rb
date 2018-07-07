class PrepareAccessToken
  AuthenticationFailed = Class.new(StandardError)

  def call(email, password)
    user = User.find_by(email: email)
    raise AuthenticationFailed.new unless (user.present? and user.authenticate(password))
    build_token(user)
  end

  private

  def build_token(user)
    JsonWebToken.encode(user_id: user.id)
  end
end