class ServicesController < ApplicationController
  respond_to :html, :json, :xml

  def index
    if params[:batiment_id] && @batiment = Batiment.find(params[:batiment_id])
      @services = @batiment.services
    else
      @services = Service.all
    end
    respond_with @services
  end

  def show
    @service = Service.find(params[:id])
    respond_with @service
  end

  def create
    @batiment = Batiment.find(params[:batiment_id])
    respond_with(@service = @batiment.services.create(params[:service]))
  end

  def update
    @service = Service.find(params[:id])
    @service.update_attributes(params[:service])
    respond_with [@service.batiment.campus, @service.batiment, @service]
  end

  def destroy
    @service = Service.find(params[:id])
    @batiment = @service.batiment
    @campus = @batiment.campus
    respond_with [@campus, @batiment, @service.destroy]
  end
end
