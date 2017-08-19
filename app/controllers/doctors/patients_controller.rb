class Doctors::PatientsController < DoctorsController
  before_action :authenticate_user!

  def index
    @users = User.all
  end
end