module MoviesApp
  module V1
    class Actors < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :actors do

        desc 'Return list of actors.'
        get do
          Actor.all
        end

        desc 'Return an actor.'
        params do
          requires :id, type: Integer, desc: 'Actor ID.'
          optional :include_movies, type: Boolean, default: false, desc: 'Includes list of movies if set to true'
        end
        route_param :id do
          get do
            actor = Actor.find_by(id: params[:id])
            if actor.present?
              if params[:include_movies]
                actorWithMovies = actor.attributes
                actorWithMovies[:movies] = actor.movies
                actorWithMovies
              else
                actor
              end
            else
              error! :not_found, 404
            end
          end
        end

        # TODO add methods

      end
    end
  end
end