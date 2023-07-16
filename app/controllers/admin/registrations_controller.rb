# frozen_string_literal: true

class Admin::RegistrationsController < Devise::ConfirmationsController
  layout "admin/auth"

  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    registered = Admin::DatabaseAuthentication.where(email: params[:registration][:email]).exists?
    if registered
      flash[:error] = "Given email address is already registered."
      return render :new
    end
    admin_registration = Admin::Registration.find_or_initialize_by(unconfirmed_email: params[:registration][:email])
    if admin_registration.save
      Admin::DeviseMailer.confirmation_instructions(admin_registration).deliver_now
      flash[:notice] = "Sending an email confirmation instruction"
      redirect_to new_admin_database_authentication_session_path and return
    else
      respond_with(admin_registration)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    @admin = Admin.new
    @admin_database_authentication = Admin::DatabaseAuthentication.new
  end

  def finish
    admin_registration = Admin::Registration.confirm_by_token(params[:confirmation_token])
    ActiveRecord::Base.transaction do
      @admin = Admin.new(full_name: params[:full_name])
      @admin_database_authentication = Admin::DatabaseAuthentication.new(
        admin: @admin,
        email: admin_registration&.unconfirmed_email,
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
      @admin.save!
      @admin_database_authentication.save!
      admin_registration.destroy!
    end

    sign_in(:admin, @admin)
    sign_in(:database_authentication, @admin_database_authentication)

    redirect_to new_admin_database_authentication_session_path
  rescue StandardError
    render :show
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
