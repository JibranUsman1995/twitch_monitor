Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :callbacks, only: [] do
    collection do
      get :streamlabs
    end
  end
end
