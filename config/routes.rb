Rails.application.routes.draw do
  root to: "welcomes#index"
  devise_for :users

  resources :products do
    resources :comments
  end
  resources :cart_items
  get "carts/show"

  resources :orders do
    member do
      post 'assign_copen'
      post 'payment'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
