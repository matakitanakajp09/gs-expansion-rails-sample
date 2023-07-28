# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  include Pagy::Backend
end
