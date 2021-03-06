class SalonsController < ApplicationController

  def new
    @salon = Salon.new
  end

  def create
    @location = Location.find(params[:location_id])
    @salon = @location.salons.create(salon_params)
    # redirect_to location_path(@location)
    if @salon.save
      redirect_to @location
    else
      render 'new'
      # redirect_to @location
    end
  end

  def show
    # @location = Location.find(params[:location_id])
    @salon = Salon.find(params[:id])
  end

  def edit
    @salon = Salon.find(params[:id])
  end

  def destroy
    @location = Location.find(params[:location_id])
    @salon = @location.salons.find(params[:id])
    @salon.destroy
    redirect_to location_path(@location)
  end

  private
    def salon_params
      params.require(:salon).permit(:name, :topic, :detail_location, :time, :detail_info, :guests, :help, :about, :longitude, :latitude, :foreground_color, :background_color, :iBeacon)
    end
end
