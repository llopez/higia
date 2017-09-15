class Patients::AppointmentsSearcherController < PatientsController
  before_action :authenticate_patient!

  def index
    @doctors = Doctor.all

    if params[:doctor_id].present?
      @appointments = Appointment.where(doctor_id: params[:doctor_id])
    end
  end

end
