Dir["#{File.dirname(__FILE__)}/helpers/*.rb"].each &method(:require)

module Retrospect
  module Helpers
    include Rendering
    include Urls
    include Resources

    include Rack::Utils
    alias :h :escape_html
  end
end
