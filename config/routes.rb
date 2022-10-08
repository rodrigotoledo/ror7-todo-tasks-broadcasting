# frozen_string_literal: true

Rails.application.routes.draw do
  resources :todos
  root to: 'todos#index'
  devise_for :users

  namespace :api do
    resources :todos, only: %i[index update destroy create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
