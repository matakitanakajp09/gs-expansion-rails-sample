# frozen_string_literal: true

Rails.application.routes.draw do
  get '/artciles/:id' => 'user/articles#show', as: :article
end
