class UsersController < ApplicationController
  def my_account
    @user = current_user
    @brains = @user.brains
    @bookings = @user.bookings
  end

  # def validate_booking
  #   @booking = Booking.find(params[:id])
  #   @booking.update(confirmation: true)
  #   redirect_to my_account_path, notice: 'La demande de location a été validée.'
  # end
end
