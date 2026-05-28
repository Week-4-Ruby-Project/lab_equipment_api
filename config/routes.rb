Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      resources :equipment, only: [:index, :show, :create, :update, :destroy] do
        resources :maintenance_records, only: [:index, :create]
      end
    end
  end
end
