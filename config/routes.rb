require 'sidekiq/web'

Rails.application.routes.draw do
  root "dashboards#show"
  devise_for :admins, controllers: { sessions: 'admin/sessions' }
  devise_for :users, controllers: { sessions: 'users/sessions', :omniauth_callbacks => "users/omniauth_callbacks" }
  get "sign_in" => "sessions#new", as: :social_sign_in

  resources :users, only: [:show, :edit, :update] do
    resources :recommended_posts, only: [:index]
  end

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

  get "me/bookmarks" => "dashboards#bookmarks", as: :dashboard_bookmarks
  get "top-stories" => "dashboards#top_stories", as: :top_stories
  get "me/stories/drafts" => "stories#drafts", as: :stories_drafts
  get "me/stories/public" => "stories#published", as: :stories_published
  get "search" => "search#show", as: :search
  
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

    get "autocomplete" => "search_autocomplete#index"

    resources :posts, only: [:create, :update, :destroy]
    resources :users, only: [:show]

    post    "relationships" => "relationships#create"
    delete  "relationships" => "relationships#destroy"
    post    "interests" => "interests#create"
    delete  "interests" => "interests#destroy"
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq' 
  end
end
