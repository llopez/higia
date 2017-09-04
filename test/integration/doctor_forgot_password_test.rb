require 'test_helper'

class DoctorForgotPasswordTest < ActionDispatch::IntegrationTest
  test "success response" do
    get new_doctor_password_path
    assert_response :success
  end

  test "email field" do
    get new_doctor_password_path
    assert_select "input[type=email][name='doctor[email]']"
  end

  test "sign up link" do
    get new_doctor_password_path
    assert_select "a", "Sign up", new_doctor_registration_path
  end

  test "log in link" do
    get new_doctor_password_path
    assert_select "a", "Log in", new_doctor_session_path
  end

  test "redirect to sign in" do
    doctor = doctors(:one)
    post doctor_password_path, params: { 
      doctor: {
        email: doctor.email, 
      }
    }
    assert_response :redirect
    assert_redirected_to new_doctor_session_path
  end

  test "password email sent" do
    doctor = doctors(:one)
    assert_difference('ActionMailer::Base.deliveries.size', 1) do
      post doctor_password_path, params: { 
        doctor: {
          email: doctor.email, 
        }
      }
    end
    assert_equal doctor.email, ActionMailer::Base.deliveries.last['to'].to_s
  end
end
