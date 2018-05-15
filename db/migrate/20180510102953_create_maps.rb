class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.string :summary_polyline
      t.string :polyline
      t.string :strava_id

      t.timestamps
    end
    add_index :maps, :strava_id
  end
end
