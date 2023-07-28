# frozen_string_literal: true

Rails.application.routes.draw do
  get "/l/:id" => "user/short_urls#show", as: :short_url
  get "/l/:id/click" => "user/short_urls#click", as: :click_short_url
end
