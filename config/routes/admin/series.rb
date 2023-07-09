# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :series do
      collection do
        get "/:id/edit_status" => "series#edit_status", as: :edit_status
        match "/:id/update_status" => "series#update_status", via: %i[put patch], as: :update_status
        get "/:id/reserving_publish" => "series#reserving_publish", as: :reserving_publish
        match "/:id/reserved_publish" => "series#reserved_publish", via: %i[put patch], as: :reserved_publish
        get "/:id/edit_order" => "series#edit_order", as: :edit_order
        match "/:id/update_order" => "series#update_order", via: %i[put patch], as: :update_order
        get "/edit_series_order" => "series#edit_series_order", as: :edit_series_order
        match "/update_series_order" => "series#update_series_order", via: %i[put patch], as: :update_series_order
      end
    end
  end
end
