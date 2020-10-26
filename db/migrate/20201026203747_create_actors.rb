class CreateActors < ActiveRecord::Migration[6.0]
  def change
    create_table :actors do |t|
      t.string :name
      t.date :dob

      t.timestamps
    end

    create_table :actors_movies, id: false do |t|
      t.belongs_to :actor
      t.belongs_to :movie
    end
  end
end
