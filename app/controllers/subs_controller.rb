class SubsController < ApplicationController
  before_action :require_login, only: [:edit, :new, :create, :update]
  before_action :require_mod, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end

  end

  def new
    @sub = Sub.new
    render :new
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def require_mod
    @sub = Sub.find(params[:id])
    unless @sub.moderator_id == current_user.id
      flash[:error] = "You must be moderator to edit or update"
      redirect_to subs_url
    end
  end
end
