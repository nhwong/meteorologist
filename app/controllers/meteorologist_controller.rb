require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================
    google_api_url = "http://maps.googleapis.com/maps/api/geocode/json?address="
    dark_sky_url = "https://api.darksky.net/forecast/2ce3841872e63a6c9efcad040662259a/"
    full_google_url = google_api_url + @street_address_without_spaces
    google_hash = JSON.parse(open(full_google_url).read)
    latitude = google_hash["results"][0]["geometry"]["location"]["lat"]
    longitude = google_hash["results"][0]["geometry"]["location"]["lng"]
    full_dark_sky_url = dark_sky_url + latitude.to_s + "," + longitude.to_s
    dark_sky_hash = JSON.parse(open(full_dark_sky_url).read)

    @current_temperature = dark_sky_hash["currently"]["temperature"]

    @current_summary =  dark_sky_hash["currently"]["summary"]

    @summary_of_next_sixty_minutes = dark_sky_hash["minutely"]["summary"]

    @summary_of_next_several_hours = dark_sky_hash["hourly"]["summary"]

    @summary_of_next_several_days = dark_sky_hash["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
