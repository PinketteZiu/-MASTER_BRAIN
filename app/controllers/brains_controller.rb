class BrainsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  before_action :set_brain, only: %i[show]
  include Rails.application.routes.url_helpers

  def index
    if params[:query].present?
      @brains = Brain.search(params[:query])
    else
      @brains = Brain.all
    end
    @markers = @brains.geocoded.map do |brain|
      {
        lat: brain.latitude,
        lng: brain.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { brain: brain })
        # marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @brain = Brain.find(params[:id])
    @markers = [{
      lat: @brain.latitude,
      lng: @brain.longitude
    }]
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
    # else
    #   Rails.logger.debug "Brain save failed: #{@brain.errors.full_messages.join(', ')}"
    #   render :new, status: :unprocessable_entity
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
    params.require(:brain).permit(:name, :price, :address, :latitude, :longitude, :competence, :image)
  end
end
