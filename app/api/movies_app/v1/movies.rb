module MoviesApp
  module V1
    class Movies < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :movies do
        desc 'Return a movie.'
        params do
          requires :id, type: Integer, desc: 'Movie ID.'
        end
        route_param :id do
          get do
            movie = Movie.find_by(id: params[:id])
            if movie.present?
              movie
            else
              error! :not_found, 404
            end
          end
        end
      end

      resource :movies do
        desc 'Return list of movies.'
        get do
          Movie.all
        end
      end

    end
  end
end