module MoviesApp
  module V1
    class Actors < Grape::API
      version 'v1', using: :path

      resource :actors do

        desc 'Returns all actors.' do
          success code: 200, message: 'Found successfully'
        end
        get do
          Actor.all
        end

        desc 'Returns an actor.' do
          success [ code: 200, message: 'Found successfully' ]
          failure [ code: 404, message: 'Not found with this ID' ]
        end
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