# -*- coding: utf-8 -*-
require 'cinch'
require 'cinch/cooldown'
require 'time-lord'
require 'weather-underground'

module Cinch::Plugins
  # Cinch Plugin to report weather
  class Weatherman
    include Cinch::Plugin

    enforce_cooldown

    self.help = 'Use .w <location> to see information on the weather.'

    def initialize(*args)
      super
      @append = config[:append_forecast] || false
    end

    match(/(?:w|weather) (.+)/, method: :weather)
    match(/forecast (.+)/,      method: :forecast)

    def weather(m, query)
      m.reply get_weather(query)
    end

    def forecast(m, query)
      m.reply get_forecast(query)
    end

    private

    def get_weather(query)
      weather = Weather.new(query).to_s
      weather << " #{Forecast.new(query).append}" if true
      weather
    rescue ArgumentError
      "Sorry, couldn't find #{query}."
    end

    def get_forecast(query)
      Forecast.new(query).to_s
    rescue ArgumentError
      "Sorry, couldn't find #{query}."
    end
  end
end
