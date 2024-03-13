# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_user_is_valid_with_valid_attributes
    user = User.new(email: 'valid@email.com', password: 'securepassword')

    assert_predicate user, :valid?
  end

  def test_user_is_invalid_without_email
    user = User.new(password: 'securepassword')

    assert_not_predicate user, :valid?
    assert_equal ["Email can't be blank"], user.errors.full_messages
  end

  def test_user_is_invalid_with_invalid_email
    user = User.new(email: 'invalid.email.com', password: 'securepassword')

    assert_not_predicate user, :valid?
    assert_equal ['Email is invalid'], user.errors.full_messages
  end

  def test_user_is_invalid_without_password
    user = User.new(email: 'valid@email.com')

    assert_not_predicate user, :valid?
    assert_equal ["Password can't be blank"], user.errors.full_messages
  end

  def test_user_is_invalid_with_short_password
    user = User.new(email: 'valid@email.com', password: 'short')

    assert_not_predicate user, :valid?
    assert_equal ['Password is too short (minimum is 6 characters)'], user.errors.full_messages
  end

  def test_user_is_invalid_with_long_password
    user = User.new(email: 'valid@email.com', password: ''.rjust(129, 'long'))

    assert_not_predicate user, :valid?
    assert_equal ['Password is too long (maximum is 128 characters)'], user.errors.full_messages
  end

  def test_user_email_must_be_unique
    user1 = users(:mary_doe)
    user2 = User.new(email: user1.email, password: 'differentpassword')

    assert_not_predicate user2, :valid?
    assert_equal ['Email has already been taken'], user2.errors.full_messages
  end
end
