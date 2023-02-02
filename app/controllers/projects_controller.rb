class ProjectsController < ApplicationController

  before_action :set_project, only: [:edit,:update,:show,:destroy]
  before_action :authenticate_user!

  def index
    @project=Project.all
    if current_user.usertype == 'manager'
      @project=current_user.created_projects
    elsif current_user.usertype == 'developer'
      @project=current_user.assigned_projects
    elsif current_user.usertype == 'qa'
      @project=current_user.assigned_projects
    end
  end
    
  def new
    @project = Project.new
    # can? :create , @roject
    unless can? :create, @project
      flash[:alert] = "You are not allowed to create a project"
      redirect_to root_path
    end   
  end
    
  def create
    #@project =Project.new
    @project = Project.new(project_params)
    #@project = current_user
    #@project = current_user.id 
    @project.creator_id = current_user.id
    if @project.save
      flash[:success] = "Project was created Successfully"
      redirect_to projects_path
    else
      render 'new', status: :unprocessable_entity
    end
  end
    
  def edit
    unless can? :edit, @project
      flash[:danger] = "You cannot edit other user's project"
      redirect_to user_path(current_user)
    end
  end
    
  def update
    if @project.update(project_params)
      flash[:success] = "Your Project was updated successfully"
      redirect_to projects_path
    else
      render 'edit', status: :unprocessable_entity
      end
  end
    
  def show
    unless can? :show, @project
      flash[:danger] = "You are not allowed to view other user's projects"
      redirect_to projects_path
    end
  end
    
  def destroy
    if can? :destroy, @project
      #@project = Project.find(params[:id])
      @project = Project.find(params[:id]).destroy
      flash[:success] = "Project was deleted successfully"
      redirect_to projects_path
    else
      flash[:danger] = "You cannot delete other user's projects"
    end
  end
    
private
    
  def project_params
    params.require(:project).permit(:title, :description, user_ids: [])
  end
      
  def set_project
    @project = Project.find(params[:id])
  end
    
end