# frozen_string_literal: true

# MEMO: 全体に関わるパスについて以下に記述する
Rails.application.routes.draw do
  direct :cdn_image do |model, options|
    expires_in = options.delete(:expires_in) { ActiveStorage.urls_expire_in }

    if model.respond_to?(:signed_id)
      route_for(
        :rails_service_blob_proxy,
        model.signed_id(expires_in: expires_in),
        model.filename,
        options.merge(host: "pub-d8167d0244bc47c6a3b1a2877c5b6a2e.r2.dev")
      )
    else
      signed_blob_id = model.blob.signed_id(expires_in: expires_in)
      variation_key  = model.variation.key
      filename       = model.blob.filename

      route_for(
        :rails_blob_representation_proxy,
        signed_blob_id,
        variation_key,
        filename,
        options.merge(host: ENV.fetch("CDN_HOST", nil))
      )
    end
  end

  mount LetterOpenerWeb::Engine => "/letter_opener" if Rails.env.development? || Rails.env.staging?

  get "*not_found" => "user/application#routing_error"
  post "*not_found" => "user/application#routing_error"
end

# == Route Map
#
