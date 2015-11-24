Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]

  resources :subs do
    resources :posts, only: [:index, :new]
  end
  resources :posts, except: :index do
    resources :comments, only: [:new, :show, :create]
  end

  resources :comments, only: [:show, :create]

  root :to => "users#new"
end
