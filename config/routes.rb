require 'sidekiq/web'

Rails.application.routes.draw do
  root "dashboards#show"
  devise_for :admins, controllers: { sessions: 'admin/sessions' }
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users, only: [:show, :edit, :update]
  resources :posts, except: [:index] do
    resources :responses, only: [:create]
    resources :likes, only: [:create, :destroy], module: :posts
    resources :bookmarks, only: [:create, :destroy], module: :posts
  end

  resources :responses, only: [] do
    resources :likes, only: [:create, :destroy], module: :responses
    resources :bookmarks, only: [:create, :destroy], module: :responses
  end

  resources :tags, only: [:show]
  resources :relationships, only: [:create, :destroy]
  resources :interests, only: [:create, :destroy]
  get "me/bookmarks" => "dashboards#bookmarks", as: :dashboard_bookmarks
  get "top-stories" => "dashboards#top_stories", as: :top_stories
  get "search" => "search#show", as: :search
  get "autocomplete" => "search#autocomplete", as: :autocomplete

  namespace :admin do
    resource :dashboard, only: [:show]
    resources :featured_tags, only: [:create, :destroy]
  end

  namespace :api do
    resources :notifications, only: [:index] do
      collection do
        post :mark_as_read
      end
    end
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq' 
  end
end
