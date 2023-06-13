# frozen_string_literal: true

Rails.application.routes.draw do
  get "/" => "user/top#index", as: :user_top
  get "/premium" => "user/top#premium", as: :premium
  get "/about" => "user/top#about", as: :about
  get "/terms" => "user/top#terms", as: :terms
  get "/privacy" => "user/top#privacy", as: :privacy
end
