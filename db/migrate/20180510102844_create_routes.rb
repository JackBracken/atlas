class CreateRoutes < ActiveRecord::Migration[5.1]
  def change
    create_table :routes do |t|
      t.string :name
      t.string :description
      t.float :distance
      t.float :elevation_gain
      t.integer :sub_type
      t.integer :strava_id

      t.timestamps
    end
    add_index :routes, :strava_id
  end
end
