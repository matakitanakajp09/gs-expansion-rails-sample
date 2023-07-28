# frozen_string_literal: true

Rails.application.routes.draw do
  get "/l/:id" => "user/short_urls#show", as: :short_url
end
