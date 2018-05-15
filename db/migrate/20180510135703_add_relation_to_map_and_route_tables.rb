class AddRelationToMapAndRouteTables < ActiveRecord::Migration[5.1]
  def change
    add_reference :maps, :routes, foreign_key: true
  end
end
