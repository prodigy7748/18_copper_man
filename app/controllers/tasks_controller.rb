class TasksController < ApplicationController
  before_action :find_task, only:[:edit, :update, :destroy, :show]

  def index
    if params[:sort]
      @tasks = Task.sorted_by(params[:sort]).page(params[:page])
    else
      @tasks = Task.filter(params.slice(:status, :title)).page(params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('tasks.create.notice')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('tasks.edit.notice')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('tasks.destroy.notice')
  end

  private
    def task_params
      params.require(:task).permit(:title, :content, :start_time, :end_time, :priority, :status)
    end

    def find_task
      @task = Task.find(params[:id])
    end
end
