# frozen_string_literal: true

class User::CategoryController < User::ApplicationController
  def index; end

  def show
    @category = Category.includes(:articles).find_by_name(params[:id])
    @pagy, @articles = pagy(@category&.articles)
  end
end
