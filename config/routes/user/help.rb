# frozen_string_literal: true

Rails.application.routes.draw do
  get '/help' => 'user/help#index', as: :help
end
