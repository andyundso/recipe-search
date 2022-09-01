Rails.application.routes.draw do
  resources :search, only: %i[index] do
    post :find, on: :collection
  end

  root "search#index"
end
