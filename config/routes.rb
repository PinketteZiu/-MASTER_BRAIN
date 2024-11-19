Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home", as: :home

  resources :brains, except: [:update, :edit] do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:show]

  # namespace :account do
  #   resources :bookings, only: [:index]
  #   resources :offers, only: [:index]
  # end

  get "my_account", to: "pages#my_account"

  # get "my_account", to: "bookings#my_account" do
  #   resources :bookings, only: [:show]
  # end
end
