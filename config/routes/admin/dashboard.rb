# frozen_string_literal: true

Rails.application.routes.draw do
  get "/admin" => "admin/dashboard#index", as: :admin_dashboard
end
