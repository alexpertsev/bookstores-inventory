Rails.application.routes.draw do  
  root to: "bookstores#index"
  
  resources :bookstores, only: [:index, :show]

  mount Api::Engine => '/api'
end


