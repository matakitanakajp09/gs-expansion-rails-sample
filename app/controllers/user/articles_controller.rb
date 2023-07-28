# frozen_string_literal: true

class User::ArticlesController < User::ApplicationController
  def show
    # preload, includes, eager_load
    @article = Article.preload(:author).find(params[:id])

    render "/user/error_404" and return unless @article.present?
  end
end
