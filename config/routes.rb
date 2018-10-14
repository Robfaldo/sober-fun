Rails.application.routes.draw do
  devise_for :users

  get 'events/index'
  resources :events
  root 'events#index'
  get 'tags/:tag', to: 'events#index', as: :tag
end
