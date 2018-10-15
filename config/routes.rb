Rails.application.routes.draw do
  devise_for :users

  get 'events/index'
  get '/search', to: 'events#search', as: 'search_button'
  resources :events
  root 'events#index'
  get 'tags/:tag', to: 'events#index', as: :tag
end
