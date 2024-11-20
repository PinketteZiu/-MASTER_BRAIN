class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @brains = Brain.all
  end

  def my_account
    @brains = current_user.brains
    @bookings = current_user.bookings
    @offers = current_user.offers
  end
end
