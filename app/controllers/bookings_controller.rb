class BookingsController < ApplicationController

  def new
    booking = Booking.new
  end

  def create
    booking = Booking.new
    booking.user = @@user
    booking.flight_id = booking_params[:id]
    booking.seat = booking_params[:seatNumber]
    if booking.save
      render json: booking, :status => :created
    else
      render  json: { error: booking.errors.full_messages }, :status => :bad_request
    end
  end

  def destroy
    booking = @@user.bookings.find_by(flight_id: params[:id])
    if booking.destroy
      render json: { success: 'Booking deleted' }, :status => :ok
    else
      render json: { error: 'Unable to delete booking' }, :status => :bad_request
    end
  end
  
  private

  def booking_params
    params.require(:flightData).permit(:seatNumber, :id)
  end

end
