# frozen_string_literal: true

class Admin::ArticlesController < Admin::ApplicationController
  def index
    params[:q] = {} unless params[:q].present?
    params[:tab] = "all" unless params[:tab].present?
    params[:q][:category_type_eq] = params[:tab] unless params[:tab] == "all"
    @q = Article.ransack(params[:q])
    @q.sorts = "created_at desc" if @q.sorts.empty?
    @pagy, @articles = pagy(@q.result(distinct: true))
  end

  def new
    @categories = Category.all
    @authors = Author.all
    @tags = Tag.all
    @article = Article.new
    @article.build_article_series
  end

  def create
    @authors = Author.all
    @article = Article.new(create_params)
    if @article.save
      flash.now.notice = t("admin.create.success")
      redirect_to admin_articles_path
    else
      flash.now.alert = t("admin.create.failed")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @article = Article.includes(:category, :author, :series, :tags).find(params[:id])
    @category = @article&.category
    @author = @article&.author
    @series = [@article&.series].compact # admin/series/index_tableを使いまわしたいので、ここで配列にしてる
    @tags = @article&.tags
  end

  def edit
    @categories = Category.all
    @authors = Author.all
    @article = Article.find(params[:id])
    @article.build_article_series unless @article.article_series.present?
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(update_params)
      flash.now.notice = t("admin.update.success")
      redirect_to admin_article_path
    else
      @categories = Category.all
      @authors = Author.all
      flash.now.alert = t("admin.update.failed")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:article).permit(
      :current_status,
      :title,
      :subtitle,
      :thumbnail,
      :published_at,
      :content,
      :category_id,
      :author_id,
      tag_ids: [],
      article_series_attributes: %i[id series_id]
    )
  end

  def update_params
    create_params
  end
end
