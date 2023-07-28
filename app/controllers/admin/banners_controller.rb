# frozen_string_literal: true

class Admin::BannersController < Admin::ApplicationController
  def index
    @q = Banner.ransack(params[:q])
    @pagy, @banners = pagy(@q.result(distinct: true))
  end

  def show
    @banner = Banner.find(params[:id])
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(create_params)
    if @banner.save
      flash.now.notice = t("admin.create.success")
      redirect_to admin_banners_path
    else
      flash.now.alert = t("admin.create.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @banner = Banner.find(params[:id])
  end

  def update
    @banner = Banner.find(params[:id])
    if @banner.update(update_params)
      flash.now.notice = t("admin.update.success")
      redirect_to admin_banner_path
    else
      flash.now.alert = t("admin.update.failed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:banner).permit(
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
