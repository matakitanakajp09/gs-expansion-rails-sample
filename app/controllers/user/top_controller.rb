# frozen_string_literal: true

class User::TopController < User::ApplicationController
  def index; end

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
