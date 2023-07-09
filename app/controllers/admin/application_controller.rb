# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  layout "admin"

  include Pagy::Backend

  # before_action do
  #   ActiveStorage::Current.host = "localhost"
  # end
end
