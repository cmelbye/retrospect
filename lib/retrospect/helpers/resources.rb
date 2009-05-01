module Retrospect
  module Helpers
    module Resources
      def current_project
        @project ||= Project.first(:permalink => params[:project]) or raise Sinatra::NotFound
      end
    end
  end
end
