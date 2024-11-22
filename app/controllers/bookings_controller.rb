class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]

  # def myaccount
  #   @bookings = Booking.where(user_id: current_user.id)
  #   @bookings.each do |booking|
  #     booking.brain = Brain.find(booking.brain_id)
  #   end
  # end

  def show
    @booking = Booking.find(params[:id])
    @statut = @booking.confirmation ? "Confirmé" : "En attente"
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @booking.brain = Brain.find(params[:brain_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.brain = Brain.find(params[:brain_id])
    if @booking.save
      redirect_to booking_path(@booking), notice: "Demande de réservation effectuée avec succès"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def validate_booking

    # @bookings = Booking.joins(:brain).where(brains: { user_id: @user.id })
    @booking = Booking.find(params[:id])
    @booking.confirmation = true
    @booking.save
    redirect_to booking_path, notice: 'La demande de location a été validée.'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
