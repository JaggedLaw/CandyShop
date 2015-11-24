Rails.application.routes.draw do

  resources :shops, only: [:index, :show]
  resources :items, only: [:index]

end
