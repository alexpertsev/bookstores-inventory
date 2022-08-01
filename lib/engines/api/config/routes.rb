require 'api/version_constraint'

Api::Engine.routes.draw do
  scope module: :v1, constraints: Api::VersionConstraint.new(version: 1, default: true) do
    resource :bookstore_stock_level, only: [:show, :update, :create]
    resources :books, only: [:index, :destroy]
    resources :bookstores, only: [:index]
  end  
end
