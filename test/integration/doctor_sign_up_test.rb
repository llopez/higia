require 'test_helper'

class DoctorSignUpTest < ActionDispatch::IntegrationTest
  test "success response" do
    get new_doctor_registration_path
    assert_response :success
  end

  test "email field" do
    get new_doctor_registration_path
    assert_select "input[type=email][name='doctor[email]']"
  end

  test "license_number field" do
    get new_doctor_registration_path
    assert_select "input[type=text][name='doctor[license_number]']"
  end

  test "password field" do
    get new_doctor_registration_path
    assert_select "input[type=password][name='doctor[password]']"
  end

  test "password_confirmation field" do
    get new_doctor_registration_path
    assert_select "input[type=password][name='doctor[password_confirmation]']"
  end

  test "log in link" do
    get new_doctor_registration_path
    assert_select "a", "Log in", new_doctor_session_path
  end 

  test "redirect to edit doctor profile" do
    post doctor_registration_path, params: { 
      doctor: {
        email: 'luis@higia.com', 
        license_number: '1234', 
        password: 'password', 
        password_confirmation: 'password'
      }
    }
    assert_response :redirect
    assert_redirected_to edit_doctor_registration_path
  end

  test "render license_number errors" do
    post doctor_registration_path, params: { 
      doctor: {
        email: 'luis@higia.com', 
        license_number: '', 
        password: 'password', 
        password_confirmation: 'password'
      }
    }
    assert_select "div.field_with_errors" do
      assert_select "input[name='doctor[license_number]']"
    end
    assert_select "li", "license_number can't be blank"
  end

  test "render email errors" do
    post doctor_registration_path, params: { 
      doctor: {
        email: '', 
        license_number: '1234', 
        password: 'password', 
        password_confirmation: 'password'
      }
    }
    assert_select "div.field_with_errors" do
      assert_select "input[name='doctor[email]']"
    end
    assert_select "li", "email can't be blank"
  end

  test "render password errors" do
    post doctor_registration_path, params: { 
      doctor: {
        email: 'luis@higia.com', 
        license_number: '1234', 
        password: '', 
        password_confirmation: 'password'
      }
    }
    assert_select "div.field_with_errors" do
      assert_select "input[name='doctor[password]']"
    end
    assert_select "li", "password can't be blank"
  end

  test "render password_confirmation errors" do
    post doctor_registration_path, params: { 
      doctor: {
        email: 'luis@higia.com', 
        license_number: '1234', 
        password: 'password', 
        password_confirmation: ''
      }
    }
    assert_select "div.field_with_errors" do
      assert_select "input[name='doctor[password_confirmation]']"
    end
    assert_select "li", "password_confirmation doesn't match Password"
  end
end
