require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :oregonlive, :only => [:index, :create]
      resources :test, :only => [:index, :create]
    end
  end
end
