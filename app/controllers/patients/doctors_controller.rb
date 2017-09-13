class Patients::DoctorsController < PatientsController
  before_action :authenticate_patient!

  def index
    @doctors = Doctor.all
  end

  def show
    @doctor = Doctor.find params[:id]
    @appointments = @doctor.appointments
  end
end