Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :decks do
    resources :cards, only: %i[index create]
  end

  resources :cards, only: %i[show update destroy] do
    resources :reviews, controller: "card_reviews", only: %i[index create]
  end

  resources :card_reviews, only: :show
end
