# frozen_string_literal: true

class User::TopController < User::ApplicationController
  def index
    @latest = Article.all.limit(8)
    @pickups = Pickup.all
    @banners = Banner.all
    @series = Series.all
    @business = Article.by_category("business").limit(4)
    @career = Article.by_category("career").limit(4)
    @technology = Article.by_category("technology").limit(4)
    @finance = Article.by_category("finance").limit(4)
  end

  def about
    file = File.open Rails.root.join("app/assets/files/about.md")
    @markdown = ::MarkdownRenderer.md_to_html(file.read)
  end

  def terms; end

  def privacy
    file = File.open(Rails.root.join("app/assets/files/privacy.md"))
    @markdown = ::MarkdownRenderer.md_to_html(file.read)
  end
end
