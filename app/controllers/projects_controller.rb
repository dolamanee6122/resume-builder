class ProjectsController < ApplicationController
    before_action :logged_in_user, only: [:new]
    before_action :get_experience

    def index
        @projects = @experience.projects
    end

    def new
        @experience.projects.create
        flash[:success] = "Project added."
        redirect_to edit_url
    end

    def create
        @project = @experience.projects.build(project_params)
    end

    private
        def get_experience
            @experience = Experience.find(params[:experience])
        end

end
