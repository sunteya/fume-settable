require File.expand_path('../ruby_provider', __FILE__)
require File.expand_path('../yaml_provider', __FILE__)
require File.expand_path('../mem_hash_provider', __FILE__)

module Fume
  module Settable
    class Base
      include YamlProvider
      include RubyProvider
      include MemHashProvider
      
      class_attribute :providers
      self.providers = []

      def self.fetch(name, *args, &block)
        (self.providers || []).each do |provider|
          value = provider.call(name.to_s, *args, &block)
          return value if !value.nil?
        end
        nil
      end

      def self.settings
        @proxy ||= Proxy.new(&self.method(:fetch))
      end
      
      def self.append_providers(*providers, &block)
        providers = [ providers, block ].compact.flatten
        
        providers.each do |provider|
          if provider.respond_to? :call
            self.providers << provider
          else
            self.providers << ->(name) { send(provider, name) }
          end
        end
      end

      class Proxy
        def initialize(&block)
          @callback = block
        end

        def [](name)
          @callback.call(name)
        end
        
        def []=(name, *args, &block)
          @callback.call("#{name}=", *args, &block)
        end

        def method_missing(name, *args, &block)
          @callback.call(name, *args, &block)
        end
      end
    end
  end
end
