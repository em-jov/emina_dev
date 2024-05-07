Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"

  get '/auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: 'sessions#failure', via: [:get, :post]

  delete '/logout', to: 'sessions#destroy'

  resources :posts, param: :slug do
    member do
      patch :publish
      patch :draft
    end
    # patch '/posts/:slug/publish', to: "posts#private", as: 'private_post'
    # patch '/posts/:slug/draft', to: "posts#draft", as: 'draft_post'

  end
end
