# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :short_urls
  end
end
