class Patients::ProfileController < PatientsController
  before_action :authenticate_user!

  def show
    @user = current_user
  end
end
