module Retrospect
  module Helpers
    module Urls
      def root_url
        @url ||= Addressable::URI.parse(base_url)
      end
      
      def root_path(path="")
        url(path).path
      end
      
      def project_url(project, *path)
        url("/" << [project.permalink, *path].flatten.join('/'))
      end
      
      def project_path(project, *path)
        project_url(project, path).path
      end
      
      private
        def url(path="")
          root_url.dup.tap { |url| url.path = root_url.path + path }
        end
        
        def base_url
          Retrospect.config[:base_uri] || ((respond_to?(:request) &&
            request.respond_to?(:url)) ? request.url : fail("set base_url"))
        end
    end
  end
end
