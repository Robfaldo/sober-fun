Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'event_listings/index'

  resources :events
  
  root 'event_listings#index'
end
