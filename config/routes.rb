Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :brains, except: [:update, :edit]
  resources :bookings, only: [:new, :create]
end
