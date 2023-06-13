# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  layout "admin"

  include Pagy::Backend
end
