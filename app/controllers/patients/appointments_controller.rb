class Patients::AppointmentsController < PatientsController
  before_action :authenticate_patient!

  def index
    @appointments = current_patient.appointments
  end

  def book
    @appointment = Appointment.find params[:id]
    if @appointment.update_attribute(:patient, current_patient)
      flash[:notice] = "Appointment successfully updated"
    else
      flash[:alert] = "Appointment wasn't updated"
    end
    redirect_to patients_appointments_path
  end

  def cancel
    @appointment = Appointment.find params[:id]
    if @appointment.update_attribute(:patient, nil)
      flash[:notice] = "Appointment successfully updated"
    else
      flash[:alert] = "Appointment wasn't updated"
    end
    redirect_to patients_appointments_path
  end
end
