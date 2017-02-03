require 'test_helper'

class UsersSignUpTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, user: { name: "",
  														 email: "user@invalid",
  														 password: "foo",
  														 password_confirmation: "bar" }
  	end
  	assert_template 'users/new'
  end

  test "valid signup information" do
  	get signup_path
  	name = "qqq"
  	email = "qqq@qq.com"
  	password = "q"*6
  	assert_difference "User.count", 1 do
  		post_via_redirect users_path, user: { name: name,
  																					email: email,
  																					password: password,
  																					password_confirmation: password }
  	end
  	assert_template "users/show"
  end
end