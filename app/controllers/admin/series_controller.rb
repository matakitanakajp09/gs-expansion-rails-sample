# frozen_string_literal: true

class Admin::SeriesController < Admin::ApplicationController
  def index
    params[:q] = {} unless params[:q].present?
    params[:tab] = "all" unless params[:tab].present?
    @q = Series.ransack(params[:q])
    @pagy, @series = pagy(@q.result(distinct: true))
  end

  def show
    @series = Series.includes(:articles).find(params[:id])
    articles = @series.articles
    @pagy, @articles = pagy(articles)
  end

  def new
    @series = Series.new
  end

  def create
    @series = Series.new(create_params)
    if @series.save
      flash[:success] = t "admin.create.success"
      redirect_to admin_series_path(id: @series&.id) and return
    else
      flash.now[:danger] = t "admin.create.failed"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @series = Series.find(params[:id])
  end

  def update
    @series = Series.find(params[:id])
    @series.assign_attributes(update_params)
    if @series.save
      flash[:success] = t "admin.update.success"
      redirect_to admin_series_path(id: @series&.id) and return
    else
      flash.now[:danger] = t "admin.update.failed"
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_status
    @series = Series.find(params[:id])
  end

  def update_status
    @series = Series.find(params[:id])
    @series.assign_attributes(update_params)
    if @series.save
      flash[:success] = t "admin.update.success"
      redirect_to admin_series_path(id: @series&.id) and return
    else
      flash[:danger] = t "admin.update.failed"
      redirect_to edit_status_admin_series_index_path(id: @series&.id) and return
    end
  end

  def reserving_publish
    @series = Series.find(params[:id])
  end

  def reserved_publish
    @series = Series.find(params[:id])
    @series.assign_attributes(update_params)
    if @series.save
      flash[:success] = t "admin.update.success"
      redirect_to admin_series_path(id: @series&.id) and return
    else
      flash[:danger] = t "admin.update.failed"
      redirect_to reserving_publish_admin_series_index_path(id: @series&.id) and return
    end
  end

  def edit_order
    @series = Series.includes(:articles).find(params[:id])
    @articles = @series.articles
    return unless @articles.size < 2

    flash[:danger] = "並べ替え対象の連載が見つかりませんでした(公開中が2つ以上)"
    redirect_to admin_series_path(id: @series&.id) and return
  end

  def update_order
    @series = Series.find(params[:id])
    article_ids = order_params[:order_ids]
    article_series = ArticleSeries.where(article_id: article_ids).in_order_of(:article_id, article_ids)
    if ArticleSeries.update_position!(article_series)
      flash[:success] = t "admin.update.success"
      redirect_to admin_series_path(id: @series&.id) and return
    else
      flash[:danger] = t "admin.update.failed"
      redirect_to edit_order_admin_series_indexs_path(id: @series&.id) and return
    end
  end

  def edit_series_order
    @series = Series.published
    return unless @series.size < 2

    flash[:danger] = "並べ替え対象の連載が見つかりませんでした(公開中が2つ以上)"
    redirect_to admin_series_index_path and return
  end

  def update_series_order
    series_ids = order_params[:order_ids]
    series = Series.where(id: series_ids).in_order_of(:id, series_ids)
    if Series.update_position!(series)
      flash[:success] = t "admin.update.success"
      redirect_to admin_series_path and return
    else
      @series = Series.published
      flash[:danger] = t "admin.update.failed"
      redirect_to edit_series_order_admin_series_index_path and return
    end
  end

  private

  def create_params
    params.require(:series).permit(
      :title,
      :subtitle,
      :current_status,
      :scheduled_published_at,
      :thumbnail
    )
  end

  def update_params
    create_params
  end

  def order_params
    params.require(:series).permit(
      order_ids: []
    )
  end
end
