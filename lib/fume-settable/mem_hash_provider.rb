require 'active_support/concern'
require "hashie"

module Fume
module Settable
  module MemHashProvider
    extend ActiveSupport::Concern

    module ClassMethods
      def mem_hash_provider
        append_providers ProviderMemHash.new
      end
    end

    class ProviderMemHash
      def initialize
        @data = Hashie::Mash.new
      end

      def settings
        @data
      end
      
      def call(name, *args, &block)
        @data.send(name, *args, &block)
      end
    end
  end
end
end