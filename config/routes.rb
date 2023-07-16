# frozen_string_literal: true

# MEMO: 全体に関わるパスについて以下に記述する
Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development? || Rails.env.staging?

  # get "*not_found" => "user/application#routing_error"
  # post "*not_found" => "user/application#routing_error"
end

# == Route Map
#
