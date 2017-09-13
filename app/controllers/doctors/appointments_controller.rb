class Doctors::AppointmentsController < DoctorsController
  before_action :authenticate_doctor!
  
  def index
    @appointments = current_doctor.appointments
  end

  def cancel
    @appointment = Appointment.find params[:id]
    if @appointment.update_attribute(:patient, nil)
      flash[:notice] = "Appointment successfully updated"
    else
      flash[:alert] = "Appointment wasn't updated"
    end
    redirect_to doctors_appointments_path
  end

  def new
    @appointment = current_doctor.appointments.build
  end

  def create
    @appointment = current_doctor.appointments.build appointment_params
    if @appointment.save
      flash[:notice] = "Appointment successfully created"
      redirect_to doctors_appointments_path
    else
      render :new
    end
  end

  def destroy
    @appointment = Appointment.find params[:id]
    if @appointment.destroy
      flash[:notice] = "Appointment successfully removed"
    else
      flash[:alert] = "Appointment wasn't removed"
    end
    redirect_to doctors_appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date)
  end
end