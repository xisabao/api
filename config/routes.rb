require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :oregonlive, :only => [:index, :create]
      resources :pdx_monthly, only: [:create]
      resources :visit_seattle, only: [:create]
      resources :wine_country, only: [:create]
      resources :bellevue_reporter, only: [:create]
      resources :concierge_alliange, only: [:create]
      resources :great_northwest_wine, only: [:create]
      resources :seattle_pi, only: [:create]
      resources :seattle_times, only: [:create]
      resources :visit_corvallis, only: [:create]
      resources :test, :only => [:index, :create]
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
    end
  end

  resources :automation, only: [:create]
end
