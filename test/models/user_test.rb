require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'valid',
                     email: 'valid@email.com',
                     surname: 'valid',
                     password: 'valid_password',
                     password_confirmation: 'valid_password')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'surname should be present' do
    @user.surname = ' '
    assert_not @user.valid?
  end

  test 'surname should not be too long' do
    @user.surname = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should have right format' do
    invalid_email_addresses = %W[invalid, invalid@invalid, invalid@invalid,invalid, invalid.invalid, ]
    invalid_email_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end
  
  test 'email address should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = ' '
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a'* 4
    assert_not @user.valid?
  end
end
