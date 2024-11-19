class OffersController < ApplicationController
  def index
    @offers = current_user.offers
  end
end
