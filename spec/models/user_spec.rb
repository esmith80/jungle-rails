require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
  it 'should create a new user with all fields completed' do
    @user = User.new(
    first_name: "Alice",
    last_name: "Test",
    email: "test@test.com",
    password:"password",
    password_confirmation:"password"
    )
    @user.save
    expect(@user.errors.full_messages).to be_empty
  end

  it 'should receive an error message if first name is not present' do
    @user = User.new(
      first_name: nil,
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
    @user.save
    expect(@user.errors.full_messages).to include("First name can't be blank")
  end

  it 'should receive an error message if last name is not present' do
    @user = User.new(
      first_name: "Alice",
      last_name: nil,
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
    @user.save
    expect(@user.errors.full_messages).to include("Last name can't be blank")
  end
  
  it 'should receive an error message if email is not present' do
    @user = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: nil,
      password:"password",
      password_confirmation:"password"
      )
    @user.save
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it 'should receive and error if email is already in database' do
    @user = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
    @user.save
    @user_two = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
    @user_two.save
    expect(@user_two.errors.full_messages).to include("Email has already been taken")
  end

  it 'should receive and error if email is already in database' do
    @user = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
    @user.save
    @user_two = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@TEST.com",
      password:"password",
      password_confirmation:"password"
      )
    @user_two.save
    expect(@user_two.errors.full_messages).to include("Email has already been taken")
  end

  it 'should receive an error message if password length is less than 8 characters' do
    @user = User.new(
      first_name: nil,
      last_name: nil,
      email: "test@test.com",
      password:"passwor",
      password_confirmation:"passwor"
      )
    @user.save
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
  end
end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'should return a user if authenticated successfully' do
      @user = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
      @user.save
      @authenticated_user = User.authenticate_with_credentials("test@test.com", "password")
      
      expect(@user).to eq(@authenticated_user)
    end

    it 'should return nil if authentication fails' do
      @user = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
      @user.save
      @authenticated_user = User.authenticate_with_credentials("test@test.com", "pasword")
      
      expect(@authenticated_user).to eq(nil)
    end

    it 'should allow extra spaces in login email' do
      @user = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
      @user.save
      @authenticated_user = User.authenticate_with_credentials("   test@test.com", "password")
      
      expect(@user).to eq(@authenticated_user)
    end

    it 'email validation should be case insensitive when logging in' do
      @user = User.new(
      first_name: "Alice",
      last_name: "Test",
      email: "test@test.com",
      password:"password",
      password_confirmation:"password"
      )
      @user.save
      @authenticated_user = User.authenticate_with_credentials("TEST@TEST.com", "password")
      
      expect(@user).to eq(@authenticated_user)
    end

  end

end
