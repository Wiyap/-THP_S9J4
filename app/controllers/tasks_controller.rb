class TasksController < ApplicationController
before_action :authenticate_user!
  def new
    @categories = Category.all
  end

  def create
    @task = Task.new(task_params)
    @category = Category.find(category_params)
    @task.category = @category
   respond_to do |format|
      format.html do
        if @task.save
          redirect_to root_path
          flash[:notice] = "Task created"
        else
          redirect_to root_path
          flash[:notice] = "Please try again"
        end
      end
      
      format.js do
        if @task.save
          flash[:notice] = "Task created"
        else
          flash[:notice] = "Please try again"
        end
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.all

  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to tasks_path
    flash[:notice] = "Task edited"
  end

  def index
    @tasks = Task.all
  end

  def destroy
    @task = Task.find(params[:id])
    @category = @task.category
    @category_task = Task.where(category_id: @task.category_id)
    @index_task = @category_task.index(@task)
    @task.destroy
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end

  private

  def task_params
    params.permit(:title, :deadline, :description)
  end

  def category_params
    params.require(:Category)
  end

end
