require 'grape-swagger'

module MoviesApp
  class Base < Grape::API
    format :json
    prefix :api

    mount MoviesApp::V1::Movies
    mount MoviesApp::V1::Actors

    # global exception handler
    rescue_from :all do |e|
      error!({ error: 'Internal server error.' }, 500, { 'Content-Type' => 'text/error' })
    end

    add_swagger_documentation api_version: 'v1',
                              format: :json,
                              info: {
                                  title: 'Movies App',
                                  description: 'Test app for learning Ruby on Rails (+grape, grape-swagger)'
                              }
  end
end