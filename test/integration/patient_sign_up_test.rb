require 'test_helper'

class PatientSignUpTest < ActionDispatch::IntegrationTest
  test "success response" do
    get new_patient_registration_path
    assert_response :success
  end

  test "email field" do
    get new_patient_registration_path
    assert_select "input[type=email][name='patient[email]']"
  end

  test "password field" do
    get new_patient_registration_path
    assert_select "input[type=password][name='patient[password]']"
  end

  test "password_confirmation field" do
    get new_patient_registration_path
    assert_select "input[type=password][name='patient[password_confirmation]']"
  end

  test "log in link" do
    get new_patient_registration_path
    assert_select "a", "Log in", new_patient_session_path
  end 

  test "redirect to edit patient profile" do
    post patient_registration_path, params: { 
      patient: {
        email: 'luis@higia.com', 
        password: 'password', 
        password_confirmation: 'password'
      }
    }
    assert_response :redirect
    assert_redirected_to edit_patient_registration_path
  end

  test "render email errors" do
    post patient_registration_path, params: { 
      patient: {
        email: '', 
        password: 'password', 
        password_confirmation: 'password'
      }
    }
    assert_select "div.field_with_errors" do
      assert_select "input[name='patient[email]']"
    end
    assert_select "li", "email can't be blank"
  end

  test "render password errors" do
    post patient_registration_path, params: { 
      patient: {
        email: 'luis@higia.com', 
        password: '', 
        password_confirmation: 'password'
      }
    }
    assert_select "div.field_with_errors" do
      assert_select "input[name='patient[password]']"
    end
    assert_select "li", "password can't be blank"
  end

  test "render password_confirmation errors" do
    post patient_registration_path, params: { 
      patient: {
        email: 'luis@higia.com', 
        password: 'password', 
        password_confirmation: ''
      }
    }
    assert_select "div.field_with_errors" do
      assert_select "input[name='patient[password_confirmation]']"
    end
    assert_select "li", "password_confirmation doesn't match Password"
  end
end
