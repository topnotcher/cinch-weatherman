# -*- coding: utf-8 -*-
module Cinch
  module Plugins
    class Weatherman
      # Class to manage information on future conditions
      class Forecast
        def initialize(location)
          @data = WeatherUnderground::Base.new.SimpleForecast(location).days[1]

          fail ArgumentError if @data.nil?

          @location = Weather.new(location).location
          @forecast = @data.conditions.downcase
          @temp_high_c = @data.high.celsius.round
          @temp_low_c = @data.low.celsius.round
          @temp_high_f = @data.high.fahrenheit.round
          @temp_low_f = @data.low.fahrenheit.round
          @temp_fmt = "%dF / %dC"
          @temp_high = "with a high of #{@temp_fmt}" % [@temp_high_f,@temp_high_c]
          @temp_low = "and a low of #{@temp_fmt}." % [@temp_low_f,@temp_low_c]
        end

        def to_s
          "Tommorrow in #{@location}; #{@forecast}, " \
          "#{@temp_high} #{@temp_low}"
        end

        def append
          to_s.gsub(" in #{@location}", '')
        end
      end
    end
  end
end
