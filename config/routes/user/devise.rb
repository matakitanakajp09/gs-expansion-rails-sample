# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :user, skip: :all
  devise_for :user_database_authentications, class_name: "User::DatabaseAuthentication", path: :user, controllers: {
    sessions: "user/database_authentication/sessions"
  }
  devise_for :user_registrations, class_name: "User::Registration", path: :user, controllers: {
    confirmations: "user/registrations"
  }
  devise_scope :user_registration do
    post "/registration/finish", to: "user/registrations#finish", as: "finish_user_registration"
  end
  devise_for :users
end
