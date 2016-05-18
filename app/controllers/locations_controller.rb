class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to @location
    else
      render 'new'
    end
  end

  def show
    @location = Location.find(params[:id])
    respond_to do |format|
      format.html { @location }
      format.xml  { render xml: @location }
      format.json { render json: @location }
    end
  end

  def index
    @locations = Location.all
    respond_to do |format|
      format.html { @locations }
      format.xml  { render xml: @locations }
      format.json { render json: @locations }
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to @location
    else
      render 'edit'
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    redirect_to locations_path
  end

  private
  def location_params
    params.require(:location).permit(:name, :password)
  end
end
