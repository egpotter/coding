# frozen_string_literal: true

Rails.application.routes.draw do
  resources :customers do
    resources :contracts
  end

  post "/contracts", to: 'contracts#bulk_create'
end
