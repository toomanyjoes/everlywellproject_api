Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :users, only: [:index, :show, :create] do
      resources :friends, only: [:index, :create, :destroy]
      resources :userdata, only: [:index, :create, :destroy]
      resources :expert_search, only: [:index]
    end
end
