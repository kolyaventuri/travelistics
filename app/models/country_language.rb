class CountryLanguage < ApplicationRecord
  belongs_to :country, dependent: :destroy
  belongs_to :language, dependent: :destroy
end