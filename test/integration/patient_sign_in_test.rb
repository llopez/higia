require 'test_helper'

class PatientSignInTest < ActionDispatch::IntegrationTest
  test "success response" do
    get new_patient_session_path
    assert_response :success
  end

  test "email field" do
    get new_patient_session_path
    assert_select "input[type=email][name='patient[email]']"
  end

  test "password field" do
    get new_patient_session_path
    assert_select "input[type=password][name='patient[password]']"
  end

  test "sign up link" do
    get new_patient_session_path
    assert_select "a", "Sign up", new_patient_registration_path
  end

  test "forgot password link" do
    get new_patient_session_path
    assert_select "a", "Forgot your password?", new_patient_password_path
  end

  test "redirect to patient edit profile" do
    patient = patients(:one)
    post patient_session_path, params: { 
      patient: {
        email: patient.email, 
        password: 'password', 
      }
    }
    assert_response :redirect
    assert_redirected_to edit_patient_registration_path
  end

  test "sign in errors" do
    patient = patients(:one)
    post patient_session_path, params: { 
      patient: {
        email: patient.email, 
        password: 'wrong', 
      }
    }
    assert_select "div", "Invalid Email or password."
  end
end
