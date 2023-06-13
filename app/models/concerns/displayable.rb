# frozen_string_literal: true

module Displayable
  extend ActiveSupport::Concern

  def open?
    now = Time.current
    started_at <= now && now <= expired_at
  end

  def display_css_class
    return "open" if open?
    return "before" if Time.current <= started_at

    "after"
  end
end
