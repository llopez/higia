require "rails_helper"

RSpec.feature "Doctor Sign Up", :type => :feature do
  context "empty email" do
    let(:data) do
      { email: '', license_number: '123456', password: 'password', password_confirmation: 'password'}
    end

    scenario "displays legend with errors count" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("1 errros prohibited this user from being saved")
    end

    scenario "displays legend with error message" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("email can't be blank")
    end
  end

  context "empty license_number" do
    let(:data) do
      { email: 'mike@example.com', license_number: '', password: 'password', password_confirmation: 'password'}
    end

    scenario "displays leyend with error message" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("license_number can't be blank")
    end

    scenario "displays leyend with error count" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("1 errros prohibited this user from being save")
    end
  end

  context "empty password" do
    let(:data) do
      { email: 'mike@example.com', license_number: '123456', password: '', password_confirmation: ''}
    end

    scenario "displays leyend with error message" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("password can't be blank")
    end

    scenario "displays leyend with error count" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("1 errros prohibited this user from being save")
    end
  end

  context "empty password_confirmation" do
    let(:data) do
      { email: 'mike@example.com', license_number: '123456', password: 'password', password_confirmation: ''}
    end

    scenario "displays leyend with error message" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("password_confirmation doesn't match Password")
    end

    scenario "displays leyend with error count" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("1 errros prohibited this user from being save")
    end
  end

  context "different password and password_confirmation" do
    let(:data) do
      { email: 'mike@example.com', license_number: '123456', password: 'password', password_confirmation: 'wrong'}
    end

    scenario "displays leyend with error message" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("password_confirmation doesn't match Password")
    end

    scenario "displays leyend with error count" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("1 errros prohibited this user from being save")
    end
  end

  context "valid data" do
    let(:data) do
      { email: 'mike@example.com', license_number: '123456', password: 'password', password_confirmation: 'password'}
    end

    scenario "displays leyend with welcome message" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"

      expect(page).to have_text("You have signed up successfully")
    end

    scenario "creates doctor" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      
      expect {
        click_button "Sign up"
      }.to change{ Doctor.count }.by(1) 
    end

    scenario "redirects to edit doctor page" do
      visit new_doctor_registration_path
      fill_in "Email", :with => data[:email]
      fill_in "License Number", :with => data[:license_number]
      fill_in "Password", :with => data[:password]
      fill_in "Password Confirmation", :with => data[:password_confirmation]
      click_button "Sign up"
      
      expect(current_path).to eq(edit_doctor_registration_path)
    end
  end
end