class BrainsController < ApplicationController
  before_action :set_brain, only: %i[show]

  def index
    @brains = Brain.all
  end

  def show
  end

  def new
    @brain = Brain.new
  end

  def create
    @brain =Brain.new(brain_params)
    @brain.user_id = set_user.id
    if @brain.save
      redirect_to brains_to_path()
    else
      render :new, status: :unprocessable_entity
    end
  end

  def my_brain
    @brain = Brain.find_by(user_id: current_user.id)
  end

  def destroy
    @brain = Brain.find_by(user_id: current_user.id)
    @brain.destroy
  end

  def set_brain
    @brain = Brain.find(params[:id])
  end

  def set_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  private

  def brain_params
    params.require(:brain).permit(:name, :price, :address, :latitude, :longitude)
  end
end
