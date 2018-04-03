class CreateCountryLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :country_languages do |t|
      t.references :country, foreign_key: true
      t.references :language, foreign_key: true
    end
  end
end
