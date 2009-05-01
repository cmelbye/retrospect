module Retrospect
  module Helpers
    module Rendering
      def stylesheets(*sheets)
        sheets.each { |sheet|
          haml_tag(:link, :href => root_path("#{sheet}.css"), 
            :type => "text/css", :rel => "stylesheet")
        }
      end
      
      def stylesheet_hash
        @_hash ||= Digest::MD5.file("/Users/charlie/Developer/retrospect/views/retrospect.sass").hexdigest
      end
      
      def show(view, options = {})
        @title = options[:title]
        @title = [@title] if !@title.is_a?(Array)
        haml view
      end
      
      def errors_on(object, field)
        return "" unless errors = object.errors.on(field)
        errors.map {|e| e.gsub(/#{field} /i, "") }.join(", ")
      end
      
      def error_class(object, field)
        object.errors.on(field).nil? ? "" : "with_errors"
      end
    end
  end
end
