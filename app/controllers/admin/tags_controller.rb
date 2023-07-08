# frozen_string_literal: true

class Admin::TagsController < Admin::ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(create_params)
    if @tag.save
      flash.now.notice = t("admin.create.success")
      redirect_to admin_tags_path
    else
      flash.now.alert = t("admin.create.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(update_params)
      flash.now.notice = t("admin.update.success")
      redirect_to admin_tag_path
    else
      flash.now.alert = t("admin.update.failed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:tag).permit(
      :name
    )
  end

  def update_params
    create_params
  end
end
