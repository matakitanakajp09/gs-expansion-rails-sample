# frozen_string_literal: true

class Admin::AuthorsController < Admin::ApplicationController
  def index
    @q = Author.ransack(params[:q])
    @pagy, @authors = pagy(@q.result(distinct: true))
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(create_params)
    if @author.save
      flash.now.notice = t("admin.create.success")
      redirect_to admin_authors_path
    else
      flash.now.alert = t("admin.create.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(update_params)
      flash.now.notice = t("admin.update.success")
      redirect_to admin_author_path
    else
      flash.now.alert = t("admin.update.failed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:author).permit(
      :name,
      :bio
    )
  end

  def update_params
    create_params
  end
end
