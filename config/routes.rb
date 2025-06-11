Rails.application.routes.draw do
  root "home#index"

  devise_for :users, skip: [:registrations], controllers: {
    sessions: "users/sessions"
  }

  resources :projects, only: [:index, :show] do
    member do
      post :update_status
      post :add_comment
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
