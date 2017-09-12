module ApplicationHelper
  def current_user
    current_patient || current_doctor
  end
end
