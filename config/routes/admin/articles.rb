# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :articles
  end
end
