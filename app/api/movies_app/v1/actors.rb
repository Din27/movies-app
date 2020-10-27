module MoviesApp
  module V1
    class Actors < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :actors do
        desc 'Return an actor.'
        params do
          requires :id, type: Integer, desc: 'Actor ID.'
        end
        route_param :id do
          get do
            actor = Actor.find_by(id: params[:id])
            if actor.present?
              actor
            else
              error! :not_found, 404
            end
          end
        end
      end

      resource :actors do
        desc 'Return list of actors.'
        get do
          Actor.all
        end
      end

    end
  end
end