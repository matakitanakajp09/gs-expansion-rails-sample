# frozen_string_literal: true

Rails.application.routes.draw do
  get "/category" => "user/category#index", as: :user_categories
  get "/category/:id" => "user/category#show", as: :user_category
end
