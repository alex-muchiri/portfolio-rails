class ProjectsController < ApplicationController
	before_action :find_project, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@projects = Project.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params

		if @project.save
			redirect_to @project, notice: "Nice Muchiri! Your project was successfully saved!"
		else
			render 'new', notice: "Oh no, Muchiri! I was unable to save your project."
		end
	end

	def show

	end

	def edit
	end

	def update
		if @project.update project_params
			redirect_to @project, notice: "Hurray! Your article was successfully updated"
		else
			render 'edit'
		end
	end

	def destroy
		@project.destroy
		redirect_to projects_path
	end



	private

	def project_params
		params.require(:project).permit(:title, :description, :link, :image, :slug)
	end

	def find_project
		@project = Project.friendly.find(params[:id])
	end
end
