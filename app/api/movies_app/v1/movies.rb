module MoviesApp
  module V1
    class Movies < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :movies do
        desc 'Return list of movies.'
        get do
          Movie.all
        end

        desc 'Return a movie.'
        params do
          requires :id, type: Integer, desc: 'Movie ID.'
          optional :include_actors, type: Boolean, default: false, desc: 'Includes list of actors if set to true.'
        end
        route_param :id do
          get do
            # using find_by over find to be able to test if movie is found without causing an exception
            # or should I instead rescue the exception and then map it to the status?
            movie = Movie.find_by(id: params[:id])
            if movie.present?
              if params[:include_actors]
                # if include_actors param was passed as true, get a hash of movie attrs and extend it with actors data
                # TODO was not sure what the default behavior should be - return actors or not, or make it two separate calls, so went with query param
                movieWithActors = movie.attributes
                movieWithActors[:actors] = movie.actors
                movieWithActors
              else
                # otherwise just send movie attributes as is without actors data
                movie
              end
            else
              error! :not_found, 404
            end
          end
        end

        desc 'Create a movie.'
        params do
          requires :title, type: String, desc: 'Movie title.'
          requires :year, type: Integer, desc: 'Movie year of creation.'
        end
        post do
          movie = Movie.new(title: params[:title], year: params[:year])

          if movie.save
            header 'Location', "#{request.url}/#{movie.id}"
            status 201
          else
            # TODO it can probably be 500. how to distinguish?
            error! :failed_to_create, 400
          end
        end

        desc 'Update a movie. Do NOT create a movie if id is not found.'
        params do
          requires :id, type: Integer, desc: 'Movie ID.'
          requires :title, type: String, desc: 'Movie title.'
          requires :year, type: Integer, desc: 'Movie year of creation.'
        end
        put ':id' do
          movie = Movie.find_by(id: params[:id])
          if movie.present?
            if movie.update({ title: params[:title], year: params[:year] })
              status 204
            else
              # TODO it can probably be 500. how to distinguish?
              error! :failed_to_update, 400
            end
          else
            error! :not_found, 404
          end
        end

        desc 'Delete a movie.'
        params do
          requires :id, type: Integer, desc: 'Movie ID.'
        end
        delete ':id' do
          movie = Movie.find_by(id: params[:id])
          if movie.present?
            movie.destroy
            status 204
          else
            error! :not_found, 404
          end
        end

        # TODO add methods to add/remove actors to/from the movie

      end
    end
  end
end