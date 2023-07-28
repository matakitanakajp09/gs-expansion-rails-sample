# frozen_string_literal: true

namespace :short_url do
  desc "Insert short_url_tracking data from redis cache"
  task insert: :environment do |task|
    start_message = "#### START: #{task&.name}. ####"
    puts start_message
    Rails.logger.info start_message
    ShortUrlTracking.import_all!
    end_message = "#### END: #{task&.name}. ####"
    puts end_message
    Rails.logger.info end_message
  end
end
