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
    @user = current_user
    @brain = Brain.new(brain_params)
    @brain.user_id = current_user.id
    Rails.logger.debug "Brain before save: #{@brain.inspect}"
    if @brain.save
      redirect_to brains_path
    else
      Rails.logger.debug "Brain save failed: #{@brain.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @brain = Brain.find_by(user_id: current_user.id)
    @brain.destroy
  end

  def set_brain
    @brain = Brain.find(params[:id])
  end

  private

  def brain_params
    params.require(:brain).permit(:name, :price, :address, :latitude, :longitude)
  end
end
