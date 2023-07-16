# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin, skip: :all
  devise_for :admin_database_authentications, path: :admin, class_name: "Admin::DatabaseAuthentication", controllers: {
    sessions: "admin/database_authentication/sessions"
  }
  devise_for :admin_registrations, class_name: "Admin::Registration", path: :admin, controllers: {
    confirmations: "admin/registrations"
  }
  devise_scope :admin_registration do
    post "admin/registration/finish", to: "admin/registrations#finish", as: "finish_admin_registration"
  end
  devise_for :admins
end
