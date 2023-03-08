Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: proc { [200, {}, ['success']] }
  namespace :api do
    namespace :v1 do
      resources :alerts, only: [:create]
    end
  end
  match '*unmatched', to: 'application#no_matching_route', via: :all
end
