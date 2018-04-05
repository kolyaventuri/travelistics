class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.bigint :origin_country_id
      t.bigint :destination_country_id

      t.timestamps
    end
  end
end
