# frozen_string_literal: true

class Admin::CategoriesController < Admin::ApplicationController
  def index
    @q = Category.ransack(params[:q])
    @pagy, @categories = pagy(@q.result(distinct: true))
  end

  def show
    @category = Category.includes(:articles).find(params[:id])
    articles = @category&.articles
    @pagy, @articles = pagy(articles)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(create_params)
    if @category.save
      flash.now.notice = t("admin.create.success")
      redirect_to admin_categories_path
    else
      flash.now.alert = t("admin.create.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(update_params)
      flash.now.notice = t("admin.update.success")
      redirect_to admin_category_path
    else
      flash.now.alert = t("admin.update.failed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:category).permit(
      :name
    )
  end

  def update_params
    create_params
  end
end
