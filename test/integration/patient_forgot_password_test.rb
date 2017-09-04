require 'test_helper'

class PatientForgotPasswordTest < ActionDispatch::IntegrationTest
  test "success response" do
    get new_patient_password_path
    assert_response :success
  end

  test "email field" do
    get new_patient_password_path
    assert_select "input[type=email][name='patient[email]']"
  end

  test "sign up link" do
    get new_patient_password_path
    assert_select "a", "Sign up", new_patient_registration_path
  end

  test "log in link" do
    get new_patient_password_path
    assert_select "a", "Log in", new_patient_session_path
  end

  test "redirect to sign in" do
    patient = patients(:one)
    post patient_password_path, params: { 
      patient: {
        email: patient.email, 
      }
    }
    assert_response :redirect
    assert_redirected_to new_patient_session_path
  end

  test "password email sent" do
    patient = patients(:one)
    assert_difference('ActionMailer::Base.deliveries.size', 1) do
      post patient_password_path, params: { 
        patient: {
          email: patient.email, 
        }
      }
    end
    assert_equal patient.email, ActionMailer::Base.deliveries.last['to'].to_s
  end

  test "generate token" do
    patient = patients(:one)
    post patient_password_path, params: { 
      patient: {
        email: patient.email, 
      }
    }
    assert_not_nil patient.reload.reset_password_token
  end

  test "edit password form" do
    patient = patients(:one)
    get edit_patient_password_path(reset_password_token: "syrP4t1yQeEtxKLnEyqx" )
    assert_response :success
    assert_select "input[type=password][name='patient[password]']"
    assert_select "input[type=password][name='patient[password_confirmation]']"
    assert_select "input[type=hidden][name='patient[reset_password_token]']", value: "syrP4t1yQeEtxKLnEyqx" 
  end

=begin
  test "update password" do
    patient = patients(:with_token)

    put patient_password_path, params: {
      patient: {
        password: 'new_password',
        password_confirmation: 'new_password',
        reset_password_token: "rXdgGbRcHsPPvVB6LtNg"
      }
    }
    puts response.body
    assert_redirected_to edit_patient_registration_path
  end
=end
end
