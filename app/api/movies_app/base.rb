module MoviesApp
  class Base < Grape::API
    mount MoviesApp::V1::Movies
    mount MoviesApp::V1::Actors
  end
end