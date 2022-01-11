class ProfilesController < ApplicationController
    include HomeHelper
    include ProfilesHelper

    before_action :logged_in_user, only: [:update]
    before_action :correct_user,   only: [:update]

    def new
        @profile = Profile.new
        2.times { @profile.experiences.build.projects.build }
    end

    def show
        @profile = Profile.find(params[:id])
    end

    def update
        updated_profile_params = update_array_attributes_in_params(profile_params)
        @profile = Profile.find(params[:id])
        if @profile.update(updated_profile_params)
            experiences = updated_profile_params[:experiences_attributes]
            if experiences
                experiences.each do |num, exp|
                    if Experience.exists?(exp[:id])
                        experience = Experience.find(exp[:id])
                        projects = exp[:projects_attributes]
                        if projects
                            projects.each do |num_project, proj|
                                if Project.exists?(proj[:id])
                                    project = Project.find(proj[:id])
                                    project.update(proj.except(:_destroy))
                                end
                            end
                        end
                    end
                end
            end
            flash[:success] = "Profile updated successfully."
            redirect_to edit_url
        else
            count_flash_msg = 0
            @profile.errors.full_messages.each do |m|
                flash[count_flash_msg] = m
                count_flash_msg = count_flash_msg + 1
            end
            flash[:danger] = "Profile update failed."
            redirect_to root_url
        end
    end

    def correct_user
        @profile = Profile.find(params[:id])
        @user = User.find(@profile.user_id)
        redirect_to(root_url) unless @user == current_user
    end

    private
        def profile_params
            params.require(:profile).permit(:name, :image, :job_title, :total_experience, :overview,
                :career_highlights, :primary_skills, :secondary_skills,
                :educations_attributes => [ :id, :school, :degree, :description, :start, :end, :_destroy],
                :experiences_attributes => [ :id, :company, :position, :description, :start, :end, :_destroy,
                                             :projects_attributes => [:id, :title, :project_url, :tech_stack, :description, :_destroy]]
            )
        end
end
