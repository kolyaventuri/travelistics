class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :code, limit: 2
      t.integer :side_of_road

      t.timestamps
    end
  end
end
