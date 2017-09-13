class Patients::DoctorsController < PatientsController
  def index
    @doctors = Doctor.all
  end

  def show
    @doctor = Doctor.find params[:id]
    @appointments = @doctor.appointments
  end
end