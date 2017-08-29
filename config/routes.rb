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
end
