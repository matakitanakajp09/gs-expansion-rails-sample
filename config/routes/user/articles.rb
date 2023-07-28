# frozen_string_literal: true

Rails.application.routes.draw do
  get "/articles/:id" => "user/articles#show", as: :article
end
