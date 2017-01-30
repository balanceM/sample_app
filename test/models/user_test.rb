require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name: "lilei", email: "lilei@qq.com",
  									 password: "lilei_aaa", password_confirmation: "lilei_aaa"	)
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "     "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "   "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 256
  	assert_not @user.valid?
  end													

  test "email validation should accept valid addresses" do 
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_addresses.each do |address|
  		@user.email = address
  		assert @user.valid?, "#{address.inspect} should be valid"
  	end
  end	

  test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
		foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	test "email should be unique" do 
		dup_user = @user.dup
		@user.save
		assert_not dup_user.valid?
		dup_user.email.upcase
		assert_not dup_user.valid?
	end

	test "password should have a minimum length" do
		@user.password = @user.password_confirmation = "a"*5
		assert_not @user.valid?
	end
end
