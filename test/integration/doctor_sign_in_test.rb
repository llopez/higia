require 'test_helper'

class DoctorSignInTest < ActionDispatch::IntegrationTest
  test "success response" do
    get new_doctor_session_path
    assert_response :success
  end

  test "email field" do
    get new_doctor_session_path
    assert_select "input[type=email][name='doctor[email]']"
  end

  test "password field" do
    get new_doctor_session_path
    assert_select "input[type=password][name='doctor[password]']"
  end

  test "sign up link" do
    get new_doctor_session_path
    assert_select "a", "Sign up", new_doctor_registration_path
  end

  test "forgot password link" do
    get new_doctor_session_path
    assert_select "a", "Forgot your password?", new_doctor_password_path
  end

  test "redirect to doctor edit profile" do
    doctor = doctors(:one)
    post doctor_session_path, params: { 
      doctor: {
        email: doctor.email, 
        password: 'password', 
      }
    }
    assert_response :redirect
    assert_redirected_to edit_doctor_registration_path
  end

  test "sign in errors" do
    doctor = doctors(:one)
    post doctor_session_path, params: { 
      doctor: {
        email: doctor.email, 
        password: 'wrong', 
      }
    }
    assert_select "div", "Invalid Email or password."
  end
end
