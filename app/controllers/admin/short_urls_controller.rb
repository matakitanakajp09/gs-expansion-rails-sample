# frozen_string_literal: true

class Admin::ShortUrlsController < Admin::ApplicationController
  def index
    @short_urls = ShortUrl.all
  end

  def show
    @short_url = ShortUrl.find(params[:id])
  end

  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.new(create_params)
    if @short_url.save
      flash.now.notice = t("admin.create.success")
      redirect_to admin_short_urls_path
    else
      flash.now.alert = t("admin.create.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @short_url = ShortUrl.find(params[:id])
  end

  def update
    @short_url = ShortUrl.find(params[:id])
    if @short_url.update(update_params)
      flash.now.notice = t("admin.update.success")
      redirect_to admin_short_url_path
    else
      flash.now.alert = t("admin.update.failed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:short_url).permit(
      :admin_id,
      :label_name,
      :original_url,
      :utm_source,
      :utm_medium,
      :utm_campaign
    )
  end

  def update_params
    create_params
  end
end
