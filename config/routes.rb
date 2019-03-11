Rails.application.routes.draw do
  devise_for :users
  
  root to: 'home#index'
  
  resources :recipes do
    get 'search', on: :collection
    get 'my-recipes', on: :collection
    member do
      post 'featured'
      post 'unfeatured'
    end
  end

  resources :recipe_types
  resources :cuisines
end
