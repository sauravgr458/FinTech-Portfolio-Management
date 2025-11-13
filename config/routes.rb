Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "contacts#index"
  resources :contacts, only: [ :index, :show ] do
    member do
      get :preview_template
      post :send_template
    end
  end

  resources :email_templates do
    member do
      get :preview
    end
  end
end
