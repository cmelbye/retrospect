module Retrospect
  class App < Sinatra::Default
    set :root,     File.dirname(__FILE__) + "/../.."
    set :app_file, __FILE__
    enable :sessions
    
    include Retrospect
    include Retrospect::Helpers
    
    get '/' do
      @projects = Project.all
      show :home, :title => "projects"
    end
    
    get '/new' do
      @project = Project.new
      show :new, :title => ["projects", "new project"]
    end
    
    post '/' do
      @project = Project.new(params[:project_data])
      
      if @project.save
        redirect project_url(@project).to_s
      else
        show :new, :title => ["projects", "new project"]
      end
    end
    
    get '/:project' do
      show :project, :title => ["projects", current_project.name]
    end
    
    put '/:project' do
      if current_project.update_attributes(params[:project_data])
        redirect project_url(current_project).to_s
      else
        show :new, :title => ["projects", current_project.name, "edit"]
      end
    end
    
    get '/:project/edit' do
      show :new, :title => ["projects", current_project.name, "edit"]
    end
    
    get '/retrospect.css' do
      response['Content-Type'] = "text/css; charset=utf-8"
      etag stylesheet_hash
      sass :retrospect
    end
  end
end
