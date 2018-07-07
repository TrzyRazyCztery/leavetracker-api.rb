require 'test_helper'

class RegisteringUserTest < ActiveSupport::TestCase
  def setup
    @register_user = RegisterUser.new
    @password = SecureRandom.hex
  end

  def test_cant_register_user_with_same_email
    register_user.('foo@bar.me', 'name', 'surname', password, password)
    register_user.('foo@bar.me', 'name2', 'surname2', password, password)
  rescue Exceptions::ValidationFailed => e
    assert_equal e.errors[:email][0], "has already been taken"
  end

  def test_cant_register_user_without_email
    register_user.('', 'name', 'surname', password, password)
  rescue Exceptions::ValidationFailed => e
    assert_equal e.errors[:email][0], "can't be blank"
  end

  def test_cant_register_user_without_name
    register_user.('foo@bar.me', '', 'surname', password, password)
  rescue Exceptions::ValidationFailed => e
    assert_equal e.errors[:name][0], "can't be blank"
  end

  def test_cant_register_user_without_surname
    register_user.('foo@bar.me', 'name', '', password, password)
  rescue Exceptions::ValidationFailed => e
    assert_equal e.errors[:surname][0], "can't be blank"
  end

  def test_cant_register_user_without_password
    register_user.('foo@bar.me', 'name', 'surname', '', password)
  rescue Exceptions::ValidationFailed => e
    assert_equal e.errors[:password][0], "can't be blank"
  end

  def test_cant_register_user_without_password_confirmation_match
    register_user.('foo@bar.me', 'name', 'surname', password, '')
  rescue Exceptions::ValidationFailed => e
    assert_equal e.errors[:password_confirmation][0], "doesn't match Password"
  end

  def test_cant_register_user_with_invalid_email_format
    register_user.('foo.me', 'name', 'surname', password, password)
  rescue Exceptions::ValidationFailed => e
    assert_equal e.errors[:email][0], "is invalid"
  end


  private
  attr_reader :register_user, :password
end