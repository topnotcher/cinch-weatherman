# -*- coding: utf-8 -*-
module Cinch::Plugins
  class Weatherman
    include Cinch::Plugin

    enforce_cooldown

    self.help = "Use .w <location> to see information on the weather. (e.g. .w 94062)"

    match /weather (.*)/
    match /w (.*)/

    def execute(m, query)
      m.reply get_weather(query)
    end

    private

    def get_weather(query)
      @weather = WeatherUnderground::Base.new()
      weather_data = @weather.CurrentObservations(query)

      unless weather_data.temp_f == ""
        location = weather_data.display_location[0].full
        temp_f = weather_data.temp_f
        conditions = weather_data.weather.downcase
        last_updated = weather_data.observation_time.gsub(/Last Updated on/, "")
        last_updated_ago = Time.parse(last_updated).ago.to_words

        message = "In #{location} it is #{conditions} "
        message << "and #{temp_f}°F "
        message << "(last updated about #{last_updated_ago})"

        return message
      else
        return "Sorry, couldn't find #{query}."
      end
    end
  end
end
