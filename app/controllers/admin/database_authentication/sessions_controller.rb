# frozen_string_literal: true

class Admin::DatabaseAuthentication::SessionsController < Devise::SessionsController
  layout "admin/auth"
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |resource|
      sign_in(:admin, resource.admin)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
  end

  def after_sign_in_path_for(_resource)
    admin_dashboard_path
  end

  def after_sign_out_path_for(_resource)
    new_admin_database_authentication_session_path
  end
end
