require "rails_helper"

RSpec.feature "Doctor Sign In", :type => :feature do
  fixtures :doctors

  scenario "wrong email" do
    visit new_doctor_session_path

    fill_in "Email", :with => "wrong"
    fill_in "Password", :with => "password" 
    click_button "Sign in"

    expect(page).to have_text("Invalid Email or password")
  end

  scenario "wrong password" do
    visit new_doctor_session_path

    fill_in "Email", :with => doctors(:one).email
    fill_in "Password", :with => "wrong" 
    click_button "Sign in"

    expect(page).to have_text("Invalid Email or password")
  end

  scenario "valid email and password" do
    visit new_doctor_session_path

    fill_in "Email", :with => doctors(:one).email
    fill_in "Password", :with => "password" 
    click_button "Sign in"

    expect(page).to have_text("Signed in successfully")
  end
end