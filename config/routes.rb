Rails.application.routes.draw do
  devise_for :users

  root to: "rooms#index"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :rooms do
    resources :messages, only: [:create, :show]
  end
end
