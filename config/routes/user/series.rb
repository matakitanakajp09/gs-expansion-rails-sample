# frozen_string_literal: true

Rails.application.routes.draw do
  get "/series" => "user/series#index", as: :user_series_index
  get "/series/:id" => "user/series#show", as: :user_series
end
