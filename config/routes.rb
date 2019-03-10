Rails.application.routes.draw do
  root to: 'home#index'
  resources :recipes
  resources :recipe_types
  resources :cuisines
end
