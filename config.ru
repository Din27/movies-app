# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# for some reason running Grape should go before running Rails.application, otherwise native Rails controllers will not work
MoviesApp::Base.compile!
run MoviesApp::Base

run Rails.application
