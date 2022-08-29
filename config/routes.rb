Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :reservations
    post "/signup", to: "users#create"
    post "/login", to: "sessions#create"
    get "/authorized", to: "sessions#show"

    namespace :api, defaults: {format: 'json'} do
        namespace :v1 do
          resources :rooms, only: [:index, :create, :show, :update, :destroy] do
            get :image, on: :member
          end
          resources :reservations, only: [:index, :create]
        end
    end
end
