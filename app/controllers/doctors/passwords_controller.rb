class Doctors::PasswordsController < Devise::PasswordsController
  protected

  def after_resetting_password_path_for(resource)
    Devise.sign_in_after_reset_password ? edit_doctor_registration_path : new_doctor_session_path
  end
end
