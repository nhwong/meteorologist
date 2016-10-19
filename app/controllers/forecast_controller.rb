require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    dark_sky_url = "https://api.darksky.net/forecast/2ce3841872e63a6c9efcad040662259a/"
    full_url = dark_sky_url + @lat.to_s + "," + @lng.to_s
    dark_sky_hash = JSON.parse(open(full_url).read)

    @current_temperature = dark_sky_hash["currently"]["temperature"]

    @current_summary =  dark_sky_hash["currently"]["summary"]

    @summary_of_next_sixty_minutes = dark_sky_hash["minutely"]["summary"]

    @summary_of_next_several_hours = dark_sky_hash["hourly"]["summary"]

    @summary_of_next_several_days = dark_sky_hash["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
