class UsersController < ApplicationController
  def my_account
    @user = current_user
    @brains = @user.brains
    @bookings = @user.bookings
    @offers = Booking.joins(:brain).where(brains: { user_id: @user.id })
  end

  def validate_booking
    @booking = Booking.find(params[:id])
    @booking.update(confirmation: true)
    redirect_to my_account_path, notice: 'La demande de location a été validée.'
  end
end
