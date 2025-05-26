require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create user with valid parameters" do
    assert_difference("User.count") do
      post registrations_url, params: { 
        user: { 
          email_address: "newuser@example.com", 
          password: "password123", 
          password_confirmation: "password123" 
        } 
      }
    end

    assert_redirected_to root_url
    assert_equal "Welcome! Your account has been created.", flash[:notice]
  end

  test "should not create user with invalid parameters" do
    assert_no_difference("User.count") do
      post registrations_url, params: { 
        user: { 
          email_address: "", 
          password: "password123", 
          password_confirmation: "different" 
        } 
      }
    end

    assert_response :unprocessable_entity
  end

  test "should not create user with duplicate email" do
    # Use existing user from fixtures
    existing_user = users(:one)
    
    assert_no_difference("User.count") do
      post registrations_url, params: { 
        user: { 
          email_address: existing_user.email_address, 
          password: "password123", 
          password_confirmation: "password123" 
        } 
      }
    end

    assert_response :unprocessable_entity
  end
end