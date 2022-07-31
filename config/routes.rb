Rails.application.routes.draw do  
  root to: "pages#home"
  
  resources :bookstores, only: [:index, :show]
end


