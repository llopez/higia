Rails.application.routes.draw do
  devise_for :users
  get 'patients/profile' => 'patients/profile#show', as: :profile
  get 'doctors/patients' => 'doctors/patients#index', as: :patients

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
