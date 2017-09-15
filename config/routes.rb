Rails.application.routes.draw do
  devise_for :users

  devise_for :doctors, controllers: {
    registrations: 'doctors/registrations',
    sessions: 'doctors/sessions',
    passwords: 'doctors/passwords'
  }

  devise_for :patients, controllers: {
    registrations: 'patients/registrations',
    sessions: 'patients/sessions',
    passwords: 'patients/passwords'
  } 

  devise_scope :patient do
    root to: 'patients/sessions#new'
  end

  get 'patients/doctors' => 'patients/doctors#index', as: :patients_doctors
  get 'patients/doctors/:id' => 'patients/doctors#show', as: :patients_doctor
  patch 'patients/appointments/:id/book' => 'patients/appointments#book', as: :book_patients_appointment
  patch 'patients/appointments/:id/cancel' => 'patients/appointments#cancel', as: :cancel_patients_appointment

  get 'patients/appointments' => 'patients/appointments#index', as: :patients_appointments


  get 'patients/appointments_searcher' => 'patients/appointments_searcher#index', as: :patients_appointments_searcher
  
  get 'doctors/appointments' => 'doctors/appointments#index', as: :doctors_appointments
  patch 'doctors/appointments/:id/cancel' => 'doctors/appointments#cancel', as: :cancel_doctors_appointment
  post 'doctors/appointments' => 'doctors/appointments#create'
  get 'doctors/appointments/new' => 'doctors/appointments#new', as: :new_doctors_appointment
  delete 'doctors/appointments/:id' => 'doctors/appointments#destroy', as: :doctors_appointment
end
