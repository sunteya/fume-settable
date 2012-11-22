require 'active_support/concern'
require "hashie"

module Fume
module Settable
  module RubyProvider
    extend ActiveSupport::Concern

    module ClassMethods
      def ruby_provider(*files)
        append_providers ProviderRuby.new(*files)
      end
    end

    class ProviderRuby
      def initialize(*files)
        files = [ files ].flatten
        @data = Hashie::Mash.new
        files.reverse.each do |file|
          next if !File.exist?(file)
          instance_eval File.read(file), file.to_s
        end
      end

      def settings
        @data
      end
      
      def call(name, *args, &block)
        @data[name]
      end
    end
  end
end
end