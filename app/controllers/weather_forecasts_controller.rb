class WeatherForecastsController < ApplicationController


  # GET /weather_forecasts/1 or /weather_forecasts/1.json
  # Show will be how we display the weather forecast for a specific zip code
  def show
    #Since we're utilizing the create action to handle the logic of generating or pulling the weather forecast,
    # we can rely on the forecast to exist in the cache
    # We'll rely on the create action to indicate whether the forecast was generated on this request or pulled from cache
    @weather_forecast = Rails.cache.fetch("weather_forecast/#{params[:id]}")
  end

  # GET /weather_forecasts/new
  # This will render the blank form for address entry
  def new
    #This action is solely here to render the form
  end

 
  # POST /weather_forecasts or /weather_forecasts.json
  # This will be the actual action that generates or pulls the weather forecast
  def create
    address = weather_forecast_params[:address]

    @weather_forecast = Rails.cache.fetch()

    respond_to do |format|
      if @weather_forecast.save
        format.html { redirect_to @weather_forecast, notice: "Weather forecast was successfully created." }
        format.json { render :show, status: :created, location: @weather_forecast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weather_forecast.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Since we're not using all the controller actions here, we'll skip the before_action callbacks and address the cache directly

    # Only allow a list of trusted parameters through.
    # We only have to accept the address param
    # Can either be a zip code or a full address
    # If we just get a zip, we can use a geocoding service to get latitude and longitude
    # If we get a full address, we can ascertain the zip code from that to determine cache status
    def weather_forecast_params
      params.expect(weather_forecast: [ :address ])
    end


end
