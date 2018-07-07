class RegisterUser
  AlreadyRegistered = Class.new(StandardError)

  def call(email, name, surname, password, password_conf)
    user = User.new(email: email,
                 password: password,
                 name: name,
                 password_confirmation: password_conf,
                 surname: surname
    )
    raise Exceptions::ValidationFailed.new  validation_errors user unless user.valid?
    user.save!
  end


  private
  def user_exists?(email)
    User.find_by(email: email).present?
  end

  def validation_errors(user)
    user.errors.messages
  end
end