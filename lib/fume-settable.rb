module Fume
  module Settable
    VERSION = File.read(File.expand_path("../../VERSION", __FILE__)).chomp
  end
end

require File.expand_path('../fume-settable/base', __FILE__)