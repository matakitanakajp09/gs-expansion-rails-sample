# frozen_string_literal: true

class User::SeriesController < User::ApplicationController
  def index
    @series = Series.all
  end

  def show
    @series = Series.includes(:articles).find(params[:id])
  end
end
