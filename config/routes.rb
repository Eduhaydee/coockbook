Rails.application.routes.draw do
  root to: 'home#index'
  
  resources :recipes do
    get 'search', on: :collection
    member do
      post 'featured'
      post 'unfeatured'
    end
  end

  resources :recipe_types
  resources :cuisines
end
