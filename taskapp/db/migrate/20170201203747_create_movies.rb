class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.integer :count
      t.string :director
      t.string :image

      t.timestamps
    end
  end
end
