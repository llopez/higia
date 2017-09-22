require "rails_helper"

RSpec.feature "Doctor Appointment Creation", :type => :feature do
  fixtures :doctors

  scenario "creates appointment" do
    doctor = doctors(:one)

    visit new_doctor_session_path
    
    fill_in "Email", :with => doctor.email
    fill_in "Password", :with => "password"
    click_button "Sign in"
    click_link "Listado de Turnos"
    click_link "Nuevo Turno"

    save_and_open_page


    fill_in "date", :with => "22/02/1984 10:00:00"

    #expect(page).to have_text("Invalid Email or password")
  end
end