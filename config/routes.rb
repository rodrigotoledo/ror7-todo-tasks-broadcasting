# frozen_string_literal: true

Rails.application.routes.draw do
  get '/home', to: 'pages#home'
  get '/signup', to: 'pages#signup'
  get '/login', to: 'pages#login'

  post '/login', to: 'pages#login'
  post '/logout', to: 'pages#logout'
  post '/signup', to: 'pages#signup'

  resources :todos
  root 'todos#index'
  devise_for :users

  namespace :api do
    resources :todos, only: %i[index update destroy create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
