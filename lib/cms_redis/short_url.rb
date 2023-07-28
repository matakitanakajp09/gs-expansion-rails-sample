# frozen_string_literal: true

module CmsRedis
  class ShortUrl
    EXPIRES = 60 * 60 * 24
    CACHE_KEY = "short-url"

    def initialize(cache_key = "", expires = EXPIRES)
      @cache_key = cache_key
      @expires = expires
      @connection = ::CmsRedis::Core::Client.new(@cache_key, @expires)
    end

    def fetch
      @connection.fetch do
        []
      end
    end

    def cache?
      @connection.cache?
    end

    def set(hash)
      array = fetch
      array << hash
      @connection.set(array)
    end

    def del
      @connection.del
    end
  end
end
