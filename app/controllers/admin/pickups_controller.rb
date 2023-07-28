# frozen_string_literal: true

class Admin::PickupsController < Admin::ApplicationController
  def index
    @q = Pickup.ransack(params[:q])
    @pagy, @pickups = pagy(@q.result(distinct: true))
  end

  def show
    @pickup = Pickup.find(params[:id])
  end

  def new
    @pickup = Pickup.new
  end

  def create
    @pickup = Pickup.new(create_params)
    if @pickup.save
      flash.now.notice = t("admin.create.success")
      redirect_to admin_pickups_path
    else
      flash.now.alert = t("admin.create.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pickup = Pickup.find(params[:id])
  end

  def update
    @pickup = Pickup.find(params[:id])
    if @pickup.update(update_params)
      flash.now.notice = t("admin.update.success")
      redirect_to admin_pickup_path
    else
      flash.now.alert = t("admin.update.failed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:pickup).permit(
      :name,
      :started_at,
      :expired_at,
      :thumbnail
    )
  end

  def update_params
    create_params
  end
end
