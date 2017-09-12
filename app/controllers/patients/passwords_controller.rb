class Patients::PasswordsController < Devise::PasswordsController
  layout 'box'
  protected

  def after_resetting_password_path_for(resource)
    Devise.sign_in_after_reset_password ? edit_patient_registration_path : new_patient_session_path
  end
end
