require 'active_support/concern'

module Fume
module Settable
  module YamlProvider
    extend ActiveSupport::Concern

    module ClassMethods
      def yaml_provider(*files)
        append_providers ProviderYaml.new(*files)
      end
    end

    class ProviderYaml
      def initialize(*files)
        files = [ files ].flatten
        @data = {}
        files.each do |file|
          next if !File.exist?(file)
          content = YAML.load(File.read(file))
          @data = @data.deep_merge(content) if content
        end
      end
      
      def call(name)
        @data[name]
      end
    end
  end
end
end