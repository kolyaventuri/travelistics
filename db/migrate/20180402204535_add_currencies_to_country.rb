class AddCurrenciesToCountry < ActiveRecord::Migration[5.1]
  def change
    add_reference :countries, :currency, foreign_key: true
  end
end
